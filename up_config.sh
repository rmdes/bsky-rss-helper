#!/bin/bash
# this scripts is at the root of the parent folder where your newsbots are kept
# and it will check each sub folder and set the config.json inside each /data/ directory
# for each of the bots. 

# it Update config.json without overwriting existing fields


# Loop through all subfolders
for dir in */; do
  # Extract parent folder name
  parent_folder=$(basename $dir)

  # Extract language from parent folder name
  lang="${parent_folder##*-}"

  # Path to config.json
  config_path="${dir}data/config.json"
  
  # Check if config.json exists
  if [[ -f $config_path ]]; then
    # Update only missing fields and languages
    jq --arg lang "$lang" '.string = (.string // "$title") | .publishEmbed = (.publishEmbed // true) | .languages = (.languages // [$lang]) | .truncate = (.truncate // true) | .runInterval = (.runInterval // 60) | .dateField = (.dateField // "") | .imageField = (.imageField // "") | .ogUserAgent = (.ogUserAgent // "")' $config_path > temp.json && mv temp.json $config_path
  fi
done
