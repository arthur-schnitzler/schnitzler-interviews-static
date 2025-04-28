<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select="descendant::tei:titleStmt/tei:title[@level = 'a'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="'schnitzler-interviews'"/>
                </xsl:call-template>
            </head>
            <body class="page" style="background-color:#f1f1f1;">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    <div class="container">
                        <div class="row intro">
                            <div class="col-md-6 col-lg-6 col-sm-12 wp-intro_left">
                                <div class="intro_left">
                                    <h3 class="mt-3">Arthur Schnitzler</h3>
                                    <h1 class="mt-3" style="text-align: left;">»Das Zeitlose ist von
                                        kürzester Dauer«<br/>Interviews, Meinungen, Proteste</h1>
                                    <h3 class="mt-3">1891–1931</h3>
                                    <h4 style="font-style: italic">Herausgegeben von Martin Anton
                                        Müller</h4>
                                    <h4><a href="https://www.wallstein-verlag.de/9783835354715-das-zeitlose-ist-von-kuerzester-dauer.html" target="_blank">Göttingen: Wallstein Verlag,
                                        Oktober 2023</a></h4>
                                    <p>Das Open-Accesss PDF kann kostenfrei <a
                                            href="https://e-book.fwf.ac.at/o:1882">hier</a> und
                                        <a href="https://e-book.fwf.ac.at/o:1881">hier</a>
                                         geladen werden.</p>
                                    <p/>
                                    <div style="text-align: right">
                                        <a href="#body">
                                            <button class="btn btn-round"
                                                style="background-color: #3D5A80; color: white;"
                                                >Weiter</button>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6 col-sm-12">
                                <div class="intro_right wrapper">
                                    <img src="images/beide.jpg" class="d-block w-100"
                                        style="max-width=30%;"
                                        alt="Buchumschlag"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container-fluid" style="margin:2em auto;" id="body">
                        <div style="max-width: 650px; margin: auto;">
                            <span style="display: block;
                                position: relative;
                                top: -250px; visibility: hidden"
                                id="body"/>
                            <p class="mt-3">Arthur Schnitzler gab angeblich keine Interviews,
                                vermied es, Umfragen zu beantworten und äußerte sich nicht
                                öffentlich. Doch über 180 weitgehend vergessene, bislang unerforschte
                                Texte widerlegen diese Behauptung und bieten ein neues Bild seiner
                                öffentlichen Person. Die Interviews, Meinungsäußerungen und
                                Leserbriefe belegen Schnitzlers Bedeutung als Leserbriefschreiber
                                und Interviewpartner für seine Zeitgenossinnen und Zeitgenossen. </p>
                            <p class="mt-3">Martin Anton Müllers Edition der »Interviews, Meinungen
                                und Proteste« Schnitzlers stellt eine »öffentliche Biografie« dar,
                                die dokumentiert, was man schon zu Lebzeiten von der Privatperson
                                Schnitzlers wissen konnte. Nachlasszeugnisse zu jedem Text geben
                                Auskunft darüber, wie Schnitzler selbst dazu stand. Der Kommentar
                                klärt über Fakten auf, stellt Zusammenhänge her und trennt falsche
                                von richtigen Informationen. Ein Nachwort schafft eine
                                Überblicksdarstellung und ein umfangreiches Register erleichtert den
                                Zugang zum Material. </p>
                            <p class="mt-3">Insgesamt ergibt sich aus dieser Edition ein
                                überraschendes Bild des berühmten Autors Arthur Schnitzler, der
                                entgegen seiner angeblichen Zurückhaltung, in der Öffentlichkeit ein
                                engagierter und eloquenter Gesprächspartner und Schriftsteller war. </p>
                            <a href="I001.html">
                                <button class="btn btn-round">Lesen</button>
                            </a>
                            <span>&#160;&#160;&#160;&#160;</span>
                            <a href="E_nachwort.html">
                                <button class="btn btn-round">Zum Nachwort</button>
                            </a>
                        </div>
                    </div>
                    <div class="container-fluid" style="margin:2em auto;">
                        <div class="row wrapper img_bottom">
                            <div class="col-md-6 col-lg-6 col-sm-12">
                                <a href="toc.html" class="index-link">
                                    <div class="card index-card">
                                        <div class="card-body">
                                            <img class="d-block w-100"
                                                src="https://shared.acdh.oeaw.ac.at/schnitzler-briefe/img/korrespondenzen.jpg"
                                                title="Quelle: ANNO, Die Bühne, datum=19310315"
                                                alt="Schnitzlers Arbeitstisch"/>
                                        </div>
                                        <div class="card-header">
                                            <h4>Interviews, Meinungen, Proteste </h4>
                                            <p>Zum Inhaltsverzeichnis</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-6 col-lg-6 col-sm-12">
                                <a href="calendar.html" class="index-link">
                                    <div class="card index-card">
                                        <div class="card-body">
                                            <img class="d-block w-100"
                                                src="https://shared.acdh.oeaw.ac.at/schnitzler-briefe/img/calendar.jpg"
                                                title="Detail aus http://www.ifm-wolfen.de/index.php?id=110005000534 CC BY-NC-SA"
                                                alt="Kalenderdetail"/>
                                        </div>
                                        <div class="card-header">
                                            <h4>Kalender</h4>
                                            <p>Interviews nach Erscheinungsdatum des Erstdrucks finden.</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-6 col-lg-6 col-sm-12">
                                <a href="listperson.html" class="index-link">
                                    <div class="card index-card">
                                        <div class="card-body">
                                            <img class="d-block w-100"
                                                src="https://shared.acdh.oeaw.ac.at/schnitzler-briefe/img/persons.jpg"
                                                title="Zwei der Kinder von Felix Salten, aus einem Brief von Salten an Schnitzler, Cambridge University Library"
                                                alt="Zwei der Kinder von Felix Salten, aus einem Brief von diesem an Schnitzler, Cambridge University Library"
                                            />
                                        </div>
                                        <div class="card-header">
                                            <h4>Personen</h4>
                                            <p>In den Korrespondenzstücken erwähnte Personen.</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-6 col-lg-6 col-sm-12">
                                <a href="listbibl.html" class="index-link">
                                    <div class="card index-card">
                                        <div class="card-body">
                                            <img class="d-block w-100"
                                                src="https://shared.acdh.oeaw.ac.at/schnitzler-briefe/img/werke.jpg"
                                                title="Nahaufnahme von Buchrücken CC BY 0"
                                                alt="Nahaufnahme von Buchrücken"/>
                                        </div>
                                        <div class="card-header">
                                            <h4>Werkverzeichnis</h4>
                                            <p>Erwähnte literarische wie
                                                nicht-literarische Werke.</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-6 col-lg-6 col-sm-12">
                                <a href="listplace.html" class="index-link">
                                    <div class="card index-card">
                                        <div class="card-body">
                                            <img class="d-block w-100"
                                                src="https://shared.acdh.oeaw.ac.at/schnitzler-briefe/img/places.jpg"
                                                alt="Stadtplan von Wien innerhalb des Gürtels, Beilage zum Meyers Konversationslexikon von 1905."
                                                title="Stadtplan von Wien innerhalb des Gürtels, Beilage zum Meyers Konversationslexikon von 1905."
                                            />
                                        </div>
                                        <div class="card-header">
                                            <h4>Orte</h4>
                                            <p>In den Texten erwähnte geografische
                                                Orte. Diese sind auch über ihre Koordinaten
                                                erschlossen.</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-6 col-lg-6 col-sm-12">
                                <a href="listorg.html" class="index-link">
                                    <div class="card index-card">
                                        <div class="card-body">
                                            <img class="d-block w-100"
                                                src="https://shared.acdh.oeaw.ac.at/schnitzler-briefe/img/org.jpg"
                                                title="Briefkopf d’Ora" alt="Briefkopf d’Ora"/>
                                        </div>
                                        <div class="card-header">
                                            <h4>Institutionen und Organisationen</h4>
                                            <p>In den Texten erwähnte Verlage,
                                                Redaktionen, Vereine, Gesellschaften, Firmen, Preise
                                                …</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-6 col-lg-6 col-sm-12">
                                <a href="https://github.com/arthur-schnitzler" class="index-link">
                                    <div class="card index-card">
                                        <div class="card-body">
                                            <img class="d-block w-100"
                                                src="https://shared.acdh.oeaw.ac.at/schnitzler-briefe/img/schnitzler-github.jpg"
                                                title="Schnitzler Repositories auf Github"
                                                alt="Schnitzler Repositories auf Github"/>
                                        </div>
                                        <div class="card-header">
                                            <p>Quelldaten dieser Webseite auf GitHub</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <!--<div class="col-md-6 col-lg-6 col-sm-12">
                                <a href="search.html" class="index-link">
                                    <div class="card index-card">
                                        <div class="card-body">
                                            <img src="images/example-img-1.jpg"
                                                class="d-block w-100" alt="..."/>
                                        </div>
                                        <div class="card-header">
                                            <p> Datenbanksuche </p>
                                        </div>
                                    </div>
                                </a>
                            </div>-->
                        </div>
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:div//tei:head">
        <h2 id="{generate-id()}">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    <xsl:template match="tei:p">
        <p id="{generate-id()}">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:list">
        <ul id="{generate-id()}">
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="tei:item">
        <li id="{generate-id()}">
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="starts-with(data(@target), 'http')">
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
