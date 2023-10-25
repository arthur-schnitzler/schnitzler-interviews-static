<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:template match="/" name="nav_bar">
        <nav class="navbar navbar-expand-md" style="padding-top:1px;">
            <div class="container-fluid">
                <a href="index.html" class="navbar-brand custom-logo-link" rel="home" itemprop="url">
                    <img src="images/schnitzler-interviews.svg" class="img-fluid" title="schnitzler-interviews"
                        alt="schnitzler-interviews" itemprop="logo"/>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                    aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"/>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button"
                                data-bs-toggle="dropdown" aria-expanded="false"> Projekt </a>
                            <ul class="dropdown-menu">
                                <li class="nav-item dropdown-submenu">
                                    <a class="nav-link" href="about.html">Zum Projekt</a>
                                </li>
                                <li class="nav-item dropdown-submenu">
                                    <a class="nav-link" style="color: #D3D3D3;">Danksagung</a>
                                </li>
                                
                                <li class="nav-item dropdown-submenu">
                                    <a class="nav-link" href="editorisch.html"
                                        >Editionsrichtlinien</a>
                                </li>
                                <li class="nav-item dropdown-submenu">
                                    <a class="nav-link" href="textauswahl.html"
                                        >Zur Textauswahl</a>
                                </li>
                                <li class="nav-item dropdown-submenu">
                                    <a class="nav-link" style="color: #D3D3D3;">Nachwort</a>
                                    
                                </li>
                                <li class="nav-item dropdown-submenu">
                                    <a class="nav-link" style="color: #D3D3D3;">Literatur</a>
                                    
                                </li>
                                <li class="nav-item dropdown-submenu">
                                    <a title="Schnitzler am ACDH-CH" href="https://schnitzler.acdh.oeaw.ac.at"
                                        class="nav-link" target="_blank">Schnitzler am ACDH-CH</a>
                                </li>
                               
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="calendar.html">Kalender</a>
                        </li>
                        <li class="nav-item dropdown dropleft">
                            <a class="nav-link dropdown-toggle" href="#" role="button"
                                data-bs-toggle="dropdown" aria-expanded="false"> Index </a>
                            <ul class="dropdown-menu">
                                <li class="nav-item dropdown-submenu">
                                    <a class="nav-link" href="listperson.html">Personen</a>
                                </li>
                                <li class="nav-item dropdown-submenu">
                                    <a class="nav-link" href="listbibl.html">Werke</a>
                                </li>
                                <li class="nav-item dropdown-submenu">
                                    <a class="nav-link" href="listplace.html">Orte</a>
                                </li>
                                <li class="nav-item dropdown-submenu">
                                    <a class="nav-link" href="listorg.html">Institutionen</a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="toc.html">Inhaltsverzeichnis</a>
                        </li>
                     <!--   <li class="nav-item">
                            <a title="Suche" class="nav-link" href="search.html"><svg
                                    xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                    class="feather feather-search">
                                    <circle cx="11" cy="11" r="8"/>
                                    <line x1="21" y1="21" x2="16.65" y2="16.65"/>
                                </svg> SUCHE</a>
                        </li>-->
                    </ul>
                </div>
            </div>
        </nav>


    </xsl:template>
</xsl:stylesheet>
