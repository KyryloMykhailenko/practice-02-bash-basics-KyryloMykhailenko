#!/usr/bin/env bash
# batchrename.sh — rename extensions in bulk
set -euo pipefail

usage() {
  echo "Використання: $0 <каталог> <оригінальне_розширення> <нове_розширення>" >&2
  exit 1
}

[[ $# -eq 3 ]] || usage

dir=$1
old_ext=$2
new_ext=$3

[[ -d "$dir" ]] || { echo "Помилка: '$dir' не каталог"; exit 2; }

shopt -s nullglob

# Перебираємо файли виду *.old_ext (лише у цій теці)
for f in "$dir"/*."$old_ext"; do
  # Обережно формуємо нове ім'я: замінюємо лише останнє розширення
  new="${f%.$old_ext}.$new_ext"
  echo "Переіменовую $f на $new"
  mv -- "$f" "$new"
done
