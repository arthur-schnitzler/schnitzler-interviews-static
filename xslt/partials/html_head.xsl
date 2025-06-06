<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:include href="./params.xsl"/>
    <xsl:template match="/" name="html_head">
        <xsl:param name="html_title" select="$project_short_title"/>
        <xsl:variable name="html_title1">
            <!-- brachialer Eingriff für index -->
            <xsl:choose>
                <xsl:when test="$html_title = 'Meta' or $html_title = 'meta'">
                    <xsl:text>schnitzler-interviews</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$html_title"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
        <meta name="mobile-web-app-capable" content="yes"/>
        <meta name="apple-mobile-web-app-capable" content="yes"/>
        <meta name="apple-mobile-web-app-title" content="{$html_title1}"/>
        <meta name="msapplication-TileColor" content="#ffffff"/>
        <meta name="msapplication-TileImage" content="{$project_logo}"/>
        <link rel="icon" type="image/svg+xml" href="{$project_logo}" sizes="any"/>
        <link rel="shortcut icon" href="data/images/symbole/favicon.png"/>
        <link rel="shortcut icon" href="./img/favicon/favicon.png"/>
        <link rel="icon" href="./img/favicon/favicon.png"/>
        <link rel="apple-touch-icon" sizes="57x57" href="./img/favicon/apple-icon-57x57.png"/>
        <link rel="apple-touch-icon" sizes="60x60" href="./img/favicon/apple-icon-60x60.png"/>
        <link rel="apple-touch-icon" sizes="72x72" href="./img/favicon/apple-icon-72x72.png"/>
        <link rel="apple-touch-icon" sizes="76x76" href="./img/favicon/apple-icon-76x76.png"/>
        <link rel="apple-touch-icon" sizes="114x114" href="./img/favicon/apple-icon-114x114.png"/>
        <link rel="apple-touch-icon" sizes="120x120" href="./img/favicon/apple-icon-120x120.png"/>
        <link rel="apple-touch-icon" sizes="144x144" href="./img/favicon/apple-icon-144x144.png"/>
        <link rel="apple-touch-icon" sizes="152x152" href="./img/favicon/apple-icon-152x152.png"/>
        <link rel="apple-touch-icon" sizes="180x180" href="./img/favicon/apple-icon-180x180.png"/>
        <link rel="icon" type="image/png" sizes="192x192"
            href="./img/favicon/android-icon-192x192.png"/>
        <link rel="icon" type="image/png" sizes="32x32" href="./img/favicon/favicon-32x32.png"/>
        <link rel="icon" type="image/png" sizes="96x96" href="./img/favicon/favicon-96x96.png"/>
        <link rel="icon" type="image/png" sizes="16x16" href="./img/favicon/favicon-16x16.png"/>
        <link rel="profile" href="http://gmpg.org/xfn/11"/>
        <title>
            <xsl:value-of select="$html_title1"/>
        </title>
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
            integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
            crossorigin="anonymous" referrerpolicy="no-referrer"/>
        <link rel="stylesheet" type="text/css"
            href="https://cdn.datatables.net/v/bs4/jq-3.3.1/jszip-2.5.0/dt-1.11.0/b-2.0.0/b-html5-2.0.0/cr-1.5.4/r-2.2.9/sp-1.4.0/datatables.min.css"/>
        <link rel="profile" href="http://gmpg.org/xfn/11"/>
        <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
            crossorigin="anonymous"/>
        <script src="js/listStopProp.js"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/PapaParse/5.3.0/papaparse.min.js"/>
        <link rel="stylesheet" href="css/style.css" type="text/css"/>
        <link rel="stylesheet" href="css/micro-editor.css" type="text/css"/>
        <!-- Matomo -->
        <script type="text/javascript">
            var _paq = _paq ||[];
            /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
            _paq.push([ 'trackPageView']);
            _paq.push([ 'enableLinkTracking']);
            (function () {
            var u = "https://matomo.acdh.oeaw.ac.at/";
            _paq.push([ 'setTrackerUrl', u + 'piwik.php']);
            _paq.push([ 'setSiteId', '236']);<!--
                236 is Matomo Code schnitzler - interviews//-->
            var d = document, g = d.createElement('script'), s = d.getElementsByTagName('script')[0];
            g.type = 'text/javascript';
            g. async = true;
            g.defer = true;
            g.src = u + 'piwik.js';
            s.parentNode.insertBefore(g, s);
            })();</script>
        <!-- End Matomo Code -->
    </xsl:template>
</xsl:stylesheet>
