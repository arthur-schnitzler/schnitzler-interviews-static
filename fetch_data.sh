# bin/bash

echo "fetching transkriptions from data_repo"
rm -rf data/
curl -LO https://github.com/arthur-schnitzler/schnitzler-interviews-data/archive/refs/heads/main.zip
unzip main

mv ./schnitzler-interviews-data-main/data/ .

rm main.zip
rm -rf ./schnitzler-interviews-data-main

# get schnitzler-chronik-data

# Download XML files from GitHub repository
wget https://github.com/arthur-schnitzler/schnitzler-chronik-data/archive/refs/heads/main.zip
rm -rf chronik-data
unzip main.zip

mv schnitzler-chronik-data-main/editions/data chronik-data/
rm -rf schnitzler-chronik-data-main

rm main.zip

echo "fetch imprint"
./shellscripts/dl_imprint.sh
