#!/bin/bash

#######################################################
#######################################################
#                     DO NOT EDIT
#######################################################
#######################################################

echo "Running Test for Task 2"

function remove_files() {
    cd "$SCRIPT_DIR"
    rm -r "$TEST_DIR"
}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

TASK_SCRIPT="${SCRIPT_DIR}/../filecreator.sh"

chmod +x $TASK_SCRIPT

TEST_DIR="${SCRIPT_DIR}/test_creator"
mkdir -p "$TEST_DIR"

cd $TEST_DIR

$TASK_SCRIPT testuser

EXPECTED_COUNT=25
ACTUAL_COUNT=$(ls testuser* 2>/dev/null | wc -l)

if [ "$ACTUAL_COUNT" -eq "$EXPECTED_COUNT" ]; then
    echo "Test 2 Passed: $EXPECTED_COUNT files created on first run."
else
    echo "Test 2 Failed: $EXPECTED_COUNT files expected, but got $ACTUAL_COUNT."
    remove_files
    exit 1
fi

rm -f testuser25

$TASK_SCRIPT testuser

EXPECTED_TOTAL=49
ACTUAL_TOTAL=$(ls testuser* 2>/dev/null | wc -l)

if [ "$ACTUAL_TOTAL" -eq "$EXPECTED_TOTAL" ]; then
    echo "Test 2 Passed: created additional files."
else
    echo "Test 2 Failed: $EXPECTED_TOTAL files expected on additional run, but got $ACTUAL_TOTAL."
    remove_files
    exit 1
fi

remove_files
