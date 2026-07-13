<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:mam="whatever" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl tei xs" version="3.0">
    <!-- The template "add_header-navigation-custom-title" creates a custom header without
                using tei:title but includes prev and next urls. -->
    
    <xsl:template name="header-nav">
        <div class="row" id="title-nav">
            <div class="col-12">
                <h1 align="center">
                    <xsl:value-of
                        select="descendant::tei:fileDesc/tei:titleStmt/tei:title[@level = 'a']"/>
                </h1>
            </div>
        </div>
    </xsl:template>
    <!-- Blätterfunktion (vorheriger/nächster Text), rechtsbündig in der Action-Bar.
         Muss im Kontext des Dokumentknotens aufgerufen werden. -->
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
    
</xsl:stylesheet>
