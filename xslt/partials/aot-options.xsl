<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xsl tei" version="2.0">
    
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget annotation options.</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied with call-templates in html:body.</p>
            <p>Custom template to create interactive options for text annoations.</p>
        </desc>    
    </doc>
    
    <xsl:template name="annotation-options">
        <div id="aot-navBarNavDropdown" class="navBarNavDropdown dropstart">
            <!-- Your menu goes here -->
            <a title="Annotationen" href="#" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false" role="button">
                <i class="bi bi-gear" title="Menü zur Anpassung der Anzeige"></i>
            </a>                  
            <ul class="dropdown-menu">
                <li class="dropdown-item">
                    <annotation-slider opt="prs"></annotation-slider>
                </li>
                <li class="dropdown-item">
                    <annotation-slider opt="plc"></annotation-slider>
                </li>
                <li class="dropdown-item">
                    <annotation-slider opt="wrk"></annotation-slider>
                </li>
                <li class="dropdown-item">
                    <annotation-slider opt="org"></annotation-slider>
                </li>
            </ul>                                                    
        </div>
        
    </xsl:template>
</xsl:stylesheet>