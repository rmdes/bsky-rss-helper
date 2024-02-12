#!/bin/bash

# Set the new image value
new_image_value="ghcr.io/milanmdev/bsky.rss:2.0.1"

# Find docker-compose.yml files and loop through them
find . -type f -name 'docker-compose.yml' | while read -r file; do
  # Extract the directory name
  dir_name=$(dirname "$file")


  # Display which folder and file are being processed
  echo "Entering folder: $dir_name"
  echo "Updating file: $file"


  # Create a backup of the current file with a .bak extension
  echo "Creating backup: $file.bak"
  cp "$file" "$file.bak"

  # Update the image field
  echo "Updating image field..."
  sed -i "s|image: .*|image: $new_image_value|" "$file"

  echo "Done updating $file." echo "-----------------------"
done
