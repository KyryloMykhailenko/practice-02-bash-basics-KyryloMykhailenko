#!/bin/bash

#######################################################
#######################################################
#                     DO NOT EDIT
#######################################################
#######################################################

echo "Running Test for Task 3"

function remove_files() {
    rm -r "$TEST_DIR"
}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

TASK_SCRIPT="${SCRIPT_DIR}/../folderorganizer.sh"

chmod +x $TASK_SCRIPT

TEST_DIR="${SCRIPT_DIR}/test_folderorganizer"
mkdir -p "$TEST_DIR"

touch "$TEST_DIR"/file{1,2}.txt
touch "$TEST_DIR"/image{1,2}.jpg
touch "$TEST_DIR"/song1.mp3

$TASK_SCRIPT "$TEST_DIR"

CHECK_EXTENSIONS=("txt" "jpg" "mp3")
TEST_PASSED=true

for ext in "${CHECK_EXTENSIONS[@]}"; do
    if [ -d "$TEST_DIR/$ext" ]; then
        FILE_COUNT=$(ls "$TEST_DIR/$ext" | wc -l)
        if [ "$FILE_COUNT" -eq 0 ]; then
            echo "Test 3 Failed: $ext folder has no files."
            remove_files
            exit 1
        fi
    else
        echo "Test 3 Failed: $ext folder does not exist."
        remove_files
        exit 1
    fi
done

echo "Test 3 Passed: all files are reorganized."
remove_files
