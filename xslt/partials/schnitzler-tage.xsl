<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:local="http://dse-static.foo.bar"
    xmlns:mam="whatever" version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>
    <xsl:import href="./LOD-idnos.xsl"/>
    <xsl:param name="relevant-uris" select="document('../utils/list-of-relevant-uris.xml')"/>
    <xsl:key match="item" use="abbr" name="relevant-uris-type"/>
    <xsl:template name="mam:schnitzler-tage">
        <xsl:param name="datum-iso" as="xs:date"/>
        <xsl:param name="teiSource" as="xs:string"/>
        <xsl:variable name="link">
            <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
        </xsl:variable>
        <xsl:variable name="fetchUrl"
            select="document(concat('https://schnitzler-tage.acdh.oeaw.ac.at/', $datum-iso, '.xml'))"
            as="node()"/>
        <xsl:variable name="fetchURLohneTeiSource" as="node()">
            <xsl:element name="listEvent" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of
                    select="$fetchUrl/descendant::tei:listEvent/tei:event[not(contains(tei:idno[1]/text(), $teiSource))]"
                />
            </xsl:element>
        </xsl:variable>
        <xsl:variable name="doc_title">
            <xsl:value-of
                select="$fetchUrl/descendant::tei:titleStmt[1]/tei:title[@level = 'a'][1]/text()"/>
        </xsl:variable>
        <div id="tag-fuer-tag-modal-body">
            <xsl:apply-templates select="$fetchURLohneTeiSource" mode="schnitzler-tage"/>
            <div class="weiteres" style="margin-top:2.5em;">
                <xsl:variable name="datum-written" select="
                        format-date($datum-iso, '[D1].&#160;[M1].&#160;[Y0001]',
                        'en',
                        'AD',
                        'EN')"/>
                <xsl:variable name="wochentag">
                    <xsl:choose>
                        <xsl:when test="
                                format-date($datum-iso, '[F]',
                                'en',
                                'AD',
                                'EN') = 'Monday'">
                            <xsl:text>Montag</xsl:text>
                        </xsl:when>
                        <xsl:when test="
                                format-date($datum-iso, '[F]',
                                'en',
                                'AD',
                                'EN') = 'Tuesday'">
                            <xsl:text>Dienstag</xsl:text>
                        </xsl:when>
                        <xsl:when test="
                                format-date($datum-iso, '[F]',
                                'en',
                                'AD',
                                'EN') = 'Wednesday'">
                            <xsl:text>Mittwoch</xsl:text>
                        </xsl:when>
                        <xsl:when test="
                                format-date($datum-iso, '[F]',
                                'en',
                                'AD',
                                'EN') = 'Thursday'">
                            <xsl:text>Donnerstag</xsl:text>
                        </xsl:when>
                        <xsl:when test="
                                format-date($datum-iso, '[F]',
                                'en',
                                'AD',
                                'EN') = 'Friday'">
                            <xsl:text>Freitag</xsl:text>
                        </xsl:when>
                        <xsl:when test="
                                format-date($datum-iso, '[F]',
                                'en',
                                'AD',
                                'EN') = 'Saturday'">
                            <xsl:text>Samstag</xsl:text>
                        </xsl:when>
                        <xsl:when test="
                                format-date($datum-iso, '[F]',
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
                <h3>Weiteres</h3>
                <ul>
                    <li>
                        <xsl:text>Zeitungen vom </xsl:text>
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of
                                    select="concat('https://anno.onb.ac.at/cgi-content/anno?datum=', replace(string($datum-iso), '-', ''))"
                                />
                            </xsl:attribute>
                            <xsl:attribute name="target">
                                <xsl:text>_blank</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="concat($wochentag, ', ', $datum-written)"/>
                        </xsl:element>
                        <xsl:text> bei </xsl:text>
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of
                                    select="concat('https://anno.onb.ac.at/cgi-content/anno?datum=', replace(string($datum-iso), '-', ''))"
                                />
                            </xsl:attribute>
                            <xsl:attribute name="target">
                                <xsl:text>_blank</xsl:text>
                            </xsl:attribute>
                            <xsl:text>ANNO</xsl:text>
                        </xsl:element>
                    </li>
                    <li>
                        <xsl:text>Briefe vom </xsl:text>
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of
                                    select="concat('https://correspsearch.net/de/suche.html?d=', $datum-iso, '&amp;x=1&amp;w=0')"
                                />
                            </xsl:attribute>
                            <xsl:attribute name="target">
                                <xsl:text>_blank</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="concat($wochentag, ', ', $datum-written)"/>
                        </xsl:element>
                        <xsl:text> bei </xsl:text>
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of
                                    select="concat('https://correspsearch.net/de/suche.html?d=', $datum-iso, '&amp;x=1&amp;w=0')"
                                />
                            </xsl:attribute>
                            <xsl:attribute name="target">
                                <xsl:text>_blank</xsl:text>
                            </xsl:attribute>
                            <xsl:text>correspSearch</xsl:text>
                        </xsl:element>
                    </li>
                </ul>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="tei:listEvent" mode="schnitzler-tage">
        <xsl:variable name="eventtypes"
            select="'Arthur-Schnitzler-digital,schnitzler-tagebuch,schnitzler-briefe,pollaczek,schnitzler-bahr,schnitzler-orte,schnitzler-tage-manuell,pmb,schnitzler-cmif,kalliope-verbund'"/>
        <xsl:variable name="current-group" select="." as="node()"/>
        <xsl:for-each select="tokenize($eventtypes, ',')">
            <xsl:variable name="e-type" as="xs:string" select="."/>
            <xsl:if test="$current-group/descendant::tei:idno[@type = $e-type]">
                <xsl:variable name="e-typ-farbe">
                    <xsl:choose>
                        <xsl:when
                            test="key('only-relevant-uris', $e-type, $relevant-uris)/*:color != '#fff'">
                            <xsl:value-of
                                select="key('only-relevant-uris', $e-type, $relevant-uris)/*:color"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>blue</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:element name="div">
                    <xsl:attribute name="class">
                        <xsl:value-of select="$e-type"/>
                    </xsl:attribute>
                    <xsl:attribute name="style">
                        <xsl:text>margin-bottom: 35px;</xsl:text>
                    </xsl:attribute>
                    <xsl:if test="not(position() = 1)"> </xsl:if>
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:text>badge rounded-pill</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="style">
                            <xsl:text>color: white; background-color: </xsl:text>
                            <xsl:value-of select="$e-typ-farbe"/>
                            <xsl:text>; margin-bottom: 10px;</xsl:text>
                        </xsl:attribute>
                        <xsl:element name="a">
                            <xsl:attribute name="target">
                                <xsl:text>_blank</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="href">
                                <xsl:value-of
                                    select="$current-group/descendant::tei:idno[@type = $eventtypes][1]"
                                />
                            </xsl:attribute>
                        </xsl:element>
                        <xsl:text/>
                        <xsl:value-of
                            select="key('only-relevant-uris', $e-type, $relevant-uris)/*:caption"/>
                    </xsl:element>
                    <xsl:apply-templates select="$current-group/tei:event[tei:idno/@type = $e-type]"
                    />
                </xsl:element>
            </xsl:if>
        </xsl:for-each>
        <xsl:for-each select="tei:event[tei:idno/@type[not(contains($eventtypes, .))]]">
            <xsl:apply-templates mode="desc"/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="tei:event">
        <p>
            <b>
                <xsl:choose>
                    <xsl:when test="starts-with(tei:idno[1]/text(), 'http')">
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="tei:idno[1]/text()"/>
                            </xsl:attribute>
                            <xsl:attribute name="target">
                                <xsl:text>_blank</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="tei:head"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="starts-with(tei:idno[1]/text(), 'doi')">
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat('https://', tei:idno[1]/text())"/>
                            </xsl:attribute>
                            <xsl:attribute name="target">
                                <xsl:text>_blank</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="tei:head"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="tei:head"/>
                    </xsl:otherwise>
                </xsl:choose>
            </b>
        </p>
        <xsl:element name="ul">
            <xsl:attribute name="style">
                <xsl:text>list-style-type: none;</xsl:text>
            </xsl:attribute>
            <xsl:if test="not(normalize-space(tei:desc) = '')">
                <xsl:apply-templates select="tei:desc" mode="desc"/>
            </xsl:if>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:event/tei:desc" mode="desc">
        <li>
            <xsl:if
                test="child::tei:listPerson or child::tei:listBibl or child::tei:listPlace or child::tei:listOrg">
                <ul>
                    <xsl:attribute name="style">
                        <xsl:text>list-style-type: none; padding: 0; margin: 0;</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates
                        select="child::tei:listPerson | child::tei:listBibl | child::tei:listPlace | child::tei:listOrg"
                        mode="desc"/>
                </ul>
            </xsl:if>
            <xsl:if
                test="tei:*[not(self::tei:listPerson or self::tei:listBibl or self::tei:listPlace or self::tei:listOrg)]">
                <xsl:apply-templates
                    select="tei:*[not(self::tei:listPerson or self::tei:listBibl or self::tei:listPlace or self::tei:listOrg)]"
                    mode="desc"/>
            </xsl:if>
            <xsl:if test="text()[not(normalize-space(.) = '')]">
                <p>
                    <xsl:value-of select="normalize-space(text()[not(normalize-space(.) = '')])"/>
                </p>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="tei:listPerson" mode="desc">
        <xsl:variable name="e-typ" select="ancestor::tei:event/tei:idno/@type"/>
        <xsl:variable name="type-farbe">
            <xsl:choose>
                <xsl:when test="key('only-relevant-uris', $e-typ, $relevant-uris)/*:color != '#fff'">
                    <xsl:value-of select="key('only-relevant-uris', $e-typ, $relevant-uris)/*:color"
                    />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>blue</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <li>
            <i class="fa-regular fa-users" title="Erwähnte Personen"/>&#160; <xsl:for-each
                select="tei:person/tei:persName">
                <xsl:choose>
                    <xsl:when
                        test="starts-with(@ref, 'https://d-nb') or starts-with(@ref, 'http://d-nb') and $e-typ = 'schnitzler-cmif'">
                        <xsl:variable name="normalize-gnd-ohne-http"
                            select="replace(@ref, 'https', 'http')" as="xs:string"/>
                        <xsl:element name="span">
                            <xsl:attribute name="class">
                                <xsl:text>badge rounded-pill</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="style">
                                <xsl:text>background-color: </xsl:text>
                                <xsl:value-of select="$type-farbe"/>
                                <xsl:text>; color: white;</xsl:text>
                            </xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="style">
                                    <xsl:text>color: white; </xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="href">
                                    <xsl:value-of
                                        select="concat('https://correspsearch.net/de/suche.html?s=', $normalize-gnd-ohne-http)"
                                    />
                                </xsl:attribute>
                                <xsl:attribute name="target">
                                    <xsl:text>_blank</xsl:text>
                                </xsl:attribute>
                                <xsl:value-of select="."/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="starts-with(@ref, 'pmb') or starts-with(@ref, 'person_')">
                        <xsl:element name="span">
                            <xsl:attribute name="class">
                                <xsl:text>badge rounded-pill</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="style">
                                <xsl:text>background-color: </xsl:text>
                                <xsl:value-of select="$type-farbe"/>
                                <xsl:text>; color: white;</xsl:text>
                            </xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="style">
                                    <xsl:text>color: white; </xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="href">
                                    <xsl:value-of
                                        select="concat('https://', $e-typ, '.acdh.oeaw.ac.at/', @ref, '.html')"
                                    />
                                </xsl:attribute>
                                <xsl:attribute name="target">
                                    <xsl:text>_blank</xsl:text>
                                </xsl:attribute>
                                <xsl:value-of select="."/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                        <xsl:if test="not(position() = last())">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text> </xsl:text>
            </xsl:for-each>
        </li>
    </xsl:template>
    <xsl:template match="tei:listOrg" mode="desc">
        <xsl:variable name="type" select="ancestor::tei:event/tei:idno/@type"/>
        <xsl:variable name="type-farbe">
            <xsl:choose>
                <xsl:when test="key('only-relevant-uris', $type, $relevant-uris)/*:color != '#fff'">
                    <xsl:value-of select="key('only-relevant-uris', $type, $relevant-uris)/*:color"
                    />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>blue</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <li>
            <i class="fa-regular fa-building-columns" title="Erwähnte Organisationen"/>&#160;
                <xsl:for-each select="tei:org/tei:orgName">
                <xsl:choose>
                    <xsl:when
                        test="starts-with(@ref, 'https://d-nb') or starts-with(@ref, 'http://d-nb') and $type = 'schnitzler-cmif'">
                        <xsl:variable name="normalize-gnd-ohne-http"
                            select="replace(@ref, 'https', 'http')" as="xs:string"/>
                        <xsl:element name="span">
                            <xsl:attribute name="class">
                                <xsl:text>badge rounded-pill</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="style">
                                <xsl:text>background-color: </xsl:text>
                                <xsl:value-of select="$type-farbe"/>
                                <xsl:text>; color: white;</xsl:text>
                            </xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="style">
                                    <xsl:text>color: white; </xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="href">
                                    <xsl:value-of
                                        select="concat('https://correspsearch.net/de/suche.html?s=', $normalize-gnd-ohne-http)"
                                    />
                                </xsl:attribute>
                                <xsl:attribute name="target">
                                    <xsl:text>_blank</xsl:text>
                                </xsl:attribute>
                                <xsl:value-of select="."/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="starts-with(@ref, 'pmb')">
                        <xsl:element name="span">
                            <xsl:attribute name="class">
                                <xsl:text>badge rounded-pill</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="style">
                                <xsl:text>background-color: </xsl:text>
                                <xsl:value-of select="$type-farbe"/>
                                <xsl:text>; color: white;</xsl:text>
                            </xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="style">
                                    <xsl:text>color: white; </xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="href">
                                    <xsl:value-of
                                        select="concat('https://', $type, '.acdh.oeaw.ac.at/', @ref, '.html')"
                                    />
                                </xsl:attribute>
                                <xsl:attribute name="target">
                                    <xsl:text>_blank</xsl:text>
                                </xsl:attribute>
                                <xsl:value-of select="."/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                        <xsl:if test="not(position() = last())">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text> </xsl:text>
            </xsl:for-each>
        </li>
    </xsl:template>
    <xsl:template match="tei:listPlace" mode="desc">
        <xsl:variable name="type" select="ancestor::tei:event/tei:idno/@type"/>
        <xsl:variable name="type-farbe">
            <xsl:choose>
                <xsl:when test="key('only-relevant-uris', $type, $relevant-uris)/*:color != '#fff'">
                    <xsl:value-of select="key('only-relevant-uris', $type, $relevant-uris)/*:color"
                    />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>blue</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <li>
            <i title="Erwähnte Orte" class="fa-regular fa-map-location-dot"/>&#160; <xsl:for-each
                select="tei:place/tei:placeName">
                <xsl:choose>
                    <xsl:when test="starts-with(@ref, 'pmb')">
                        <xsl:element name="span">
                            <xsl:attribute name="class">
                                <xsl:text>badge rounded-pill</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="style">
                                <xsl:text>background-color: </xsl:text>
                                <xsl:value-of select="$type-farbe"/>
                                <xsl:text>; color: white;</xsl:text>
                            </xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="style">
                                    <xsl:text>color: white; </xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="href">
                                    <xsl:value-of
                                        select="concat('https://', $type, '.acdh.oeaw.ac.at/', @ref, '.html')"
                                    />
                                </xsl:attribute>
                                <xsl:attribute name="target">
                                    <xsl:text>_blank</xsl:text>
                                </xsl:attribute>
                                <xsl:value-of select="."/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                        <xsl:if test="not(position() = last())">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text> </xsl:text>
            </xsl:for-each>
        </li>
    </xsl:template>
    <xsl:template match="tei:desc/tei:listBibl" mode="desc">
        <xsl:variable name="type" select="ancestor::tei:event/tei:idno/@type"/>
        <xsl:variable name="type-farbe">
            <xsl:choose>
                <xsl:when test="key('only-relevant-uris', $type, $relevant-uris)/*:color != '#fff'">
                    <xsl:value-of select="key('only-relevant-uris', $type, $relevant-uris)/*:color"
                    />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>blue</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <li>
            <i title="Erwähnte Werke" class="fa-regular fa-image"/>&#160; <xsl:for-each
                select="descendant::tei:title">
                <xsl:choose>
                    <xsl:when test="starts-with(@ref, 'pmb')">
                        <xsl:element name="span">
                            <xsl:attribute name="class">
                                <xsl:text>badge rounded-pill</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="style">
                                <xsl:text>background-color: </xsl:text>
                                <xsl:value-of select="$type-farbe"/>
                                <xsl:text>; color: white;</xsl:text>
                            </xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="style">
                                    <xsl:text>color: white; </xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="href">
                                    <xsl:value-of
                                        select="concat('https://', $type, '.acdh.oeaw.ac.at/', @ref, '.html')"
                                    />
                                </xsl:attribute>
                                <xsl:attribute name="target">
                                    <xsl:text>_blank</xsl:text>
                                </xsl:attribute>
                                <xsl:choose><!-- Titel werden nur bis 50 Zeichen wiedergegeben -->
                                    <xsl:when test="string-length(normalize-space(.)) &gt; 50">
                                        <xsl:value-of select="substring(normalize-space(.), 1, 50)"
                                        /><xsl:text>…</xsl:text>                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="."/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                        <xsl:if test="not(position() = last())">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text> </xsl:text>
            </xsl:for-each>
        </li>
    </xsl:template>
    <xsl:template match="tei:bibl[parent::tei:desc]" mode="desc">
        <p>
            <xsl:text>Erscheinungsort: </xsl:text>
            <i>
                <xsl:value-of select="."/>
            </i>
        </p>
    </xsl:template>
</xsl:stylesheet>
