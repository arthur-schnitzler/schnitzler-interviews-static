<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:mam="whatever" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl tei xs" version="3.0">
    <!-- The template "add_header-navigation-custom-title" creates a custom header without
                using tei:title but includes prev and next urls. -->
    
    <xsl:template name="header-nav">
        
        <xsl:variable name="doc_title">
            <xsl:value-of select="descendant::tei:titleSmt/tei:title[@level = 'a'][1]/text()"/>
        </xsl:variable>
        <div class="row" id="title-nav">
            <div class="col-md-2 col-lg-2 col-sm-12" style="text-align:left">
                <xsl:if test="child::tei:TEI/@prev">
                    <h1>
                        <a href="{child::tei:TEI/@prev}.html" class="nav-link" aria-expanded="false">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </h1>
                </xsl:if>
            </div>
            <div class="col-md-8">
                <h1 align="center">
                    <xsl:value-of
                        select="descendant::tei:fileDesc/tei:titleStmt/tei:title[@level = 'a']"/>
                </h1>
            </div>
            <div class="col-md-2 col-lg-2 col-sm-12" style="text-align:right">
                <xsl:if test="child::tei:TEI/@next">
                    <h1>
                        <a href="{child::tei:TEI/@next}.html" class="nav-link" aria-expanded="false">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </h1>
                </xsl:if>
            </div>
        </div>
    </xsl:template>
    
</xsl:stylesheet>
