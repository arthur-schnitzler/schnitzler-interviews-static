<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar" exclude-result-prefixes="xs" version="3.0">
    <xsl:template
        match="tei:ref[not(@type = 'schnitzler-tagebuch') and not(@type = 'schnitzler-briefe') and not(@type = 'schnitzler-bahr') and not(@type = 'schnitzler-lektueren') and not(@type = 'schnitzler-interviews') and not(@type='pointer')  and not(@type='question')]">
        <xsl:choose>
            <xsl:when test="@target[ends-with(., '.xml')]">
                <xsl:element name="a">
                    <xsl:attribute name="class">reference-black</xsl:attribute>
                    <xsl:attribute name="href"> show.html?ref=<xsl:value-of
                            select="tokenize(./@target, '/')[4]"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:ref[@type = 'schnitzler-tagebuch']">
        <xsl:choose>
            <xsl:when test="@subtype = 'date-only'">
                <a>
                    <xsl:attribute name="class">reference-black</xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of
                            select="concat('https://schnitzler-tagebuch.acdh.oeaw.ac.at/entry__', @target, '.html')"
                        />
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="@target = ''">
                            <xsl:text>FEHLER</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="format-date(@target, '[D].&#160;[M].&#160;[Y]')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@subtype = 'See'">
                        <xsl:text>Siehe </xsl:text>
                    </xsl:when>
                    <xsl:when test="@subtype = 'Cf'">
                        <xsl:text>Vgl. </xsl:text>
                    </xsl:when>
                    <xsl:when test="@subtype = 'see'">
                        <xsl:text>siehe </xsl:text>
                    </xsl:when>
                    <xsl:when test="@subtype = 'cf'">
                        <xsl:text>vgl. </xsl:text>
                    </xsl:when>
                </xsl:choose>
                <a>
                    <xsl:attribute name="class">reference-black</xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of
                            select="concat('https://schnitzler-tagebuch.acdh.oeaw.ac.at/entry__', @target, '.html')"
                        />
                    </xsl:attribute>
                    <xsl:text>A. S.: Tagebuch, </xsl:text>
                    <xsl:value-of select="format-date(@target, '[D].&#160;[M].&#160;[Y]')"/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template
        match="tei:ref[@type = 'schnitzler-briefe' or @type = 'schnitzler-bahr' or @type = 'schnitzler-lektueren' or @type='schnitzler-interviews']">
        <xsl:variable name="type-url" as="xs:string">
            <xsl:choose>
                <xsl:when test="@type = 'schnitzler-briefe'">
                    <xsl:text>https://schnitzler-briefe.acdh.oeaw.ac.at/</xsl:text>
                </xsl:when>
                <xsl:when test="@type = 'schnitzler-bahr'">
                    <xsl:text>https://schnitzler-bahr.acdh.oeaw.ac.at/</xsl:text>
                </xsl:when>
                <xsl:when test="@type = 'schnitzler-lektueren'">
                    <xsl:text>https://schnitzler-lektueren.acdh.oeaw.ac.at/</xsl:text>
                </xsl:when>
                <xsl:when test="@type = 'schnitzler-interviews'">
                    <xsl:text></xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="ref-mit-endung" as="xs:string">
            <xsl:choose>
                <xsl:when test="contains(@target, '.xml')">
                    <xsl:value-of select="replace(@target, '.xml', '.html')"/>
                </xsl:when>
                <xsl:when test="contains(@target, '.html')">
                    <xsl:value-of select="@target"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat(@target, '.html')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@subtype = 'date-only'">
                <a>
                    <xsl:attribute name="class">reference-black</xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="concat($type-url, $ref-mit-endung)"/>
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="@type = 'schnitzler-briefe'">
                            <xsl:value-of
                                select="document(concat('https://raw.githubusercontent.com/arthur-schnitzler/schnitzler-briefe-data/main/data/editions/', replace($ref-mit-endung, '.html', '.xml')))/descendant::tei:correspDesc[1]/tei:correspAction[1]/tei:date[1]/text()"
                            />
                        </xsl:when>
                        <xsl:when test="@type = 'schnitzler-interviews'">
                            <xsl:value-of
                                select="document(concat('https://raw.githubusercontent.com/arthur-schnitzler/schnitzler-interviews-static/main/data/editions/', replace($ref-mit-endung, '.html', '.xml')))/descendant::tei:titleStmt[1]/tei:title[@type='iso-date'][1]/text()"
                            />
                        </xsl:when>
                        <xsl:when test="@type = 'schnitzler-bahr'">
                            <xsl:value-of
                                select="document(concat('https://raw.githubusercontent.com/arthur-schnitzler/schnitzler-bahr-data/main/data/editions/', replace($ref-mit-endung, '.html', '.xml')))/descendant::tei:dateSender[1]/tei:date[1]/text()"
                            />
                        </xsl:when>
                        <xsl:when test="@type = 'schnitzler-interviews'">
                            <xsl:value-of
                                select="document(concat('https://raw.githubusercontent.com/arthur-schnitzler/schnitzler-interviews-static/main/data/editions/', replace($ref-mit-endung, '.html', '.xml')))/descendant::tei:dateSender[1]/tei:date[1]/text()"
                            />
                        </xsl:when>
                        
                    </xsl:choose>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@subtype = 'See'">
                        <xsl:text>Siehe </xsl:text>
                    </xsl:when>
                    <xsl:when test="@subtype = 'Cf'">
                        <xsl:text>Vgl. </xsl:text>
                    </xsl:when>
                    <xsl:when test="@subtype = 'see'">
                        <xsl:text>siehe </xsl:text>
                    </xsl:when>
                    <xsl:when test="@subtype = 'cf'">
                        <xsl:text>vgl. </xsl:text>
                    </xsl:when>
                </xsl:choose>
                <a>
                    <xsl:attribute name="class">reference-black</xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="concat($type-url, $ref-mit-endung)"/>
                    </xsl:attribute>
                    <xsl:variable name="dateiname-xml" as="xs:string?">
                        <xsl:choose>
                            <xsl:when test="@type = 'schnitzler-briefe'">
                                <xsl:value-of select="concat('https://raw.githubusercontent.com/arthur-schnitzler/schnitzler-briefe-data/main/data/editions/', replace($ref-mit-endung, '.html', '.xml'))"/>
                            </xsl:when>
                            <xsl:when test="@type = 'schnitzler-bahr'">
                                <xsl:value-of select="concat('https://raw.githubusercontent.com/arthur-schnitzler/schnitzler-bahr-data/main/data/editions/', replace($ref-mit-endung, '.html', '.xml'))"/>
                            </xsl:when>
                            <xsl:when test="@type = 'schnitzler-lektueren'">
                                <xsl:value-of select="concat('https://raw.githubusercontent.com/arthur-schnitzler/schnitzler-lektueren/main/data/editions/', replace($ref-mit-endung, '.html', '.xml'))"/>
                            </xsl:when>
                            <xsl:when test="@type = 'schnitzler-interviews'">
                                <xsl:value-of select="concat('https://raw.githubusercontent.com/arthur-schnitzler/schnitzler-interviews-static/main/data/editions/', replace($ref-mit-endung, '.html', '.xml'))"/>
                            </xsl:when>
                        </xsl:choose>
                        
                    </xsl:variable>
                   <xsl:choose>
                       <xsl:when test="document($dateiname-xml)/child::*[1]">
                           <xsl:value-of
                               select="document($dateiname-xml)/descendant::tei:titleStmt[1]/tei:title[@level = 'a'][1]/text()"
                           />
                       </xsl:when>
                       <xsl:otherwise>
                           <xsl:value-of select="$dateiname-xml"/>
                       </xsl:otherwise>
                   </xsl:choose>
                    
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:ref[@type='question']">
        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:value-of select="replace(@target, '#', '')"/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:ref[@type='pointer']">
        <xsl:choose>
            <xsl:when test="string-length(@target)=5 and (starts-with(@target, '#I') or starts-with(@target, '#M') or starts-with(@target, '#P'))">
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:value-of select="concat(replace(@target, '#', ''), '.html')"/>
                    </xsl:attribute>
                    <i class="fas fa-external-link-alt"/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="starts-with(@target, '#K') or starts-with(@target, '#L')">
                <xsl:analyze-string select="@target" regex="^#([KEL])_([IMP]\d{{3}})-(\d{{1,2}})$">
                    <xsl:matching-substring>
                        <xsl:variable name="hyperlink" 
                            select="concat(regex-group(2), '.html#', regex-group(1), '_', regex-group(2), '-', regex-group(3), 'h')"/>
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="$hyperlink"/>
                            </xsl:attribute>
                            <i class="fas fa-external-link-alt"/>
                        </xsl:element>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <i class="fas fa-external-link-alt"/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:when>
            <xsl:when test="starts-with(@target, '#I') or starts-with(@target, '#M') or starts-with(@target, '#P')">
                <xsl:analyze-string select="@target" regex="^#([IMP]\d{{3}})_[lL].+">
                    <xsl:matching-substring>
                        <xsl:variable name="hyperlink" 
                            select="concat(regex-group(1), '.html', .)"/>
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="$hyperlink"/>
                            </xsl:attribute>
                            <i class="fas fa-external-link-alt"/>
                        </xsl:element>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <i class="fas fa-external-link-alt"/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:when>
            <xsl:when test="starts-with(@target, '#E_')">
                <xsl:analyze-string select="@target" regex="^#[E]_[a-zA-Z0-9]*_L*">
                    <xsl:matching-substring>
                        <xsl:variable name="hyperlink" 
                            select="concat(regex-group(1), '.html', .)"/>
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="$hyperlink"/>
                            </xsl:attribute>
                            <i class="fas fa-external-link-alt"/>
                        </xsl:element>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <i class="fas fa-external-link-alt"/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:when>
            <xsl:when test="starts-with(@target, '#L') or starts-with(@target, '#E') or (@target='#politischermord')">
                <i class="fas fa-external-link-alt"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="target-datei" >
                    <xsl:choose>
                        <xsl:when test="contains(@target, '_')">
                            <xsl:value-of select="replace(tokenize(@target, '_')[1], '#', '')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="replace(@target, '#', '')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="target-datei-url" select="concat('https://raw.githubusercontent.com/arthur-schnitzler/schnitzler-interviews-data/refs/heads/main/data/editions/', $target-datei, '.xml')"/>
                <xsl:variable name="target-anchor"/>
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:value-of select="concat($target-datei, '.html')"/>
                    </xsl:attribute>
                    <xsl:value-of select="document($target-datei-url)/descendant::*:TEI[1]/*:teiHeader[1]/*:fileDesc[1]/*:titleStmt[1]/*:title[@level='a'][1]"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    <xsl:template match="tei:anchor[@type='label']">
        <span><xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:apply-templates/></span>
    </xsl:template>
</xsl:stylesheet>
