#!/bin/bash

echo "check and delete faulty files"
python delete_faulty_files.py

echo "add mentions"
python add_mentions.py

echo "add questions"
python add_questions.py

echo "make calendar data"
python make_calendar_data.py

echo "fetch relations"
python3 xslt/export/fetch_relations.py

echo "create app"
ant