#!/bin/bash
# this script allows you to update all image: fields of the docker-compose.yml file
# and update it with the latest provided docker image. 
# follow the usage of this script by using up.sh to use latest image
# if needed the script will pull the image if it's not already local.


# Set the new image value
new_image_value="ghcr.io/milanmdev/bsky.rss:queue-0a51205"

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
  
  echo "Done updating $file."
  echo "-----------------------"
done
