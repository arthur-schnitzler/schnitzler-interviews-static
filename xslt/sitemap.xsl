<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
    version="2.0">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:param name="base_url">schnitzler-interviews.acdh.oeaw.ac.at</xsl:param>

    <xsl:template match="/">
        <urlset>
            <!-- Static pages -->
            <url>
                <loc>https://<xsl:value-of select="$base_url"/>/index.html</loc>
                <changefreq>monthly</changefreq>
                <priority>1.0</priority>
            </url>
            <url>
                <loc>https://<xsl:value-of select="$base_url"/>/toc.html</loc>
                <changefreq>weekly</changefreq>
                <priority>0.9</priority>
            </url>
            <url>
                <loc>https://<xsl:value-of select="$base_url"/>/calendar.html</loc>
                <changefreq>weekly</changefreq>
                <priority>0.9</priority>
            </url>
            <url>
                <loc>https://<xsl:value-of select="$base_url"/>/listperson.html</loc>
                <changefreq>weekly</changefreq>
                <priority>0.8</priority>
            </url>
            <url>
                <loc>https://<xsl:value-of select="$base_url"/>/listplace.html</loc>
                <changefreq>weekly</changefreq>
                <priority>0.8</priority>
            </url>
            <url>
                <loc>https://<xsl:value-of select="$base_url"/>/listorg.html</loc>
                <changefreq>weekly</changefreq>
                <priority>0.8</priority>
            </url>
            <url>
                <loc>https://<xsl:value-of select="$base_url"/>/listwork.html</loc>
                <changefreq>weekly</changefreq>
                <priority>0.8</priority>
            </url>
            <url>
                <loc>https://<xsl:value-of select="$base_url"/>/listbibl.html</loc>
                <changefreq>weekly</changefreq>
                <priority>0.8</priority>
            </url>
            <url>
                <loc>https://<xsl:value-of select="$base_url"/>/questions.html</loc>
                <changefreq>monthly</changefreq>
                <priority>0.7</priority>
            </url>
            <url>
                <loc>https://<xsl:value-of select="$base_url"/>/imprint.html</loc>
                <changefreq>yearly</changefreq>
                <priority>0.3</priority>
            </url>

            <!-- Dynamic content from TEI files -->
            <xsl:for-each select="collection('../data/editions?select=*.xml')//tei:TEI">
                <xsl:variable name="filename" select="tokenize(document-uri(/), '/')[last()]"/>
                <xsl:variable name="htmlfile" select="replace($filename, '.xml', '.html')"/>
                <url>
                    <loc>https://<xsl:value-of select="$base_url"/>/<xsl:value-of select="$htmlfile"/></loc>
                    <changefreq>monthly</changefreq>
                    <priority>0.9</priority>
                </url>
            </xsl:for-each>
        </urlset>
    </xsl:template>
</xsl:stylesheet>
