#!/bin/bash
# This script is at the root of the parent folder where your newsbots are kept.
# It checks each subfolder and sets the config.json inside each /data/ directory
# for each of the bots without overwriting existing fields.

# Loop through all subfolders
for dir in */; do
  # Extract parent folder name
  parent_folder=$(basename "$dir")

  # Extract language from parent folder name
  lang="${parent_folder##*-}"

  # Path to config.json
  config_path="${dir}data/config.json"
  
  # Check if config.json exists
  if [[ -f "$config_path" ]]; then
    # Update only missing fields and languages, including new fields
    jq --arg lang "$lang" \
       --arg ogUserAgent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:89.0) Gecko/20100101 Firefox/89.0" \
       '.string = (.string // "$title") | 
        .publishEmbed = (.publishEmbed // true) | 
        .embedType = (.embedType // "card") | 
        .languages = (.languages // [$lang]) | 
        .ogUserAgent = (.ogUserAgent // $ogUserAgent) | 
        .truncate = (.truncate // true) | 
        .runInterval = (.runInterval // 60) | 
        .dateField = (.dateField // "") | 
        .imageField = (.imageField // "") | 
        .imageAlt = (.imageAlt // "$description") | 
        .forceDescriptionEmbed = (.forceDescriptionEmbed // false) | 
        .removeDuplicate = (.removeDuplicate // true) | 
        .descriptionClearHTML = (.descriptionClearHTML // true) | 
        .titleClearHTML = (.titleClearHTML // true)' "$config_path" > temp.json && mv temp.json "$config_path"
  fi
done
