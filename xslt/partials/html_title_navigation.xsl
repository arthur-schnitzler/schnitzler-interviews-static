<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xsl tei xs" version="2.0">
    <xsl:template name="header-nav">
        <xsl:param name="prev" as="xs:string"/>
        <xsl:param name="next" as="xs:string"/>
        <div class="row" id="title-nav">
            <div class="col-md-2 col-lg-2 col-sm-12">
                <xsl:if test="not($prev='.html')">
                    <h1>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="$prev"/>
                            </xsl:attribute>
                            <i class="fas fa-chevron-left" title="prev"/>
                        </a>
                    </h1>
                </xsl:if>
            </div>
            <div class="col-md-8">
                <h1 align="center">
                    <xsl:for-each select="//tei:fileDesc/tei:titleStmt/tei:title[@level = 'a']">
                        <xsl:apply-templates/>
                        <br/>
                    </xsl:for-each>
                </h1>
            </div>
            <div class="col-md-2 col-lg-2 col-sm-12" style="text-align:right">
                <xsl:if test="not($next='.html')">
                    <h1>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="$next"/>
                            </xsl:attribute>
                            <i class="fas fa-chevron-right" title="next"/>
                        </a>
                    </h1>
                </xsl:if>
            </div>
        </div>
        <!-- .row -->
        <!-- .card-header -->
    </xsl:template>
</xsl:stylesheet>
