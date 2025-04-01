import glob
import os

from typesense.api_call import ObjectNotFound
from acdh_cfts_pyutils import TYPESENSE_CLIENT as client, CFTS_COLLECTION
from acdh_tei_pyutils.tei import TeiReader
from acdh_tei_pyutils.utils import (
    extract_fulltext,
    get_xmlid,
    make_entity_label,
)
from acdh_xml_pyutils.xml import NSMAP as nsmap
from tqdm import tqdm


files = glob.glob("./data/editions/*.xml")
tag_blacklist = [
    "{http://www.tei-c.org/ns/1.0}abbr",
    "{http://www.tei-c.org/ns/1.0}del",
]

COLLECTION_NAME = "schnitzler-interviews"
MIN_DATE = "1887"


try:
    client.collections[COLLECTION_NAME].delete()
except ObjectNotFound:
    pass

current_schema = {
    "name": COLLECTION_NAME,
    "enable_nested_fields": True,
    "fields": [
        {"name": "id", "type": "string", "sort": True},
        {"name": "rec_id", "type": "string", "sort": True},
        {"name": "title", "type": "string", "sort": True},
        {"name": "full_text", "type": "string", "sort": True},
        {
            "name": "year",
            "type": "int32",
            "optional": True,
            "facet": True,
            "sort": True,
        },
        {"name": "sender", "type": "object[]", "facet": True, "optional": True},
        {"name": "receiver", "type": "object[]", "facet": True, "optional": True},
        {"name": "persons", "type": "object[]", "facet": True, "optional": True},
        {"name": "places", "type": "object[]", "facet": True, "optional": True},
        {"name": "works", "type": "object[]", "facet": True, "optional": True},
        {"name": "orgs", "type": "object[]", "facet": True, "optional": True},
    ],
}

client.collections.create(current_schema)
dates = set()
records = []
cfts_records = []
for x in tqdm(files, total=len(files)):
    cfts_record = {
        "project": COLLECTION_NAME,
    }
    record = {}

    doc = TeiReader(x)
    try:
        body = doc.any_xpath(".//tei:body")[0]
    except IndexError:
        continue
    record["id"] = os.path.split(x)[-1].replace(".xml", "")
    cfts_record["id"] = record["id"]
    cfts_record["resolver"] = (
        f"https://schnitzler-interviews.acdh.oeaw.ac.at/{record['id']}.html"
    )
    record["rec_id"] = os.path.split(x)[-1].replace(".xml", "")
    cfts_record["rec_id"] = record["rec_id"]
    record["title"] = extract_fulltext(
        doc.any_xpath(".//tei:titleStmt/tei:title[@level='a']")[0]
    )
    cfts_record["title"] = record["title"]
    try:
        date_str = doc.any_xpath("//tei:title[@type='iso-date'][1]/@when-iso")[0]
    except IndexError:
        date_str = MIN_DATE
    try:
        record["year"] = int(date_str[:4])
        cfts_record["year"] = int(date_str[:4])
    except ValueError:
        pass
    record["persons"] = []
    cfts_record["persons"] = []
    for y in doc.any_xpath(".//tei:back//tei:person"):
        item = {"id": get_xmlid(y), "label": make_entity_label(y.xpath("./*[1]")[0])[0]}
        record["persons"].append(item)
        cfts_record["persons"].append(item["label"])

    record["works"] = []
    cfts_record["works"] = []
    for y in doc.any_xpath(".//tei:back//tei:bibl[@xml:id]"):
        title = y.xpath("./tei:title[1]", namespaces=nsmap)[0]
        item = {
            "id": get_xmlid(y),
            "label": extract_fulltext(title),
        }
        record["works"].append(item)
        cfts_record["works"].append(item["label"])

    record["places"] = []
    cfts_record["places"] = []
    for y in doc.any_xpath(".//tei:back//tei:place[@xml:id]"):
        item = {"id": get_xmlid(y), "label": make_entity_label(y.xpath("./*[1]")[0])[0]}
        record["places"].append(item)
        cfts_record["places"].append(item["label"])

    record["orgs"] = []
    cfts_record["orgs"] = []
    for y in doc.any_xpath(".//tei:back//tei:org[@xml:id]"):
        item = {"id": get_xmlid(y), "label": make_entity_label(y.xpath("./*[1]")[0])[0]}
        record["orgs"].append(item)
        cfts_record["orgs"].append(item["label"])

    record["full_text"] = extract_fulltext(body, tag_blacklist=tag_blacklist)
    cfts_record["full_text"] = record["full_text"]
    records.append(record)
    cfts_records.append(cfts_record)

make_index = client.collections[COLLECTION_NAME].documents.import_(records)
print(make_index)
print(f"done with indexing {COLLECTION_NAME}")

make_index = CFTS_COLLECTION.documents.import_(cfts_records, {"action": "upsert"})
print(make_index)
print(f"done with cfts-index {COLLECTION_NAME}")
