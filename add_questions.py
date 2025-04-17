#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import glob
import os
import lxml.etree as ET
from acdh_tei_pyutils.tei import TeiReader  # Stelle sicher, dass dieses Paket installiert ist (pip install acdh-tei-pyutils)
from collections import defaultdict
from tqdm import tqdm

# --- Konfiguration ---
EDITIONS_GLOB_PATTERN = './data/editions/*.xml'
QUESTIONS_FILE_PATH = './data/indices/questions.xml'
TEI_NAMESPACE = "http://www.tei-c.org/ns/1.0"
XML_NAMESPACE = "http://www.w3.org/XML/1998/namespace"
# --------------------

# 1. Sammle alle Referenzen aus den Editionsdateien
edition_files = glob.glob(EDITIONS_GLOB_PATTERN)
mentions_index = defaultdict(set) # Dictionary: key=xml:id (ohne #), value=set von Mention-Strings

print(f"Durchsuche {len(edition_files)} Editionsdateien nach Referenzen...")
for file_path in tqdm(sorted(edition_files), total=len(edition_files)):
    try:
        doc = TeiReader(file_path)
        file_name = os.path.basename(file_path)

        # Extrahiere Titel und Datum aus dem Header
        doc_title_list = doc.any_xpath('.//tei:titleStmt/tei:title[@level="a"]/text()')
        doc_title = doc_title_list[0].strip() if doc_title_list else "Unbekannter Titel"

        doc_date_list = doc.any_xpath('.//tei:titleStmt/tei:title[@type="iso-date"]/@when-iso')
        # Nimm das erste Datum, falls mehrere vorhanden sind, oder leeren String
        doc_date = doc_date_list[0] if doc_date_list else ""

        # Finde alle <ref>-Elemente, deren target-Attribut mit '#' beginnt
        references = doc.any_xpath('.//tei:ref[starts-with(@target, "#")]/@target')

        for target_attr in references:
            # Extrahiere die ID (z.B. 'q074' aus '#q074')
            referenced_id = target_attr.lstrip('#')
            if referenced_id:
                # Speichere die Information über die Fundstelle
                mention_info = f"{file_name}_____{doc_title}_____{doc_date}"
                mentions_index[referenced_id].add(mention_info)

    except Exception as e:
        print(f"\nFehler beim Verarbeiten von {file_path}: {e}")

print(f"\n{len(mentions_index)} eindeutige IDs gefunden.")

# 2. Aktualisiere die questions.xml Datei
print(f"\nAktualisiere Datei: {QUESTIONS_FILE_PATH}")
if not os.path.exists(QUESTIONS_FILE_PATH):
    print(f"FEHLER: Datei {QUESTIONS_FILE_PATH} nicht gefunden!")
else:
    try:
        doc = TeiReader(QUESTIONS_FILE_PATH)
        items_updated = 0
        notes_added = 0

        # Finde alle <item>-Elemente mit xml:id im body
        item_nodes = doc.any_xpath('.//tei:body//tei:item[@xml:id]')

        for node in tqdm(item_nodes, total=len(item_nodes)):
            # Hole die xml:id des aktuellen Items
            node_id = node.xpath('@xml:id', namespaces={'xml': XML_NAMESPACE})
            if not node_id:
                continue # Überspringe Items ohne xml:id
            node_id = node_id[0]

            # Prüfe, ob für diese ID Referenzen gefunden wurden
            if node_id in mentions_index:
                items_updated += 1
                # Sortiere die Fundstellen alphabetisch nach Dateinamen für konsistente Reihenfolge
                sorted_mentions = sorted(list(mentions_index[node_id]))

                for mention in sorted_mentions:
                    try:
                        file_name, doc_title, doc_date = mention.split('_____')

                        # Erstelle das neue <note>-Element im TEI-Namespace
                        note = ET.Element(f'{{{TEI_NAMESPACE}}}note')
                        note.attrib['target'] = file_name
                        if doc_date: # Füge corresp nur hinzu, wenn ein Datum vorhanden ist
                            note.attrib['corresp'] = doc_date
                        note.attrib['type'] = "mentions"
                        note.text = doc_title

                        # Füge die Note dem Item-Node hinzu
                        node.append(note)
                        notes_added += 1
                    except ValueError:
                         print(f"\nWARNUNG: Konnte Mention-String nicht parsen: '{mention}' für ID {node_id}")


        # Speichere die Änderungen zurück in die Datei
        if items_updated > 0:
            doc.tree_to_file(QUESTIONS_FILE_PATH)
            print(f"\nDatei '{QUESTIONS_FILE_PATH}' erfolgreich aktualisiert.")
            print(f"{items_updated} <item>-Elemente wurden modifiziert.")
            print(f"{notes_added} <note>-Elemente wurden hinzugefügt.")
        else:
            print("\nKeine Änderungen an der Datei vorgenommen (keine passenden Referenzen gefunden).")

    except Exception as e:
        print(f"\nFehler beim Aktualisieren von {QUESTIONS_FILE_PATH}: {e}")

print("\nSkript beendet.")