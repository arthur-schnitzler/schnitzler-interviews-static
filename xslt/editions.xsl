<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:local="http://dse-static.foo.bar"
    xmlns:mam="whatever" version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>
    <xsl:import href="./partials/shared.xsl"/>
    <xsl:import href="./partials/refs.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <!--<xsl:import href="./partials/aot-options.xsl"/>-->
    <xsl:import href="./partials/html_title_navigation.xsl"/>
    <xsl:import href="./partials/view-type.xsl"/>
    <xsl:import href="./partials/entities.xsl"/>
    <xsl:import href="./partials/schnitzler-tage.xsl"/>
    <xsl:variable name="quotationURL">
        <xsl:value-of
            select="concat('https://schnitzler-interviews.acdh.oeaw.ac.at/', replace(tokenize(base-uri(), '/')[last()], '.xml', '.html'))"
        />
    </xsl:variable>
    <xsl:variable name="currentDate">
        <xsl:value-of select="format-date(current-date(), '[D1].&#160;[M1].&#160;[Y4]')"/>
    </xsl:variable>
    <xsl:variable name="quotationString">
        <xsl:value-of
            select="concat(normalize-space(//tei:titleStmt/tei:title[@level = 'a']), '. In: Arthur Schnitzler: Briefwechsel mit Autorinnen und Autoren. Digitale Edition. Hg. Martin Anton Müller, Gerd Hermann Susen und Laura Untner, ', $quotationURL, ' (Abfrage ', $currentDate, ')')"
        />
    </xsl:variable>
    <xsl:variable name="teiSource">
        <xsl:value-of select="data(tei:TEI/@xml:id)"/>
    </xsl:variable>
    <xsl:variable name="teiDoc">
        <xsl:value-of select="concat(data(tei:TEI/@xml:id), '.xml')"/>
    </xsl:variable>
    <xsl:variable name="source_pdf">
        <xsl:value-of select="concat(tei:TEI/@xml:id, '.pdf')"/>
    </xsl:variable>
    <xsl:variable name="link">
        <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="doc_title">
        <xsl:value-of select=".//tei:titleSmt/tei:title[@level = 'a'][1]/text()"/>
    </xsl:variable>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:titleSmt/tei:title[@level = 'a'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"/>
                </xsl:call-template>
                <style>
                    .navBarNavDropdown ul li:nth-child(2) {
                        display: none !important;
                    }
                    
                    a {
                        color: black;
                    }</style>
                <meta name="Date of publication" class="staticSearch_date">
                    <xsl:attribute name="content">
                        <xsl:value-of
                            select="//tei:titleStmt/tei:title[@type = 'iso-date']/@when-iso"/>
                    </xsl:attribute>
                    <xsl:attribute name="n">
                        <xsl:value-of select="//tei:titleStmt/tei:title[@type = 'iso-date']/@n"/>
                    </xsl:attribute>
                </meta>
                <meta name="docImage" class="staticSearch_docImage">
                    <xsl:attribute name="content">
                        <!--<xsl:variable name="iiif-ext" select="'.jp2/full/,200/0/default.jpg'"/> -->
                        <xsl:variable name="iiif-ext"
                            select="'.jpg?format=iiif&amp;param=/full/,200/0/default.jpg'"/>
                        <xsl:variable name="iiif-domain"
                            select="'https://iiif.acdh-dev.oeaw.ac.at/iiif/images/schnitzler-briefe/'"/>
                        <xsl:variable name="facs_id" select="concat(@type, '_img_', generate-id())"/>
                        <xsl:variable name="facs_item" select="descendant::tei:pb[1]/@facs"/>
                        <xsl:value-of select="concat($iiif-domain, $facs_item, $iiif-ext)"/>
                    </xsl:attribute>
                </meta>
                <meta name="docTitle" class="staticSearch_docTitle">
                    <xsl:attribute name="content">
                        <xsl:value-of select="//tei:titleStmt/tei:title[@level = 'a']"/>
                    </xsl:attribute>
                </meta>
            </head>
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    <div class="container-fluid">
                        <div class="wp-transcript">
                            <div class="card" data-index="true">
                                <div class="card-header">
                                    <xsl:call-template name="header-nav">
                                        <xsl:with-param name="next"
                                            select="concat(tei:TEI/@next, '.html')"/>
                                        <xsl:with-param name="prev"
                                            select="concat(tei:TEI/@prev, '.html')"
                                        />
                                    </xsl:call-template>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="card-body-normalertext" style="background-color: #3D5A80; color: black;">
                                    <p>
                                        <i>Diese Seite ist ein Platzhalter, von der sich nur die
                                            bibliografischen Angaben des Textes und die Erwähnungen
                                            von Personen, Orten, Werken und Institutionen entnehmen
                                            lassen. Die Buchausgabe ist in Verlagsproduktion. Der
                                            Text wird im Oktober 2023 als zweibändige Ausgabe
                                            veröffentlicht:</i>
                                    </p>
                                    <ul style="list-style-type: none;">
                                        <li>
                                            <b>Arthur Schnitzler: »Das Zeitlose ist von kürzester
                                                Dauer«. Interviews, Meinungen, Proteste (1891–1931).
                                                Hg. Martin Anton Müller. Göttingen: Wallstein
                                                2023</b>
                                            <br/>
                                            <br/>
                                            <i>ca. 760 Seiten, circa 25 Abbildungen, gebunden, Schutzumschlag<br/>2
                                                Bände im Schuber<br/> circa € 44,– (D); € 45,30
                                                (A)<br/>ISBN 978-3-8353-5471-5</i>
                                        </li>
                                    </ul>
                                    <p/>
                                </div>
                                <p/>
                                <div class="card-body-normalertext">
                                    <legend>Erwähnte Personen</legend>
                                    <ul>
                                        <xsl:for-each select="descendant::tei:back/tei:listPerson/tei:person">
                                            <xsl:sort
                                                select="concat(child::tei:persName[1]/tei:surname[1], child::tei:persName[1]/tei:forename[1])"/>
                                            <xsl:variable name="naname" as="xs:string">
                                                <xsl:choose>
                                                  <xsl:when
                                                  test="child::tei:persName[1]/tei:surname[1] and child::tei:persName[1]/tei:forename[1]">
                                                  <xsl:value-of
                                                  select="concat(child::tei:persName[1]/tei:surname[1], ' ', child::tei:persName[1]/tei:forename[1])"
                                                  />
                                                  </xsl:when>
                                                  <xsl:when
                                                  test="child::tei:persName[1]/tei:forename[1]">
                                                  <xsl:value-of select="child::tei:forename[1]"/>
                                                  </xsl:when>
                                                  <xsl:when test="child::tei:surname[1]">
                                                  <xsl:value-of select="child::tei:surname[1]"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:value-of
                                                  select="normalize-space(child::tei:persName[1])"/>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:variable>
                                            <li>
                                                <a class="theme-color">
                                                  <xsl:attribute name="href">
                                                  <xsl:value-of
                                                  select="concat(data(@xml:id), '.html')"/>
                                                  </xsl:attribute>
                                                  <xsl:value-of select="$naname"/>
                                                </a>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </div>
                                <div class="card-body-normalertext">
                                    <xsl:if test=".//tei:back/tei:listBibl/tei:bibl[1]">
                                        <legend>Erwähnte Werke</legend>
                                        <ul>
                                            <xsl:for-each select="descendant::tei:back/tei:listBibl/tei:bibl">
                                                <xsl:sort select="child::tei:title[1]"/>
                                                <li>
                                                  <a class="theme-color">
                                                  <xsl:attribute name="href">
                                                  <xsl:value-of
                                                  select="concat(data(@xml:id), '.html')"/>
                                                  </xsl:attribute>
                                                  <xsl:if
                                                  test="child::tei:author[@role = 'hat-geschaffen' or @role = 'author']">
                                                  <xsl:for-each
                                                  select="child::tei:author[@role = 'hat-geschaffen' or @role = 'author']">
                                                  <xsl:sort
                                                  select="concat(., child::tei:surname[1], child::tei:forename[1])"/>
                                                  <xsl:choose>
                                                  <xsl:when
                                                  test="child::tei:surname[1] or child::tei:forename[1]">
                                                  <xsl:choose>
                                                  <xsl:when
                                                  test="child::tei:surname[1] and child::tei:forename[1]">
                                                  <xsl:value-of
                                                  select="concat(child::tei:surname[1], ' ', child::tei:forename[1])"
                                                  />
                                                  </xsl:when>
                                                  <xsl:when test="child::tei:forename[1]">
                                                  <xsl:value-of select="child::tei:forename[1]"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:value-of select="child::tei:surname[1]"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                  <xsl:if test="position() != last()">
                                                  <xsl:text>, </xsl:text>
                                                  </xsl:if>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:value-of select="."/>
                                                  <xsl:if test="position() != last()">
                                                  <xsl:text>; </xsl:text>
                                                  </xsl:if>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                  <xsl:if test="position() = last()">
                                                  <xsl:text>: </xsl:text>
                                                  </xsl:if>
                                                  </xsl:for-each>
                                                  </xsl:if>
                                                  <xsl:value-of select="./tei:title[1]"/>
                                                  </a>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </xsl:if>
                                </div>
                                <div class="card-body-normalertext">
                                    <xsl:if test="descendant::tei:back/tei:listOrg/tei:org[1]">
                                        <legend>Erwähnte Institutionen</legend>
                                        <ul>
                                            <xsl:for-each select="descendant::tei:back/tei:listOrg/tei:org">
                                                <xsl:sort select="child::tei:orgName[1]"/>
                                                <li>
                                                  <a class="theme-color">
                                                  <xsl:attribute name="href">
                                                  <xsl:value-of
                                                  select="concat(data(@xml:id), '.html')"/>
                                                  </xsl:attribute>
                                                  <xsl:value-of select="./tei:orgName[1]"/>
                                                  </a>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </xsl:if>
                                </div>
                                <div class="card-body-normalertext">
                                    <xsl:if test="descendant::tei:back/tei:listPlace/tei:place[1]">
                                        <legend>Erwähnte Orte</legend>
                                        <ul>
                                            <xsl:for-each select="descendant::tei:back/tei:listPlace/tei:place">
                                                <xsl:sort select="child::tei:placeName[1]"/>
                                                <li>
                                                  <a class="theme-color">
                                                  <xsl:attribute name="href">
                                                  <xsl:value-of
                                                  select="concat(data(@xml:id), '.html')"/>
                                                  </xsl:attribute>
                                                  <xsl:value-of
                                                  select="child::tei:placeName[1]/text()"/>
                                                  </a>
                                                  <xsl:if
                                                  test="child::tei:placeName[@type = 'alternative-name' or contains(@type, 'namensvariante')][1]">
                                                  <xsl:text> (</xsl:text>
                                                  <xsl:for-each
                                                  select="distinct-values(child::tei:placeName[@type = 'alternative-name' or contains(@type, 'namensvariante')])">
                                                  <xsl:value-of select="normalize-space(.)"/>
                                                  <xsl:if test="position() != last()">
                                                  <xsl:text>, </xsl:text>
                                                  </xsl:if>
                                                  </xsl:for-each>
                                                  <xsl:text>)</xsl:text>
                                                  </xsl:if>
                                                  <xsl:if
                                                  test="child::tei:location[@type = 'coords']">
                                                  <xsl:text> </xsl:text>
                                                  <xsl:variable name="mlat"
                                                  select="replace(tokenize(tei:location[@type = 'coords'][1]/tei:geo, ' ')[1], ',', '.')"
                                                  as="xs:string"/>
                                                  <xsl:variable name="mlong"
                                                  select="replace(tokenize(tei:location[@type = 'coords'][1]/tei:geo, ' ')[2], ',', '.')"
                                                  as="xs:string"/>
                                                  <xsl:variable name="mappin"
                                                  select="concat('mlat=',$mlat, '&amp;mlon=', $mlong)"
                                                  as="xs:string"/>
                                                  <xsl:variable name="openstreetmapurl"
                                                  select="concat('https://www.openstreetmap.org/?', $mappin, '#map=12/', $mlat, '/', $mlong)"/>
                                                  <a class="theme-color">
                                                  <xsl:attribute name="href">
                                                  <xsl:value-of select="$openstreetmapurl"/>
                                                  </xsl:attribute>
                                                  <xsl:attribute name="target">
                                                  <xsl:text>_blank</xsl:text>
                                                  </xsl:attribute>
                                                  <xsl:attribute name="rel">
                                                  <xsl:text>noopener</xsl:text>
                                                  </xsl:attribute>
                                                  <i class="fa-solid fa-location-dot"/>
                                                  </a>
                                                  </xsl:if>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </xsl:if>
                                </div>
                            </div>
                            <div class="card-footer" style="clear: both;">
                                <nav class="navbar navbar-expand-lg" style="box-shadow: none;">
                                    <div class="container-fluid">
                                        <div id="navbarSupportedContent">
                                            <ul class="navbar-nav mb-2 mb-lg-0" id="secondary-menu">
                                                <li class="nav-item"> &#160;<a href="#"
                                                  data-bs-target="#ueberlieferung" type="button"
                                                  data-bs-toggle="modal">
                                                  <i class="fas fa-landmark"/> ÜBERLIEFERUNG
                                                  </a>&#160; </li>
                                                <li class="nav-item"> &#160;<a href="#"
                                                  data-bs-target="#tagfuertag" type="button"
                                                  data-bs-toggle="modal">
                                                  <i class="fas fa-calendar-day"/>
                                                  KALENDERTAG</a>&#160; </li>
                                                <!--<li class="nav-item dropdown">
                                    <span class="nav-link">
                                        <div id="csLink" class="a.grau" data-correspondent-1-name=""
                                            data-correspondent-1-id="all"
                                            data-correspondent-2-name="" data-correspondent-2-id=""
                                            data-start-date="{$datum}" data-end-date=""
                                            data-range="50" data-selection-when="before-after"
                                            data-selection-span="median-before-after"
                                            data-result-max="4" data-exclude-edition=""/>
                                    </span>
                                </li>-->
                                            </ul>
                                        </div>
                                    </div>
                                </nav>
                                <xsl:if
                                    test="descendant::tei:note[@type = 'textConst' or @type = 'commentary']">
                                    <div class="card-body-anhang">
                                        <dl class="kommentarhang">
                                            <xsl:apply-templates
                                                select="descendant::tei:note[@type = 'textConst' or @type = 'commentary']"
                                                mode="kommentaranhang"/>
                                        </dl>
                                    </div>
                                </xsl:if>
                            </div>
                            <xsl:call-template name="html_footer"/>
                        </div>
                    </div>
                </div>
                <!-- Modal -->
                <div class="modal fade" id="ueberlieferung" tabindex="-1"
                    aria-labelledby="ueberlieferungLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLongTitle1">
                                    <xsl:for-each
                                        select="//tei:fileDesc/tei:titleStmt/tei:title[@level = 'a']">
                                        <xsl:apply-templates/>
                                        <br/>
                                    </xsl:for-each>
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Schließen"/>
                            </div>
                            <div class="modal-body">
                                <table class="table table-striped">
                                    <tbody>
                                        <xsl:for-each select="//tei:correspAction">
                                            <tr>
                                                <th>
                                                  <xsl:choose>
                                                  <xsl:when test="@type = 'sent'"> Versand: </xsl:when>
                                                  <xsl:when test="@type = 'received'"> Empfangen: </xsl:when>
                                                  <xsl:when test="@type = 'forwarded'">
                                                  Weitergeleitet: </xsl:when>
                                                  <xsl:when test="@type = 'redirected'"> Umgeleitet: </xsl:when>
                                                  <xsl:when test="@type = 'delivered'"> Zustellung: </xsl:when>
                                                  <xsl:when test="@type = 'transmitted'">
                                                  Übermittelt: </xsl:when>
                                                  </xsl:choose>
                                                </th>
                                                <td> </td>
                                                <td>
                                                  <xsl:if test="./tei:date">
                                                  <xsl:value-of select="./tei:date"/>
                                                  <br/>
                                                  </xsl:if>
                                                  <xsl:if test="./tei:persName">
                                                  <xsl:value-of select="./tei:persName"
                                                  separator="; "/>
                                                  <br/>
                                                  </xsl:if>
                                                  <xsl:if test="./tei:placeName">
                                                  <xsl:value-of select="./tei:placeName"
                                                  separator="; "/>
                                                  <br/>
                                                  </xsl:if>
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </table>
                                <br/>
                                <!-- Modal Überlieferung -->
                                <div class="modal-body">
                                    <xsl:for-each select="//tei:witness">
                                        <h5>TEXTZEUGE <xsl:value-of select="@n"/>
                                        </h5>
                                        <table class="table table-striped">
                                            <tbody>
                                                <xsl:if test="tei:msDesc/tei:msIdentifier">
                                                  <tr>
                                                  <th>Signatur </th>
                                                  <td>
                                                  <xsl:for-each
                                                  select="tei:msDesc/tei:msIdentifier/child::*">
                                                  <xsl:value-of select="."/>
                                                  <xsl:if test="not(position() = last())">
                                                  <xsl:text>, </xsl:text>
                                                  </xsl:if>
                                                  </xsl:for-each>
                                                  </td>
                                                  </tr>
                                                </xsl:if>
                                                <xsl:if test="//tei:physDesc">
                                                  <tr>
                                                  <th>Beschreibung </th>
                                                  <td>
                                                  <xsl:apply-templates
                                                  select="tei:msDesc/tei:physDesc/tei:objectDesc"/>
                                                  </td>
                                                  </tr>
                                                  <xsl:if
                                                  test="tei:msDesc/tei:physDesc/tei:typeDesc">
                                                  <xsl:apply-templates
                                                  select="tei:msDesc/tei:physDesc/tei:typeDesc"/>
                                                  </xsl:if>
                                                  <xsl:if
                                                  test="tei:msDesc/tei:physDesc/tei:handDesc">
                                                  <xsl:apply-templates
                                                  select="tei:msDesc/tei:physDesc/tei:handDesc"/>
                                                  </xsl:if>
                                                  <xsl:if
                                                  test="tei:msDesc/tei:physDesc/tei:additions">
                                                  <tr>
                                                  <th/>
                                                  <th>Zufügungen</th>
                                                  </tr>
                                                  <xsl:apply-templates
                                                  select="tei:msDesc/tei:physDesc/tei:additions"/>
                                                  </xsl:if>
                                                </xsl:if>
                                            </tbody>
                                        </table>
                                    </xsl:for-each>
                                    <xsl:for-each select="//tei:biblStruct">
                                        <h5>DRUCK <xsl:value-of select="position()"/>
                                        </h5>
                                        <table class="table table-striped">
                                            <tbody>
                                                <tr>
                                                  <th/>
                                                  <td>
                                                  <xsl:value-of
                                                  select="mam:bibliografische-angabe(.)"/>
                                                  </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </xsl:for-each>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary"
                                    data-bs-dismiss="modal">Schließen</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal Zitat -->
                <!-- Modal Qualität -->
                <!-- Modal Entitäten -->
                <!-- Einstellungen Modal -->
                <!-- Modal Tag -->
                <div class="modal fade" id="tagfuertag" tabindex="-1"
                    aria-labelledby="downloadModalLabel2" aria-hidden="true">
                    <xsl:variable name="datum">
                        <xsl:variable name="date"
                            select="descendant::tei:titleStmt/tei:title[@when-iso][1]" as="node()?"/>
                        <xsl:choose>
                            <xsl:when test="$date/@when-iso">
                                <xsl:value-of select="$date/@when-iso"/>
                            </xsl:when>
                            <xsl:when test="$date/@notBefore">
                                <xsl:value-of select="$date/@notBefore"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$date/@notAfter"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="datum-written" select="
                            format-date($datum, '[D1].&#160;[M1].&#160;[Y0001]',
                            'en',
                            'AD',
                            'EN')"/>
                    <xsl:variable name="wochentag">
                        <xsl:choose>
                            <xsl:when test="
                                    format-date($datum, '[F]',
                                    'en',
                                    'AD',
                                    'EN') = 'Monday'">
                                <xsl:text>Montag</xsl:text>
                            </xsl:when>
                            <xsl:when test="
                                    format-date($datum, '[F]',
                                    'en',
                                    'AD',
                                    'EN') = 'Tuesday'">
                                <xsl:text>Dienstag</xsl:text>
                            </xsl:when>
                            <xsl:when test="
                                    format-date($datum, '[F]',
                                    'en',
                                    'AD',
                                    'EN') = 'Wednesday'">
                                <xsl:text>Mittwoch</xsl:text>
                            </xsl:when>
                            <xsl:when test="
                                    format-date($datum, '[F]',
                                    'en',
                                    'AD',
                                    'EN') = 'Thursday'">
                                <xsl:text>Donnerstag</xsl:text>
                            </xsl:when>
                            <xsl:when test="
                                    format-date($datum, '[F]',
                                    'en',
                                    'AD',
                                    'EN') = 'Friday'">
                                <xsl:text>Freitag</xsl:text>
                            </xsl:when>
                            <xsl:when test="
                                    format-date($datum, '[F]',
                                    'en',
                                    'AD',
                                    'EN') = 'Saturday'">
                                <xsl:text>Samstag</xsl:text>
                            </xsl:when>
                            <xsl:when test="
                                    format-date($datum, '[F]',
                                    'en',
                                    'AD',
                                    'EN') = 'Sunday'">
                                <xsl:text>Sonntag</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>DATUMSFEHLER</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLongTitle3">
                                    <a
                                        href="{concat('https://schnitzler-tage.acdh.oeaw.ac.at/', $datum, '.html')}"
                                        target="_blank" style="color: #C67F53">
                                        <xsl:value-of
                                            select="concat($wochentag, ', ', $datum-written)"/>
                                    </a>
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Schließen"/>
                            </div>
                            <div class="modal-body">
                                <div id="tag-fuer-tag-modal-body"/>
                                <xsl:call-template name="mam:schnitzler-tage">
                                    <xsl:with-param name="datum-iso" select="$datum"/>
                                    <xsl:with-param name="teiSource" select="$teiSource"/>
                                </xsl:call-template>
                                <!--
                                    <xsl:variable name="fetchUrl"
                                    select="concat('https://schnitzler-tage.acdh.oeaw.ac.at/', $datum, '.json')"/>
                                    <script type="text/javascript" src="js/schnitzler-tage.js" charset="UTF-8"/>
                                <script type="text/javascript">
                                    fetch('<xsl:value-of select="$fetchUrl"/>').then(function (response) {return response.json();
                                    }).then(function (data) {
                                    appendData(data, '<xsl:value-of select="$teiSource"/>');
                                }). catch (function (err) {
                                    console.log('error: ' + err);
                                });</script>-->
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary"
                                    data-bs-dismiss="modal">Schließen</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Download Modal -->
                <div class="modal fade" id="downloadModal" tabindex="-1"
                    aria-labelledby="downloadModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLongTitle4"
                                    >Downloadmöglichkeiten</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Schließen"/>
                            </div>
                            <div class="modal-body">
                                <p>
                                    <a class="ml-3" data-toggle="tooltip" title="Brief als PDF">
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$source_pdf"/>
                                        </xsl:attribute><i class="fa-lg far fa-file-pdf"/> PDF </a>
                                </p>
                                <p>
                                    <a class="ml-3" data-toggle="tooltip"
                                        title="Brief als TEI-Datei">
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$teiDoc"/>
                                        </xsl:attribute>
                                        <i class="fa-lg far fa-file-code"/> TEI </a>
                                </p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary"
                                    data-bs-dismiss="modal">Schließen</button>
                            </div>
                        </div>
                    </div>
                </div>
                <script src="https://unpkg.com/de-micro-editor@0.2.6/dist/de-editor.min.js"/>
                <script type="text/javascript" src="js/run.js"/>
            </body>
        </html>
    </xsl:template>
    <!-- Regeln für Elemente -->
    <xsl:template match="tei:address">
        <div class="column">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:addrLine">
        <div class="addrLine">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:back"/>
    <xsl:template match="tei:text">
        <xsl:apply-templates select="descendant::tei:listPerson"/>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#kaufmannsund']">
        <xsl:text>&amp;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#tilde']">~</xsl:template>
    <xsl:template match="tei:c[@rendition = '#geschwungene-klammer-auf']">
        <xsl:text>{</xsl:text>
    </xsl:template>
    <xsl:template match="tei:cell">
        <xsl:element name="td">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:damage">
        <span class="damage-critical">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:date[@*]">
        <!-- <abbr><xsl:attribute name="title"><xsl:value-of select="data(./@*)"/></xsl:attribute>-->
        <xsl:apply-templates/>
        <!--</abbr>-->
    </xsl:template>
    <xsl:template match="tei:div[not(@type = 'address')]">
        <div class="div">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:div[@type = 'address']">
        <div class="address-div">
            <xsl:apply-templates/>
        </div>
        <br/>
    </xsl:template>
    <xsl:template match="tei:gap">
        <xsl:choose>
            <xsl:when test="@reason = 'deleted'">
                <span class="del gap">
                    <xsl:attribute name="alt">
                        <xsl:value-of select="data(@reason)"/>
                    </xsl:attribute>
                    <xsl:text>[</xsl:text>
                    <xsl:apply-templates/>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>
            <xsl:when test="@reason = 'illegible'">
                <span class="gap">
                    <xsl:attribute name="alt">
                        <xsl:value-of select="data(@reason)"/>
                    </xsl:attribute>
                    <xsl:text>[</xsl:text>
                    <xsl:apply-templates/>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:gap[@unit = 'chars' and @reason = 'illegible']">
        <span class="illegible">
            <xsl:value-of select="mam:gaps(@quantity)"/>
        </span>
    </xsl:template>
    <xsl:function name="mam:gaps">
        <xsl:param name="anzahl"/>
        <xsl:text>×</xsl:text>
        <xsl:if test="$anzahl &gt; 1">
            <xsl:value-of select="mam:gaps($anzahl - 1)"/>
        </xsl:if>
    </xsl:function>
    <xsl:template match="tei:gap[@unit = 'lines' and @reason = 'illegible']">
        <div class="illegible">
            <xsl:text> [</xsl:text>
            <xsl:value-of select="@quantity"/>
            <xsl:text> Zeilen unleserlich] </xsl:text>
        </div>
    </xsl:template>
    <xsl:template match="tei:gap[@reason = 'outOfScope']">
        <span class="outOfScope">[…]</span>
    </xsl:template>
    <!-- Überschriften -->
    <xsl:template match="tei:head">
        <xsl:if test="@xml:id[starts-with(., 'org') or starts-with(., 'ue')]">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
            </a>
        </xsl:if>
        <a>
            <xsl:attribute name="name">
                <xsl:text>hd</xsl:text>
                <xsl:number level="any"/>
            </xsl:attribute>
            <xsl:text> </xsl:text>
        </a>
        <h3>
            <div>
                <xsl:apply-templates/>
            </div>
        </h3>
    </xsl:template>
    <xsl:template match="tei:hi">
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="@rend = 'underline'">
                        <xsl:choose>
                            <xsl:when test="@n = '1'">
                                <xsl:text>underline</xsl:text>
                            </xsl:when>
                            <xsl:when test="@n = '2'">
                                <xsl:text>doubleUnderline</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>tripleUnderline</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@rend"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="tei:l">
        <xsl:apply-templates/>
        <br/>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    <xsl:template match="tei:lg">
        <span style="display:block;margin: 1em 0;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:lg[@type = 'poem' and not(descendant::lg[@type = 'stanza'])]">
        <div class="poem ">
            <ul>
                <xsl:apply-templates/>
            </ul>
        </div>
    </xsl:template>
    <xsl:template match="tei:lg[@type = 'poem' and descendant::lg[@type = 'stanza']]">
        <div class="poem ">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:lg[@type = 'stanza']">
        <ul>
            <xsl:apply-templates/>
        </ul>
        <xsl:if test="not(position() = last())">
            <br/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:list">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <!--    footnotes -->
    <xsl:template match="tei:note[@type = 'footnote']">
        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:text>fna_</xsl:text>
                <xsl:number level="any" format="1" count="tei:note[@type = 'footnote']"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#fn</xsl:text>
                <xsl:number level="any" format="1" count="tei:note[@type = 'footnote']"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:attribute>
            <sup>
                <xsl:number level="any" format="1" count="tei:note[@type = 'footnote'][./tei:p]"/>
            </sup>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:opener">
        <div class="opener">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template
        match="tei:p[ancestor::tei:body and not(ancestor::tei:note) and not(ancestor::tei:footNote) and not(ancestor::tei:caption) and not(parent::tei:bibl) and not(parent::tei:quote) and not(child::tei:space[@dim])] | tei:dateline | tei:closer">
        <xsl:choose>
            <xsl:when test="child::tei:seg">
                <div class="">
                    <span class="seg-left">
                        <xsl:apply-templates select="tei:seg[@rend = 'left']"/>
                    </span>
                    <xsl:text> </xsl:text>
                    <span class="seg-right">
                        <xsl:apply-templates select="tei:seg[@rend = 'right']"/>
                    </span>
                </div>
            </xsl:when>
            <xsl:when test="@rend = 'right'">
                <div align="right" class="">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@rend = 'left'">
                <div align="left" class="">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@rend = 'center'">
                <div align="center" class="">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@rend = 'inline'">
                <div class="inline ">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div class="">
                    <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:p[child::tei:space[@dim] and not(child::*[2]) and empty(text())]">
        <br/>
    </xsl:template>
    <xsl:template match="tei:p[parent::tei:quote]">
        <xsl:apply-templates/>
        <xsl:if test="not(position() = last())">
            <xsl:text> / </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template
        match="tei:p[not(parent::tei:quote) and (ancestor::tei:note or ancestor::tei:note[@type = 'footnote'] or ancestor::tei:caption or parent::tei:bibl)]">
        <xsl:choose>
            <xsl:when test="@rend = 'right'">
                <div align="right">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@rend = 'left'">
                <div align="left">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@rend = 'center'">
                <div align="center">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@rend = 'inline'">
                <div style="inline">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div>
                    <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:persName[@key | @ref]">
        <xsl:element name="a">
            <xsl:attribute name="class">reference</xsl:attribute>
            <xsl:attribute name="data-type">listperson.xml</xsl:attribute>
            <xsl:attribute name="data-key">
                <xsl:value-of select="@key"/>
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:placeName[@key | @ref]">
        <xsl:element name="a">
            <xsl:attribute name="class">reference</xsl:attribute>
            <xsl:attribute name="data-type">listplace.xml</xsl:attribute>
            <xsl:attribute name="data-key">
                <xsl:value-of select="@key"/>
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:quote">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:row">
        <xsl:element name="tr">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:rs[(@ref or @key) and (ancestor::tei:rs)]">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template
        match="tei:rs[not(ancestor::tei:rs) and not(descendant::tei:rs) and not(contains(@ref, ' '))] | tei:persName | tei:author | tei:placeName | tei:orgName">
        <xsl:variable name="entity-typ" as="xs:string">
            <xsl:choose>
                <xsl:when test="@type = 'person'">
                    <xsl:text>persons</xsl:text>
                </xsl:when>
                <xsl:when test="@type = 'work'">
                    <xsl:text>works</xsl:text>
                </xsl:when>
                <xsl:when test="@type = 'place'">
                    <xsl:text>places</xsl:text>
                </xsl:when>
                <xsl:when test="@type = 'org'">
                    <xsl:text>orgs</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <span>
            <xsl:attribute name="class">
                <xsl:value-of select="$entity-typ"/>
            </xsl:attribute>
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:value-of select="concat(replace(@ref, '#', ''), '.html')"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </span>
    </xsl:template>
    <xsl:template match="tei:rs[.//tei:rs or contains(@ref, ' ')]">
        <xsl:variable name="modalId">
            <xsl:value-of
                select="replace(normalize-space(string-join(.//@ref[starts-with(., '#')], '___')), '#', '')"
            />
        </xsl:variable>
        <xsl:element name="a">
            <xsl:attribute name="class">
                <xsl:text>reference-black</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="data-toggle">modal</xsl:attribute>
            <xsl:attribute name="data-target">
                <xsl:value-of select="concat('#', $modalId)"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    <xsl:template
        match="tei:rs[@type = 'work' and not(ancestor::tei:quote) and ancestor::tei:note and not(@subtype = 'implied')]/text()">
        <span class="works {substring-after(@rendition, '#')}" id="{@xml:id}">
            <span class="italics">
                <xsl:value-of select="."/>
            </span>
        </span>
    </xsl:template>
    <xsl:template match="tei:salute[parent::tei:opener]">
        <p class="salute">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:salute[not(parent::tei:opener)]">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:signed">
        <div class="signed ">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:space">
        <span class="space">
            <xsl:value-of select="
                    string-join((for $i in 1 to @quantity
                    return
                        '&#x00A0;'), '')"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:space[@unit = 'chars' and @quantity = '1']">
        <xsl:text> </xsl:text>
    </xsl:template>
    <xsl:template match="tei:space[@unit = 'line']">
        <xsl:value-of select="mam:spaci-space(@quantity, @quantity)"/>
    </xsl:template>
    <xsl:template match="tei:space[@unit = 'chars' and not(@quantity = 1)]">
        <xsl:variable name="weite" select="0.5 * @quantity"/>
        <xsl:element name="span">
            <xsl:attribute name="style">
                <xsl:value-of select="concat('display:inline-block; width: ', $weite, 'em; ')"/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:space[@dim = 'vertical' and not(@unit)]">
        <xsl:element name="div">
            <xsl:attribute name="style">
                <xsl:value-of select="concat('padding-bottom:', @quantity, 'em;')"/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
    <!-- Tabellen -->
    <xsl:template match="tei:table">
        <xsl:element name="table">
            <xsl:if test="@xml:id">
                <xsl:attribute name="id">
                    <xsl:value-of select="data(@xml:id)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="class">
                <xsl:text>table </xsl:text>
            </xsl:attribute>
            <xsl:element name="tbody">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:function name="mam:dots">
        <xsl:param name="anzahl"/> . <xsl:if test="$anzahl &gt; 1">
            <xsl:value-of select="mam:dots($anzahl - 1)"/>
        </xsl:if>
    </xsl:function>
    <xsl:strip-space elements="tei:quote"/>
</xsl:stylesheet>
