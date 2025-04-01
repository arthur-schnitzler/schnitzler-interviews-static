#!/bin/bash

echo "check and delete faulty files"
python delete_faulty_files.py

echo "add mentions"
python add_mentions.py

echo "make calendar data"
python make_calendar_data.py

echo "create app"
ant