<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:mam="whatever" version="3.0"
    exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="comment()"/>
    <xsl:template match="tei:body">
        <xsl:element name="body" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:variable name="bodynode" select="descendant::*"/>
            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">
                    <xsl:text>edierter-text</xsl:text>
                </xsl:attribute>
                <xsl:variable name="listen" select="'person,work,org,place'"/>
                
                <xsl:for-each select="tokenize($listen, ',')">
                    <xsl:variable name="liste" select="."/>
                    <xsl:variable name="listenname" as="xs:string">
                <xsl:choose>
                    <xsl:when test="$liste = 'person'">
                        <xsl:text>listPerson</xsl:text>
                    </xsl:when>
                    <xsl:when test="$liste = 'work'">
                        <xsl:text>listBibl</xsl:text>
                    </xsl:when>
                    <xsl:when test="$liste = 'place'">
                        <xsl:text>listPlace</xsl:text>
                    </xsl:when>
                    <xsl:when test="$liste = 'org'">
                        <xsl:text>listOrg</xsl:text>
                    </xsl:when>
                </xsl:choose>
                    </xsl:variable>
                <xsl:element name="{$listenname}" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:variable name="edierte-personen" as="node()">
                        <xsl:element name="list">
                            <xsl:for-each
                                select="$bodynode/descendant::tei:rs[@type = $liste and not(ancestor::tei:note[@type = 'commentary']) and not(ancestor::tei:div/@type='biographical')]/tokenize(@ref, ' ')">
                                <xsl:if test="not(. = '#2121')">
                                <xsl:element name="item">
                                    <xsl:value-of select="."/>
                                </xsl:element>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:variable>
                    <xsl:call-template name="mam:list">
                        <xsl:with-param name="list" select="$edierte-personen"/>
                        <xsl:with-param  name="listtype" select="."/>
                    </xsl:call-template>
                </xsl:element>
                </xsl:for-each>
            </xsl:element>
            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">
                    <xsl:text>kommentar-text</xsl:text>
                </xsl:attribute>
                <xsl:variable name="listen" select="'person,work,org,place'"/>
                
                <xsl:for-each select="tokenize($listen, ',')">
                    <xsl:variable name="liste" select="."/>
                    <xsl:variable name="listenname" as="xs:string">
                        <xsl:choose>
                            <xsl:when test="$liste = 'person'">
                                <xsl:text>listPerson</xsl:text>
                            </xsl:when>
                            <xsl:when test="$liste = 'work'">
                                <xsl:text>listBibl</xsl:text>
                            </xsl:when>
                            <xsl:when test="$liste = 'place'">
                                <xsl:text>listPlace</xsl:text>
                            </xsl:when>
                            <xsl:when test="$liste = 'org'">
                                <xsl:text>listOrg</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:element name="{$listenname}" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:variable name="edierte-entitaeten" as="node()">
                            <xsl:element name="list">
                                <xsl:for-each
                                    select="$bodynode/descendant::tei:rs[@type = $liste and (ancestor::tei:note[@type = 'commentary'] or ancestor::tei:div/@type='biographical')]/tokenize(@ref, ' ')">
                                    <xsl:if test="not(. = '#pmb2121')">
                                        <xsl:element name="item">
                                            <xsl:value-of select="."/>
                                        </xsl:element>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:element>
                        </xsl:variable>
                        <xsl:call-template name="mam:list">
                            <xsl:with-param name="list" select="$edierte-entitaeten"/>
                            <xsl:with-param  name="listtype" select="."/>
                        </xsl:call-template>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
            
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="mam:list">
        <xsl:param name="list" as="node()"/>
        <xsl:param name="listtype" as="xs:string"/>
        <xsl:for-each select="fn:distinct-values($list//item)">
            <xsl:sort select="replace(., '#pmb', '')" data-type="number"/>
            <xsl:variable name="list-tei-konform">
                <xsl:choose>
                    <xsl:when test="$listtype = 'work'">
                        <xsl:text>bibl</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$listtype"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:element name="{$list-tei-konform}">
                <xsl:attribute name="ref">
                    <xsl:value-of select="."/>
                </xsl:attribute>
                
                
            </xsl:element>
        </xsl:for-each>
        
        
    </xsl:template>
</xsl:stylesheet>
