#!/bin/bash

#######################################################
#######################################################
#                     DO NOT EDIT
#######################################################
#######################################################

echo "Running Test for Task 4"

function remove_files() {
    rm -r "$TEST_DIR"
}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

TASK_SCRIPT="${SCRIPT_DIR}/../logparser.sh"

chmod +x $TASK_SCRIPT

TEST_DIR="${SCRIPT_DIR}/test_logparser"
mkdir -p "$TEST_DIR"

LOG_FILE="${TEST_DIR}/test_access.log"
cat <<EOL > "$LOG_FILE"
192.168.1.10 - - [10/Oct/2023:13:55:36 +0000] "GET /index.html HTTP/1.1" 200 1024
192.168.1.11 - - [10/Oct/2023:13:56:40 +0000] "GET /about.html HTTP/1.1" 200 2048
192.168.1.10 - - [10/Oct/2023:13:57:15 +0000] "GET /contact.html HTTP/1.1" 200 512
192.168.1.12 - - [10/Oct/2023:13:58:22 +0000] "GET /index.html HTTP/1.1" 200 1024
192.168.1.11 - - [10/Oct/2023:13:59:01 +0000] "GET /index.html HTTP/1.1" 200 1024
EOL

OUTPUT=$("$TASK_SCRIPT" "$LOG_FILE")

EXPECTED_IPS=3
EXPECTED_RESOURCE="index.html"

if [ `echo "$OUTPUT" | grep -Eo '[0-9]+$'` -eq $EXPECTED_IPS ]; then
    echo "Test 4 Passed: unique IP count is correct."
else
    echo "Test 4 Failed: unique IP count is wrong."
    remove_files
    exit 1
fi

if [[ "${OUTPUT##*/}" == $EXPECTED_RESOURCE ]] ; then
    echo "Test 4 Passed: popular resource determined correctly."
else
    echo "Test 4 Failed: popular resource determined incorrectly."
    remove_files
    exit 1
fi

remove_files
