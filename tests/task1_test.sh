#!/bin/bash

#######################################################
#######################################################
#                     DO NOT EDIT
#######################################################
#######################################################

echo "Running Test for Task 1"

function remove_files() {
    rm -r "$TEST_DIR"
}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

TASK_SCRIPT="${SCRIPT_DIR}/../batchrename.sh"

chmod +x $TASK_SCRIPT

TEST_DIR="${SCRIPT_DIR}/test_batchrename"
mkdir -p "$TEST_DIR"

touch "$TEST_DIR"/{a..z}.dat

$TASK_SCRIPT "$TEST_DIR" dat txt

EXPECTED_COUNT=26
ACTUAL_COUNT=$(ls "$TEST_DIR"/*.txt 2>/dev/null | wc -l)

if [ "$ACTUAL_COUNT" -eq "$EXPECTED_COUNT" ]; then
    echo "Test 1 Passed: all files renamed."
else
    echo "Test 1 Failed: expected $EXPECTED_COUNT .txt files, but $ACTUAL_COUNT was found."
    remove_files
    exit 1
fi

DAT_FILES=$(ls "$TEST_DIR"/*.dat 2>/dev/null | wc -l)

if [ "$DAT_FILES" -eq 0 ]; then
    echo "Test 1 Passed: no .dat files found."
else
    echo "Test 1 Failed: found a .dat file."
    remove_files
    exit 1
fi

remove_files