#!/bin/bash
# This script is at the root of the parent folder where your newsbots are kept.
# It will check each subfolder and set the config.json inside each /data/ directory
# for each of the bots.
#
# Set config.json with default or missing values
# Careful, this overwrites existing config.json values.

# Default master config.json as a string
master_config=$(cat <<EOM
{
  "string": "$title",
  "publishEmbed": true,
  "embedType": "card",
  "languages": ["en"],
  "ogUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:89.0) Gecko/20100101 Firefox/89.0",
  "truncate": true,
  "runInterval": 60,
  "dateField": "",
  "imageField": "",
  "imageAlt": "$description",
  "forceDescriptionEmbed": false,
  "removeDuplicate": true,
  "descriptionClearHTML": true,
  "titleClearHTML": true
}
EOM
)

# Loop through all subfolders
for dir in */; do
  # Extract parent folder name
  parent_folder=$(basename "$dir")

  # Extract language from parent folder name
  lang="${parent_folder##*-}"

  # Path to config.json
  config_path="${dir}data/config.json"

  # Write the master_config to config.json, overwriting if it exists
  echo "$master_config" > "$config_path"

  # Modify "languages" based on the parent folder name
  if [[ "$lang" == "en" || "$lang" == "fr" ]]; then
    jq --arg lang "$lang" '.languages = [$lang]' "$config_path" > temp.json && mv temp.json "$config_path"
  fi
done
