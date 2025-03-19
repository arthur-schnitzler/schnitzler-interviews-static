# bin/bash

echo "fetching transkriptions from data_repo"
rm -rf data/
curl -LO https://github.com/arthur-schnitzler/schnitzler-interviews-data/archive/refs/heads/main.zip
unzip main

mv ./schnitzler-interviews-data-main/data/ .

rm main.zip
rm -rf ./schnitzler-interviews-data-main

echo "fetch imprint"
./shellscripts/dl_imprint.sh
