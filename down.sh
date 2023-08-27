#!/bin/bash
# this scripts is at the root of the parent folder where your newsbots are kept
# and when run, it will docker-compose down each of the bots
# also has a commented alternative down procedure that remove existing images if needed
# just use one or the other by uncommenting the one you need


# Specify the absolute path to the parent folder
PARENT_DIR="$PWD"

# Print a message indicating the script has started
echo "Starting Docker Compose update process for all subfolders in $PARENT_DIR"

# Change to the parent directory
cd "$PARENT_DIR" || { echo "Failed to navigate to $PARENT_DIR. Exiting."; exit 1; }

# Loop through each subfolder in the parent directory
for dir in */ ; do
    # Output the name of the subfolder being processed
    echo "=============================================="
    echo "Processing subfolder: $dir"

    # Navigate into the subfolder
    cd "$dir" || { echo "Failed to navigate to subfolder $dir. Skipping."; cd ..; continue; }

    # Bring down existing Docker containers and remove images
    # echo "Running 'docker-compose down --rmi local'..."
    # docker-compose down --rmi local

   # Bring down existing Docker containers 
    echo "Running 'docker-compose down --rmi local'..."
    docker-compose down --rmi local

    # Navigate back to the parent folder to process the next subfolder
    cd "$PARENT_DIR" || { echo "Failed to navigate back to $PARENT_DIR. Exiting."; exit 1; }

    # Output a message indicating that the subfolder was processed successfully
    echo "Successfully processed subfolder: $dir"
    echo "=============================================="
done

# Print a message indicating the script has finished
echo "Docker Compose update process completed for all subfolders."
