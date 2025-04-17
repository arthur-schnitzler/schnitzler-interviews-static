<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:import href="partials/shared.xsl"/>
    <!--<xsl:import href="partials/tei-facsimile.xsl"/>-->
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select="descendant::tei:titleStmt/tei:title[@level = 'a'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html lang="de" style="hyphens: auto;" xml:lang="de">
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"/>
            </xsl:call-template>
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    <div>
                        <div class="card">
                            <div class="card-header">
                                <h2 align="center">
                                    Verzeichnis der Interviewfragen
                                </h2>
                            </div>
                            <div class="card-body-anhang">
                                <p class="mb-3">In Abwandlung eines Sachregisters werden die tatsächlichen und mutmaßlichen Fragen verzeichnet, auf die Schnitzler in seinen Interviews antwortet
                                    oder zumindest zu antworten scheint. Verwandte Fragen wurden teilweise
                                    verallgemeinert, um Variationen derselben Frage zu vermeiden.</p>
                                
                                    <xsl:apply-templates select="//tei:list"/>
                            </div>
                        </div>
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:list">
        <div class="accordion custom-full-width-accordion" id="faqAccordion"> 
            <xsl:for-each-group select="tei:item[tei:note]" group-by="@ana">
                <xsl:sort select="." lang="de"/>
                <xsl:variable name="category" select="current-grouping-key()"/>
                <xsl:variable name="category-id"
                    select="translate($category, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ äöüÄÖÜß()/?!.', 'abcdefghijklmnopqrstuvwxyz-aeoeueaeoeuess-------')"/>
                <div class="accordion-item">
                    <h2 class="accordion-header" id="heading-{$category-id}">
                        <button class="accordion-button collapsed" type="button"
                            data-bs-toggle="collapse" data-bs-target="#collapse-{$category-id}"
                            aria-expanded="false" aria-controls="collapse-{$category-id}">
                            <xsl:value-of select="$category"/>
                        </button>
                    </h2>
                    <div id="collapse-{$category-id}" class="accordion-collapse collapse"
                        aria-labelledby="heading-{$category-id}" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            <xsl:for-each select="current-group()">
                                <xsl:sort select="."  lang="de"/>
                                <p>
                                    <xsl:value-of select="text()"/>
                                    <ul>
                                        <xsl:apply-templates select="tei:note[@type = 'mentions']"/>
                                    </ul>
                                </p>
                            </xsl:for-each>
                        </div>
                    </div>
                </div>
            </xsl:for-each-group>
        </div>
    </xsl:template>
    <xsl:template match="tei:note[@type = 'mentions']">
        <li>
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:value-of select="concat(replace(@target, '.xml', '.html'), '#', parent::tei:item/@xml:id)"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </li>
    </xsl:template>
</xsl:stylesheet>
