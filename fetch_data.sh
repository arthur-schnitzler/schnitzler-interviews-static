# bin/bash

# get schnitzler-chronik-data

# Download XML files from GitHub repository
wget https://github.com/arthur-schnitzler/schnitzler-chronik-data/archive/refs/heads/main.zip
rm -rf chronik-data
unzip main.zip

mv schnitzler-chronik-data-main/editions/data chronik-data/
rm -rf schnitzler-chronik-data-main

rm main.zip



# echo "delete schema reference"
# find ./data/editions/ -type f -name "*.xml"  -print0 | xargs -0 sed -i -e 's@xsi:schemaLocation="http://www.tei-c.org/ns/1.0 ../meta/asbwschema.xsd"@@g'

# echo "fixing entity ids"
# find ./data/indices/ -type f -name "*.xml"  -print0 | xargs -0 sed -i -e 's@<person xml:id="person__@<person xml:id="pmb@g'

# get schnitzler-briefe-tex

# rm -rf .html/L*.pdf
# wget https://github.com/arthur-schnitzler/schnitzler-briefe-tex/archive/refs/heads/main.zip
# unzip main

# mv ./schnitzler-briefe-tex-main/pdf-leseansicht/L*.pdf ./html
# rm main.zip
# rm -rf ./schnitzler-briefe-tex-main
