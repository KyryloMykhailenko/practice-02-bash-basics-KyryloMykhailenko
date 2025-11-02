#!/bin/bash

#######################################################
#######################################################
#                     DO NOT EDIT
#######################################################
#######################################################

echo "Running Test for Task 5"

function remove_files() {
    cd "$SCRIPT_DIR"
    rm -r "$TEST_DIR"
}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

TASK_SCRIPT="${SCRIPT_DIR}/../addressbook"

chmod +x $TASK_SCRIPT

TEST_DIR="${SCRIPT_DIR}/test_ab"
mkdir -p "$TEST_DIR"

cd $TEST_DIR

$TASK_SCRIPT new "John Doe" a@gmail.com
$TASK_SCRIPT new "Pes Patron" p@gmail.com
$TASK_SCRIPT new "John Doe" b@gmail.com

LIST_OUTPUT=$("$TASK_SCRIPT" list)

EXPECTED_LIST="John Doe a@gmail.com
Pes Patron p@gmail.com
John Doe b@gmail.com"

TEST_PASSED=true

if [ "$LIST_OUTPUT" = "$EXPECTED_LIST" ]; then
    echo "list works."
else
    echo "list does not work as expected."
    TEST_PASSED=false
fi

# Перевіряємо команду lookup
LOOKUP_OUTPUT=$("$TASK_SCRIPT" lookup "John Doe")

# Можливі два варіанти очікуваного виводу
EXPECTED_LOOKUP_1="a@gmail.com
b@gmail.com"

EXPECTED_LOOKUP_2="John Doe a@gmail.com
John Doe b@gmail.com"

if [ "$LOOKUP_OUTPUT" = "$EXPECTED_LOOKUP_1" ] || [ "$LOOKUP_OUTPUT" = "$EXPECTED_LOOKUP_2" ]; then
    echo "lookup works."
else
    echo "lookup does not work as expected."
    TEST_PASSED=false
fi

# Перевіряємо команду remove
$TASK_SCRIPT remove "John Doe"
LIST_AFTER_REMOVE=$("$TASK_SCRIPT" list)

if [ "$LIST_AFTER_REMOVE" = "Pes Patron p@gmail.com" ]; then
    echo "remove works."
else
    echo "remove does not work as expected."
    TEST_PASSED=false
fi

# Перевіряємо команду clear
$TASK_SCRIPT clear
LIST_AFTER_CLEAR=$("$TASK_SCRIPT" list)

if [ "$LIST_AFTER_CLEAR" = "Адресна книга порожня" ]; then
    echo "clear works."
else
    echo "clear does not work as expected."
    TEST_PASSED=false
fi

if [ "$TEST_PASSED" = true ]; then
    echo "Test 5 Passed: all functions work as expected."
else
    echo "Test 5 Failed: all or some functions are not working as expected."
    remove_files
    exit 1
fi

remove_files
