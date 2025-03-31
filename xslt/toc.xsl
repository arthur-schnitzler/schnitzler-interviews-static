<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:import href="./partials/tabulator_js.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title" select="'Alle Briefe'"/>
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"/>
            </xsl:call-template>
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    <div class="container-fluid">
                        <div class="card">
                            <div class="card-header">
                                <h1>Alle Texte</h1>
                            </div>
                            <div class="card-body">
                                <table class="table table-sm display" id="tabulator-table" style="width:100%"
                                    >
                                    <thead>
                                        <tr>
                                            <th scope="col" tabulator-headerFilter="input" tabulator-formatter="html">Titel</th>
                                            <th scope="col" tabulator-headerFilter="input" tabulator-formatter="html">Verfasser_in</th>
                                            <th scope="col" tabulator-headerFilter="input">Datum (ISO)</th>
                                            <th scope="col" tabulator-headerFilter="input">Art</th>
                                            <th scope="col" tabulator-headerFilter="input">ID</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:variable name="collection" select="collection('../data/editions/?select=*.xml')"/>
                                        <xsl:for-each
                                            select="$collection/tei:TEI">
                                            <xsl:variable name="full_path">
                                                <xsl:value-of select="document-uri(/)"/>
                                            </xsl:variable>
                                            <tr>
                                                <td>
                                                  <sortdate hidden="true">
                                                  <xsl:value-of
                                                  select="descendant::tei:titleStmt/tei:title[@type = 'iso-date']/@when-iso"
                                                  /><xsl:text>;</xsl:text>
                                                  </sortdate>
                                                  <a>
                                                  <xsl:attribute name="href">
                                                  <xsl:value-of
                                                  select="replace(tokenize($full_path, '/')[last()], '.xml', '.html')"
                                                  />
                                                  </xsl:attribute>
                                                  <xsl:value-of
                                                  select="descendant::tei:titleStmt/tei:title[@level = 'a'][1]/text()"
                                                  />
                                                  </a>
                                                </td>
                                                <td>
                                                  <xsl:for-each
                                                      select="descendant::tei:titleStmt/tei:author">
                                                  <a>
                                                  <xsl:attribute name="href">
                                                  <xsl:value-of
                                                      select="concat(replace(@ref, '#', ''), '.html')"
                                                  />
                                                  </xsl:attribute>
                                                  <xsl:value-of select="."/>
                                                  </a>
                                                  <xsl:if test="not(position() = last())">
                                                  <xsl:text>; </xsl:text>
                                                  </xsl:if>
                                                  </xsl:for-each>
                                                </td>
                                                <td>
                                                  <xsl:value-of
                                                  select="descendant::tei:titleStmt/tei:title[@type = 'iso-date']/@when-iso"
                                                  />
                                                </td>
                                                <td>
                                                  <xsl:choose>
                                                      <xsl:when test="starts-with(@xml:id, 'I')">
                                                          <xsl:text>Interview</xsl:text>
                                                      </xsl:when>
                                                      <xsl:when test="starts-with(@xml:id, 'M')">
                                                          <xsl:text>Meinungsäußerung</xsl:text>
                                                      </xsl:when>
                                                      <xsl:when test="starts-with(@xml:id, 'P')">
                                                          <xsl:text>Protestschreiben</xsl:text>
                                                      </xsl:when>
                                                  </xsl:choose>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="@xml:id"/>
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </table> <xsl:call-template name="tabulator_dl_buttons"/>
                            </div>
                        </div>
                    </div>
                    <xsl:call-template name="html_footer"/>
                    <xsl:call-template name="tabulator_js"/>
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
