<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar" xmlns:mam="whatever" exclude-result-prefixes="xs"
    version="2.0">
    <xsl:import href="./biblStruct-output.xsl"/>
    <xsl:import href="./commentary.xsl"/>
    <xsl:import href="./physDesc.xsl"/>
    <xsl:import href="./refs.xsl"/>
    <xsl:function name="local:makeId" as="xs:string">
        <xsl:param name="currentNode" as="node()"/>
        <xsl:variable name="nodeCurrNr">
            <xsl:value-of select="count($currentNode//preceding-sibling::*) + 1"/>
        </xsl:variable>
        <xsl:value-of select="concat(name($currentNode), '__', $nodeCurrNr)"/>
    </xsl:function>
    <xsl:template match="tei:c[@rendition = '#kaufmannsund']">
        <xsl:text>&amp;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#tilde']">~</xsl:template>
    <xsl:template match="tei:c[@rendition = '#geschwungene-klammer-auf']">
        <xsl:text>{</xsl:text>
    </xsl:template>
    <xsl:template match="tei:space[@unit = 'chars' and @quantity = '1']">
        <xsl:text> </xsl:text>
    </xsl:template>
    <xsl:function name="mam:spaci-space">
        <xsl:param name="anzahl"/>
        <xsl:param name="gesamt"/>  <br/>
        <xsl:if test="$anzahl &lt; $gesamt">
            <xsl:value-of select="mam:spaci-space($anzahl, $gesamt)"/>
        </xsl:if>
    </xsl:function>
    <xsl:template match="tei:space[@unit = 'line']">
        <xsl:value-of select="mam:spaci-space(@quantity, @quantity)"/>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#geschwungene-klammer-zu']">
        <xsl:text>}</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#langesS']">
        <span class="langes-s">s</span>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#gemination-m']">
        <span class="gemination-m">mm</span>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#gemination-n']">
        <span class="gemination-n">nn</span>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#prozent']">
        <xsl:text>%</xsl:text>
    </xsl:template>
    <xsl:template match="tei:c[@rendition = '#dots']">
        <xsl:value-of select="mam:dots(@n)"/>
    </xsl:template>
    <xsl:template match="tei:div[@type = 'image']">
        <div style="width:100%; text-align:center; padding-bottom: 1rem;">
            <xsl:choose>
                <xsl:when test="tei:figure/tei:graphic and tei:caption">
                    <figure>
                        <!-- Bild mit dynamischen Attributen -->
                        <img>
                            <xsl:attribute name="src">
                                <xsl:variable name="facs_item" select="tei:figure/tei:graphic/@url"/>
                                <xsl:value-of select="$facs_item"/>
                            </xsl:attribute>
                            <xsl:attribute name="alt">
                                <xsl:choose>
                                    <xsl:when test="ends-with(tei:figure/tei:graphic/@url, '.png') or ends-with(tei:figure/tei:graphic/@url, '.jpg') or ends-with(tei:figure/tei:graphic/@url, '.jp2') or ends-with(tei:figure/tei:graphic/@url, '.gif')">
                                        <xsl:value-of select="tei:figure/tei:graphic/@url"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat(tei:graphic/@url, '.jpg')"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                            <xsl:attribute name="width">
                                <xsl:text>50%</xsl:text>
                            </xsl:attribute>
                        </img>
                        <!-- Bildunterschrift -->
                        <figcaption>
                            <xsl:apply-templates select="tei:caption"/>                                
                        </figcaption>
                    </figure>
                </xsl:when>
                <xsl:otherwise>
                    <!-- Fallback: Nur das Bild ohne Beschriftung -->
                    <img>
                        <xsl:attribute name="src">
                            <xsl:variable name="facs_item" select="tei:figure/tei:graphic/@url"/>
                            <xsl:value-of select="$facs_item"/>
                        </xsl:attribute>
                        <xsl:attribute name="alt">
                            <xsl:value-of select="tei:figure/tei:graphic/@url"/>
                        </xsl:attribute>
                        <xsl:attribute name="width">
                            <xsl:text>50%</xsl:text>
                        </xsl:attribute>
                    </img>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    <xsl:template match="tei:lb"><br/></xsl:template>
    <xsl:template match="tei:figDesc"/>
    <xsl:template match="tei:caption">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:space">
        <span class="space">
            <xsl:value-of select="
                    string-join((for $i in 1 to @quantity
                    return
                        '&#x00A0;'), '')"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:unclear">
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:text>unclear</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:del">
        <span class="del strikethrough badge-item" style="display:none;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <!-- Die folgenden beiden Regeln sollten das Leerzeichen vor und nach Streichungen mit aus- und einblenden -->
    <xsl:template match="text()[matches(., '[\s\r\n]+$') and following-sibling::node()[1][self::tei:del]]">
        <xsl:value-of select="replace(., '[\s\r\n]+$', '')"/>
        <span class="del badge-item" style="display:none;">
            <xsl:text> </xsl:text>
        </span>
    </xsl:template>
    <!--<xsl:template match="text()[matches(., '^\s+') and preceding-sibling::node()[1][self::tei:del]]">
        <xsl:choose>
            <!-\- hier die Abfrage soll verhindern, dass ein Leerzeichen zu wenig ist, weil das vor
            und das nach dem del entfernt wird-\->
            <xsl:when test="preceding-sibling::node()[1][self::tei:del]">
                <xsl:text>Ö</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <span class="del badge-item" style="display:none;">
                    <xsl:text> </xsl:text>
                </span>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="replace(., '^\s+', '')"/>
    </xsl:template>-->
    <xsl:template match="tei:add">
        <span class="add-zeichen badge-item">↓</span>
        <span class="add-content badge-item">
            <xsl:apply-templates/>
        </span>
        <span class="add-zeichen badge-item">↓</span>
    </xsl:template>
    <!-- Substi -->
    <xsl:template match="tei:subst">
        <!--<span class="steuerzeichen">↑</span>-->
        <sup>
            <xsl:apply-templates select="tei:del"/>
        </sup>
        <xsl:apply-templates select="tei:add"/>
    </xsl:template>
    <xsl:template match="tei:cit">
        <cite>
            <xsl:apply-templates/>
        </cite>
    </xsl:template>
    <xsl:template match="tei:quote">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:date">
        <span class="date">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    <!--  <xsl:template match="tei:note">
        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:text>fna_</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#fn</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:attribute>
            <sup>
                <xsl:number level="any" format="1" count="tei:note"/>
            </sup>
        </xsl:element>
    </xsl:template> -->
    <xsl:template match="tei:list[@type = 'unordered']">
        <xsl:choose>
            <xsl:when test="ancestor::tei:body">
                <ul class="yes-index">
                    <xsl:apply-templates/>
                </ul>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:item">
        <xsl:choose>
            <xsl:when test="parent::tei:list[@type = 'unordered'] | ancestor::tei:body">
                <li>
                    <xsl:apply-templates/>
                </li>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:lg">
        <span style="display:block;margin: 1em 0;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:l">
        <xsl:apply-templates/>
        <br/>
    </xsl:template>
    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates/>
        </p>
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
    <xsl:template match="tei:supplied"><span class="supplied"><xsl:apply-templates/></span></xsl:template>
    <xsl:template match="tei:table">
        <xsl:element name="table">
            <xsl:attribute name="class">
                <xsl:text>table table-bordered table-striped table-condensed table-hover</xsl:text>
            </xsl:attribute>
            <xsl:element name="tbody">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:row">
        <xsl:element name="tr">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:cell">
        <xsl:element name="td">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:rs">
        <xsl:choose>
            <xsl:when test="count(tokenize(@ref, ' ')) > 1">
                <xsl:choose>
                    <xsl:when test="@type = 'person'">
                        <span class="persons {substring-after(@rendition, '#')}" id="{@xml:id}">
                            <xsl:apply-templates/>
                            <xsl:for-each select="tokenize(@ref, ' ')">
                                <sup class="entity" data-bs-toggle="modal" data-bs-target="{.}">
                                    <xsl:value-of select="position()"/>
                                </sup>
                                <xsl:if test="position() != last()">
                                    <sup class="entity">/</sup>
                                </xsl:if>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type = 'place'">
                        <span class="places {substring-after(@rendition, '#')}" id="{@xml:id}">
                            <xsl:apply-templates/>
                            <xsl:for-each select="tokenize(@ref, ' ')">
                                <sup class="entity" data-bs-toggle="modal" data-bs-target="{.}">
                                    <xsl:value-of select="position()"/>
                                </sup>
                                <xsl:if test="position() != last()">
                                    <sup class="entity">/</sup>
                                </xsl:if>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type = 'bibl'">
                        <span class="works {substring-after(@rendition, '#')}" id="{@xml:id}">
                            <xsl:apply-templates/>
                            <xsl:for-each select="tokenize(@ref, ' ')">
                                <sup class="entity" data-bs-toggle="modal" data-bs-target="{.}">
                                    <xsl:value-of select="position()"/>
                                </sup>
                                <xsl:if test="position() != last()">
                                    <sup class="entity">/</sup>
                                </xsl:if>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type = 'org'">
                        <span class="orgs {substring-after(@rendition, '#')}" id="{@xml:id}">
                            <xsl:apply-templates/>
                            <xsl:for-each select="tokenize(@ref, ' ')">
                                <sup class="entity" data-bs-toggle="modal" data-bs-target="{.}">
                                    <xsl:value-of select="position()"/>
                                </sup>
                                <xsl:if test="position() != last()">
                                    <sup class="entity">/</sup>
                                </xsl:if>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@type = 'person'">
                        <span class="persons entity {substring-after(@rendition, '#')}"
                            id="{@xml:id}" data-bs-toggle="modal" data-bs-target="{@ref}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type = 'place'">
                        <span class="places entity {substring-after(@rendition, '#')}"
                            id="{@xml:id}" data-bs-toggle="modal" data-bs-target="{@ref}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type = 'bibl'">
                        <span class="works entity {substring-after(@rendition, '#')}" id="{@xml:id}"
                            data-bs-toggle="modal" data-bs-target="{@ref}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type = 'org'">
                        <span class="orgs entity {substring-after(@rendition, '#')}" id="{@xml:id}"
                            data-bs-toggle="modal" data-bs-target="{@ref}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:listPerson">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:person">
        <xsl:param name="showNumberOfMentions" as="xs:integer" select="5"/>
        <xsl:variable name="selfLink">
            <xsl:value-of select="concat(data(@xml:id), '.html')"/>
        </xsl:variable>
        <div class="modal fade" id="{@xml:id}" data-bs-keyboard="false" tabindex="-1"
            aria-labelledby="{concat(./tei:persName/tei:surname, ', ', ./tei:persName/tei:forename)}"
            aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">
                            <xsl:value-of
                                select="concat(./tei:persName/tei:surname, ', ', ./tei:persName/tei:forename)"
                            />
                        </h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Schließen"/>
                    </div>
                    <div class="modal-body">
                        <table class="table">
                            <tbody>
                                <xsl:if test="./tei:idno[@type = 'GEONAMES']">
                                    <tr>
                                        <th> Geonames ID </th>
                                        <td>
                                            <a href="{./tei:idno[@type='GEONAMES']}" target="_blank">
                                                <xsl:value-of
                                                  select="tokenize(./tei:idno[@type = 'GEONAMES'], '/')[4]"
                                                />
                                            </a>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="./tei:idno[@type = 'WIKIDATA']">
                                    <tr>
                                        <th> Wikidata ID </th>
                                        <td>
                                            <a href="{./tei:idno[@type='WIKIDATA']}" target="_blank">
                                                <xsl:value-of
                                                  select="tokenize(./tei:idno[@type = 'WIKIDATA'], '/')[last()]"
                                                />
                                            </a>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="./tei:idno[@type = 'GND']">
                                    <tr>
                                        <th> GND ID </th>
                                        <td>
                                            <a href="{./tei:idno[@type='GND']}" target="_blank">
                                                <xsl:value-of
                                                  select="tokenize(./tei:idno[@type = 'GND'], '/')[last()]"
                                                />
                                            </a>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="./tei:listEvent">
                                    <tr>
                                        <th> Erwähnungen </th>
                                        <td>
                                            <ul>
                                                <xsl:for-each select=".//tei:event">
                                                  <xsl:variable name="linkToDocument">
                                                  <xsl:value-of
                                                  select="replace(tokenize(data(.//@target), '/')[last()], '.xml', '.html')"
                                                  />
                                                  </xsl:variable>
                                                  <xsl:choose>
                                                  <xsl:when
                                                  test="position() lt $showNumberOfMentions + 1">
                                                  <li>
                                                  <xsl:value-of select=".//tei:title"/>
                                                  <xsl:text> </xsl:text>
                                                  <a href="{$linkToDocument}">
                                                  <i class="fas fa-external-link-alt"/>
                                                  </a>
                                                  </li>
                                                  </xsl:when>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </ul>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <tr>
                                    <th/>
                                    <td> Anzahl der Erwähnungen limitiert, klicke <a
                                            href="{$selfLink}">hier</a> für eine vollständige
                                        Auflistung </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                            >Schließen</button>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="tei:listPlace">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:place">
        <xsl:param name="showNumberOfMentions" as="xs:integer" select="5"/>
        <xsl:variable name="selfLink">
            <xsl:value-of select="concat(data(@xml:id), '.html')"/>
        </xsl:variable>
        <div class="modal fade" id="{@xml:id}" data-bs-keyboard="false" tabindex="-1"
            aria-labelledby="{if(./tei:settlement) then(./tei:settlement/tei:placeName) else (./tei:placeName)}"
            aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">
                            <xsl:value-of select="
                                    if (./tei:settlement) then
                                        (./tei:settlement/tei:placeName)
                                    else
                                        (./tei:placeName)"/>
                        </h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Schließen"/>
                    </div>
                    <div class="modal-body">
                        <table>
                            <tbody>
                                <xsl:if test="./tei:country">
                                    <tr>
                                        <th> Land </th>
                                        <td>
                                            <xsl:value-of select="./tei:country"/>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="./tei:idno[@type = 'GND']/text()">
                                    <tr>
                                        <th> GND </th>
                                        <td>
                                            <a href="{./tei:idno[@type='GND']}" target="_blank">
                                                <xsl:value-of
                                                  select="tokenize(./tei:idno[@type = 'GND'], '/')[last()]"
                                                />
                                            </a>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="./tei:idno[@type = 'WIKIDATA']/text()">
                                    <tr>
                                        <th> Wikidata </th>
                                        <td>
                                            <a href="{./tei:idno[@type='WIKIDATA']}" target="_blank">
                                                <xsl:value-of
                                                  select="tokenize(./tei:idno[@type = 'WIKIDATA'], '/')[last()]"
                                                />
                                            </a>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="./tei:idno[@type = 'GEONAMES']/text()">
                                    <tr>
                                        <th> Geonames </th>
                                        <td>
                                            <a href="{./tei:idno[@type='GEONAMES']}" target="_blank">
                                                <xsl:value-of
                                                  select="tokenize(./tei:idno[@type = 'GEONAMES'], '/')[4]"
                                                />
                                            </a>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="./tei:listEvent">
                                    <tr>
                                        <th> Erwähnungen </th>
                                        <td>
                                            <ul>
                                                <xsl:for-each select=".//tei:event">
                                                  <xsl:variable name="linkToDocument">
                                                  <xsl:value-of
                                                  select="replace(tokenize(data(.//@target), '/')[last()], '.xml', '.html')"
                                                  />
                                                  </xsl:variable>
                                                  <xsl:choose>
                                                  <xsl:when
                                                  test="position() lt $showNumberOfMentions + 1">
                                                  <li>
                                                  <xsl:value-of select=".//tei:title"/>
                                                  <xsl:text> </xsl:text>
                                                  <a href="{$linkToDocument}">
                                                  <i class="fas fa-external-link-alt"/>
                                                  </a>
                                                  </li>
                                                  </xsl:when>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </ul>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <tr>
                                    <th/>
                                    <td> Anzahl der Erwähnungen limitiert, klicke <a
                                            href="{$selfLink}">hier</a> für eine vollständige
                                        Auflistung </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                            >Schließen</button>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="tei:listOrg">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:org">
        <xsl:param name="showNumberOfMentions" as="xs:integer" select="5"/>
        <xsl:variable name="selfLink">
            <xsl:value-of select="concat(data(@xml:id), '.html')"/>
        </xsl:variable>
        <div class="modal fade" id="{@xml:id}" data-bs-keyboard="false" tabindex="-1"
            aria-labelledby="{if(./tei:settlement) then(./tei:settlement/tei:placeName) else (./tei:placeName)}"
            aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">
                            <xsl:value-of select="
                                    if (./tei:settlement) then
                                        (./tei:settlement/tei:placeName)
                                    else
                                        (./tei:placeName)"/>
                        </h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Schließen"/>
                    </div>
                    <div class="modal-body">
                        <table class="table">
                            <tbody>
                                <xsl:if test="./tei:idno[@type = 'GEONAMES']">
                                    <tr>
                                        <th> Geonames ID </th>
                                        <td>
                                            <a href="{./tei:idno[@type='GEONAMES']}" target="_blank">
                                                <xsl:value-of
                                                  select="tokenize(./tei:idno[@type = 'GEONAMES'], '/')[4]"
                                                />
                                            </a>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="./tei:idno[@type = 'WIKIDATA']">
                                    <tr>
                                        <th> Wikidata ID </th>
                                        <td>
                                            <a href="{./tei:idno[@type='WIKIDATA']}" target="_blank">
                                                <xsl:value-of
                                                  select="tokenize(./tei:idno[@type = 'WIKIDATA'], '/')[last()]"
                                                />
                                            </a>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="./tei:idno[@type = 'GND']">
                                    <tr>
                                        <th> GND ID </th>
                                        <td>
                                            <a href="{./tei:idno[@type='GND']}" target="_blank">
                                                <xsl:value-of
                                                  select="tokenize(./tei:idno[@type = 'GND'], '/')[last()]"
                                                />
                                            </a>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="./tei:listEvent">
                                    <tr>
                                        <th> Erwähnungen </th>
                                        <td>
                                            <ul>
                                                <xsl:for-each select=".//tei:event">
                                                  <xsl:variable name="linkToDocument">
                                                  <xsl:value-of
                                                  select="replace(tokenize(data(.//@target), '/')[last()], '.xml', '.html')"
                                                  />
                                                  </xsl:variable>
                                                  <xsl:choose>
                                                  <xsl:when
                                                  test="position() lt $showNumberOfMentions + 1">
                                                  <li>
                                                  <xsl:value-of select=".//tei:title"/>
                                                  <xsl:text> </xsl:text>
                                                  <a href="{$linkToDocument}">
                                                  <i class="fas fa-external-link-alt"/>
                                                  </a>
                                                  </li>
                                                  </xsl:when>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </ul>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <tr>
                                    <th/>
                                    <td> Anzahl der Erwähnungen limitiert, klicke <a
                                            href="{$selfLink}">hier</a> für eine vollständige
                                        Auflistung </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                            >Schließen</button>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="tei:listBibl|tei:bibl[not(parent::tei:listBibl)]">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:listBibl/tei:bibl">
        <xsl:param name="showNumberOfMentions" as="xs:integer" select="5"/>
        <xsl:variable name="selfLink">
            <xsl:value-of select="concat(data(@xml:id), '.html')"/>
        </xsl:variable>
        <div class="modal fade" id="{@xml:id}" data-bs-keyboard="false" tabindex="-1"
            aria-labelledby="{./tei:title[@type='main']}" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">
                            <xsl:value-of select="./tei:title"/>
                        </h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Schließen"/>
                    </div>
                    <div class="modal-body">
                        <table class="table">
                            <tbody>
                                <tr>
                                    <th> Autor(en) </th>
                                    <td>
                                        <ul>
                                            <xsl:for-each select="./tei:author">
                                                <li>
                                                  <a href="{@xml:id}.html">
                                                  <xsl:value-of select="./tei:persName"/>
                                                  </a>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </td>
                                </tr>
                                <xsl:if test="./tei:idno[@type = 'GEONAMES']">
                                    <tr>
                                        <th> Geonames ID </th>
                                        <td>
                                            <a href="{./tei:idno[@type='GEONAMES']}" target="_blank">
                                                <xsl:value-of
                                                  select="tokenize(./tei:idno[@type = 'GEONAMES'], '/')[4]"
                                                />
                                            </a>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="./tei:idno[@type = 'WIKIDATA']">
                                    <tr>
                                        <th> Wikidata ID </th>
                                        <td>
                                            <a href="{./tei:idno[@type='WIKIDATA']}" target="_blank">
                                                <xsl:value-of
                                                  select="tokenize(./tei:idno[@type = 'WIKIDATA'], '/')[last()]"
                                                />
                                            </a>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="./tei:idno[@type = 'GND']">
                                    <tr>
                                        <th> GND ID </th>
                                        <td>
                                            <a href="{./tei:idno[@type='GND']}" target="_blank">
                                                <xsl:value-of
                                                  select="tokenize(./tei:idno[@type = 'GND'], '/')[last()]"
                                                />
                                            </a>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="./tei:listEvent">
                                    <tr>
                                        <th> Erwähnungen </th>
                                        <td>
                                            <ul>
                                                <xsl:for-each select=".//tei:event">
                                                  <xsl:variable name="linkToDocument">
                                                  <xsl:value-of
                                                  select="replace(tokenize(data(.//@target), '/')[last()], '.xml', '.html')"
                                                  />
                                                  </xsl:variable>
                                                  <xsl:choose>
                                                  <xsl:when
                                                  test="position() lt $showNumberOfMentions + 1">
                                                  <li>
                                                  <xsl:value-of select=".//tei:title"/>
                                                  <xsl:text> </xsl:text>
                                                  <a href="{$linkToDocument}">
                                                  <i class="fas fa-external-link-alt"/>
                                                  </a>
                                                  </li>
                                                  </xsl:when>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </ul>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <tr>
                                    <th/>
                                    <td> Anzahl der Erwähnungen limitiert, klicke <a
                                            href="{$selfLink}">hier</a> für eine vollständige
                                        Auflistung </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                            >Schließen</button>
                    </div>
                </div>
            </div>
        </div>
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
    <!-- <xsl:template match="tei:rs[@ref or @key]">
        <strong>
            <xsl:element name="a">
                <xsl:attribute name="data-bs-toggle">modal</xsl:attribute>
                <xsl:attribute name="data-target">
                    <xsl:value-of select="data(@ref)"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </strong>
    </xsl:template> -->
    
    <xsl:template match="tei:damage">
        <span class="damage-critical">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:pb">
        <xsl:choose>
            <xsl:when test="starts-with(@facs, 'http') or starts-with(@facs, 'www.')">
                <xsl:element name="a">
                    <xsl:variable name="href">
                        <xsl:choose>
                            <xsl:when test="not(starts-with(@facs, 'http'))">
                                <xsl:value-of select="concat('https://', @facs)"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="@facs"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:attribute name="href">
                        <xsl:value-of select="$href"/>
                    </xsl:attribute>
                    <xsl:attribute name="target">
                        <xsl:text>_blank</xsl:text>
                    </xsl:attribute>
                    <i class="fas fa-external-link-alt"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <span class="pagebreak" title="Seitenbeginn">
                    <xsl:text>|</xsl:text>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
