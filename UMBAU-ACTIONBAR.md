# Umbau: Sekundärmenü → Action-Bar (nach Vorbild schnitzler-briefe-static)

Vergleich der Implementierung mit `../schnitzler-briefe-static` (Stand 2026-07-13).
Jeder Schritt ist einzeln umsetzbar und testbar. Nach jedem Schritt: eine
Editionsseite neu transformieren und im Browser prüfen.

**Projektfarbe interviews:** `#3D5A80` (Briefe verwenden `#A63437` – bei allen
kopierten CSS-Regeln ersetzen). Dunklere Variante für Border: `#2e4560`
(analog zu `#8a2a2d` bei den Briefen).

---

## Ausgangslage (interviews)

- Sekundärmenü liegt **unter dem Text** im `card-footer`:
  `xslt/editions.xsl`, ca. Z. 176–222 (`<ul id="secondary-menu">`).
- Einträge: ENTWURF, ÜBERLIEFERUNG, ENTITÄTEN, ZITIEREN, DOWNLOAD, CHRONIK –
  alle öffnen Bootstrap-**Modals**, die am Seitenende definiert sind.
- Blätterfunktion (vor/zurück) sitzt als Chevrons links/rechts **neben dem
  Seitentitel** (`xslt/partials/html_title_navigation.xsl`, Template `header-nav`,
  einfache `@prev`/`@next`-Links).

## Zielbild (briefe)

- Sticky **Action-Bar** in Projektfarbe direkt unter der Navbar:
  `../schnitzler-briefe-static/xslt/editions.xsl`, Z. 242–273.
- Buttons öffnen **Drawer-Panels**, die unter der Bar aufklappen
  (kein Modal): ebd. Z. 274–750, JS Z. 751–790.
- Blätterpfeile sitzen **rechts in der Action-Bar** (`.gap` + `.neighbors`).
- CSS: `../schnitzler-briefe-static/html/css/style.css`, Z. 2495–2586
  (Action-Bar), Z. 2665–2806 (Drawer), Z. 2808–2850 (Mobile).

---

## Schritt 1: CSS für Action-Bar und Drawer übernehmen ✅ (erledigt 2026-07-13)

**Datei:** `html/css/style.css`

1. Aus `../schnitzler-briefe-static/html/css/style.css` folgende Blöcke ans
   Ende von `html/css/style.css` kopieren:
   - `/* Action-Bar (zweites Menü unter der Navbar) */` … (Z. 2495–2586)
   - `/* Drawer unter der Action-Bar */` … (Z. 2665–2806:
     `.drawer-backdrop`, `.action-drawer`, `.drawer-inner`, `.drawer-panel`,
     `.drawer-grid`, `.transmission-layout`, `.setting-group`, `.meta-caption`,
     `.biblio-angabe`, `.cite-block`, `.download-list`)
   - `/* Action-Bar und Drawer auf kleinen Bildschirmen */` (Z. 2808–2850)
2. Farben ersetzen: `#A63437` → `#3D5A80`, `#8a2a2d` → `#2e4560`,
   `rgba(166, 52, 55, …)` → `rgba(61, 90, 128, …)`.
3. Den `.transmission-layout`- und `.setting-group`-Block nur übernehmen,
   wenn Schritt 5/6 geplant sind (schadet aber nicht).

**Test:** Seite neu laden – noch keine sichtbare Änderung (CSS ohne Markup).

---

## Schritt 2: Action-Bar-Markup einfügen (noch mit den bestehenden Modals) ✅ (erledigt 2026-07-13)

**Datei:** `xslt/editions.xsl`

Der kleinste funktionierende Zwischenschritt: Die Leiste wandert nach oben,
die Buttons öffnen weiterhin die vorhandenen Bootstrap-Modals.

1. Direkt nach `<xsl:call-template name="nav_bar"/>` (Z. 114) einfügen:

   ```xml
   <nav class="action-bar" id="actionBar" aria-label="Werkzeuge und Blättern">
       <div class="inner">
           <xsl:if test="not(descendant::tei:teiHeader[1]/tei:revisionDesc[1]/@status = 'approved')">
               <button type="button" class="draft-badge" data-bs-target="#qualitaet"
                   data-bs-toggle="modal">Entwurf</button>
           </xsl:if>
           <button type="button" data-bs-target="#ueberlieferung" data-bs-toggle="modal">
               <i class="fas fa-landmark"/>
               <xsl:text> Überlieferung</xsl:text>
           </button>
           <button type="button" data-bs-target="#entitaeten" data-bs-toggle="modal">
               <i class="fas fa-sharp fa-solid fa-people-group"/>
               <xsl:text> Entitäten</xsl:text>
           </button>
           <button type="button" data-bs-target="#zitat" data-bs-toggle="modal">
               <i class="fas fa-quote-right"/>
               <xsl:text> Zitieren</xsl:text>
           </button>
           <button type="button" data-bs-target="#downloadModal" data-bs-toggle="modal">
               <i class="fas fa-solid fa-download"/>
               <xsl:text> Download</xsl:text>
           </button>
           <button type="button" data-bs-target="#schnitzler-chronik-modal" data-bs-toggle="modal">
               <i class="fas fa-calendar-day"/>
               <xsl:text> Chronik</xsl:text>
           </button>
           <span class="gap"/>
           <!-- Blätterpfeile folgen in Schritt 3 -->
       </div>
   </nav>
   ```

   Hinweis: Die Pfeil-Indikatoren (`::after`-Chevron) der Briefe-CSS hängen am
   Selektor `button[data-drawer]` – solange die Buttons Modals öffnen, fehlen
   sie. Das ist für diesen Zwischenschritt in Ordnung.

2. Im `card-footer` (Z. 176–222) das komplette `<nav>` mit
   `<ul id="secondary-menu">` **entfernen**. Die `card-footer`-Blöcke für
   ZEUGNISSE und KOMMENTAR bleiben.

**Test:** Editionsseite bauen (`./transform.sh` bzw. `ant -f build.xml`).
Leiste erscheint sticky unter der Navbar, alle sechs Funktionen öffnen wie
bisher ihre Modals; unter dem Text ist das Menü verschwunden.

---

## Schritt 3: Blätterfunktion in die Action-Bar verlegen ✅ (erledigt 2026-07-13, inkl. Navbar-z-index-Fix aus Schritt 6.1)

**Dateien:** `xslt/partials/html_title_navigation.xsl`, `xslt/editions.xsl`

Interviews nutzen einfache `@prev`/`@next`-Attribute (keine Dropdown-Auswahl
wie bei den Briefen) – es reichen zwei schlichte Links.

1. In `html_title_navigation.xsl` ein neues Template ergänzen:

   ```xml
   <xsl:template name="header-nav-arrows">
       <span class="neighbors">
           <xsl:if test="child::tei:TEI/@prev">
               <a href="{child::tei:TEI/@prev}.html" title="Vorheriger Text"
                   aria-label="Vorheriger Text">
                   <i class="fas fa-chevron-left"/>
               </a>
           </xsl:if>
           <xsl:if test="child::tei:TEI/@next">
               <a href="{child::tei:TEI/@next}.html" title="Nächster Text"
                   aria-label="Nächster Text">
                   <i class="fas fa-chevron-right"/>
               </a>
           </xsl:if>
       </span>
   </xsl:template>
   ```

   Achtung Kontext: In den Briefen wird das Template aus `match="/"` heraus
   aufgerufen; hier ebenso – `child::tei:TEI/@prev` funktioniert nur, wenn der
   Aufruf im Dokumentknoten-Kontext erfolgt (wie bei `header-nav` bisher).

2. Das bestehende `header-nav`-Template auf reine Titelzeile reduzieren
   (Vorbild Briefe): die beiden Chevron-Spalten (`col-md-2`) entfernen,
   nur `<h1>` mit dem Titel behalten (volle Breite, zentriert).

3. In `editions.xsl` in der Action-Bar nach `<span class="gap"/>` einfügen:
   `<xsl:call-template name="header-nav-arrows"/>`.

4. CSS-Ergänzung in `style.css` (die Briefe-Variante stylt Buttons im
   Dropdown; hier sind es direkte Links):

   ```css
   .action-bar .neighbors a {
       display: inline-flex;
       align-items: center;
       padding: 11px 14px;
       color: #fff;
   }
   .action-bar .neighbors a:hover {
       background: rgba(255, 255, 255, .1);
   }
   ```

**Test:** Pfeile erscheinen rechts in der Leiste und blättern korrekt;
neben dem Titel gibt es keine Pfeile mehr.

---

## Schritt 4 (optional, empfohlen): Modals → Drawer-Panels ✅ (erledigt 2026-07-13, alle sechs Panels)

Das eigentliche Briefe-Erlebnis: Panels klappen unter der Bar auf, der Text
bleibt sichtbar. Panel für Panel umstellbar – Drawer und Modals können
parallel existieren.

**Datei:** `xslt/editions.xsl`

1. Nach dem `</nav>` der Action-Bar das Drawer-Gerüst einfügen
   (Vorbild `../schnitzler-briefe-static/xslt/editions.xsl`, Z. 274–278):

   ```xml
   <div class="drawer-backdrop" id="drawerBackdrop"/>
   <div class="action-drawer" id="drawer" role="region" aria-label="Werkzeuge">
       <div class="drawer-inner">
           <!-- Panels kommen hierher -->
       </div>
   </div>
   ```

2. Das Drawer-JS aus den Briefen übernehmen (ebd. Z. 751–790, der
   `<script>`-Block „Action-Bar-Drawer") – unverändert lauffähig.

3. Panel für Panel umziehen. Muster pro Panel:
   - Button in der Action-Bar umstellen von
     `data-bs-target="#zitat" data-bs-toggle="modal"` auf
     `data-drawer="cite" aria-expanded="false"`.
   - Inhalt des Modal-Bodys in ein `<div class="drawer-panel" data-panel="cite">`
     verschieben, mit Kopfzeile:
     `<h3>Zitieren <button type="button" class="close" data-close="">schließen ✕</button></h3>`.
   - Das alte Modal-`<div class="modal fade">` löschen.
   - Sinnvolle Panel-Namen analog Briefe: `quality`, `transmission`,
     `entities` (gibt es bei den Briefen nicht als Panel – Name frei),
     `cite`, `download`, `chronik`.
   - Reihenfolge-Empfehlung (aufsteigende Komplexität):
     1. `quality` (nur ein Absatz)
     2. `cite`
     3. `download`
     4. `transmission`
     5. `entities`
     6. `chronik` (lädt Chronik-Daten – prüfen, ob das bisherige Modal
        Lazy-Loading-JS hat, das am Event `drawer:open` neu aufgehängt
        werden muss; Vorbild: Leaflet-Init der Briefe, Z. 440–462)

4. Wenn alle Panels umgezogen sind: prüfen, dass keine verwaisten
   Modal-Definitionen mehr am Seitenende stehen.

**Test nach jedem Panel:** Button öffnet/schließt das Panel, `Esc` und
Backdrop (mobil) schließen, nur ein Panel gleichzeitig offen.

---

## Schritt 5 (optional): Gestaltung von Zitieren/Download angleichen ✅ (erledigt 2026-07-13 – cite-block, meta-caption, download-list-Pills; Click-to-copy fehlt noch, dafür wäre copy-to-clipboard.js aus den Briefen zu übernehmen)

Die Briefe-Panels nutzen eigene Klassen, die mit Schritt 1 schon im CSS sind:

- Zitat-Block: `<blockquote class="cite-block citation-quote">` mit
  Click-to-copy (`onclick="copyToClipboard(this)"` – Funktion aus den
  Briefen übernehmen, falls hier nicht vorhanden).
- Abschnittsüberschriften: `<div class="meta-caption">Empfohlene Zitierweise</div>`.
- Download-Links als Pills: `<div class="download-list">` mit
  `<a>`/`<a class="secondary">`.

Vorbild: `../schnitzler-briefe-static/xslt/editions.xsl`, Z. 612–697.

---

## Schritt 6 (optional): Weitere Verfeinerungen aus den Briefen

In empfohlener Reihenfolge, jeweils unabhängig:

1. **Navbar-Barrierefreiheit** (`xslt/partials/html_navbar.xsl`):
   `role="navigation"`, `aria-label="Hauptnavigation"`, `aria-label` am
   Logo-Link, `id` + `aria-labelledby` an allen Dropdowns,
   `aria-haspopup="true"`, `width`/`height` am Logo-`<img>` (verhindert
   Layout-Shift), `z-index: 1050` an der Navbar (sonst überlagert die
   sticky Action-Bar die aufgeklappten Navbar-Dropdowns!).

2. **Semantik in `editions.xsl`**: `<main class="wp-transcript">` statt
   `<div class="wp-transcript">`, Inhalt als `<article>`;
   Footer-Aufruf aus dem `container-fluid` heraus ans Ende von
   `#page` verschieben (wie bei den Briefen und wie hier in
   `listperson.xsl` bereits gelöst).

3. **Doppelt verschachteltes Markup bereinigen**: In `editions.xsl`
   Z. 121–163 ist im `otherwise`-Zweig ein zweites
   `<div id="container-resize">`/`card-body` ineinander verschachtelt
   (doppelte `id="container-resize"` ist zudem invalides HTML) – auf eine
   Ebene reduzieren. Außerdem werden die Fußnoten doppelt ausgegeben
   (einmal im `choose`, einmal danach Z. 168–170) – eine der beiden
   `<ol class="list-for-footnotes">` entfernen.

4. **Kommentare als gestaltete Anmerkungs-Sektion**: statt
   `<dl class="kommentarhang">` die Briefe-Struktur
   `<section class="annotations">` mit `annotations-head` + Zähler
   (Briefe-`editions.xsl` Z. 941–967, CSS `.annotations-head`/`.anno`
   Z. 2588–2663). Erfordert Anpassung des Templates
   `mode="kommentaranhang"` in `xslt/partials/commentary.xsl` auf das
   `.anno`-Grid (Lemma links, Text rechts).

5. **Entitäten unter den Text statt ins Modal/Panel**: Briefe zeigen
   Personen/Werke/Orte/Institutionen als `<section class="entities-foot">`
   mit Toggle-Schaltern, die Erwähnungen im Text hervorheben
   (Briefe-`editions.xsl` Z. 968 ff., CSS `.entities-foot`/`.ent-group`).
   Größter Einzelposten, da das Zusammenspiel mit `entities.xsl` und dem
   Hervorhebungs-JS nötig ist – zuletzt angehen.

6. **Breadcrumbs mit Typ-Pill** über dem Titel
   (`<nav class="crumbs">` + `<span class="type-pill">`, Briefe Z. 793–902):
   für Interviews z. B. Pill = Texttyp, Pfad = `toc.html` / Textnummer.

7. **Performance/Konsistenz**: Bootstrap/jQuery mit `defer` in den
   `<head>` (`html_head.xsl`) statt am Ende des Footers laden
   (Briefe-Footer: „Scripts already loaded in head with defer");
   Footer in semantisches `<footer>`-Element wickeln.

---

## Betroffene Dateien (Überblick)

| Datei | Schritte |
|---|---|
| `html/css/style.css` | 1, 3, 6.4, 6.5 |
| `xslt/editions.xsl` | 2, 3, 4, 5, 6.2, 6.3, 6.4, 6.5, 6.6 |
| `xslt/partials/html_title_navigation.xsl` | 3 |
| `xslt/partials/html_navbar.xsl` | 6.1 |
| `xslt/partials/html_footer.xsl` | 6.7 |
| `xslt/partials/html_head.xsl` | 6.7 |
| `xslt/partials/commentary.xsl` | 6.4 |

Andere Seitentypen (`listperson.xsl`, `toc.xsl`, …) sind nicht betroffen –
die Action-Bar existiert nur auf Editionsseiten.
