#!/usr/bin/env bash
# folderorganizer.sh — organize files into subfolders by extension
set -euo pipefail

usage() {
  echo "Використання: $0 <каталог>" >&2
  exit 1
}

[[ $# -eq 1 ]] || usage
root=$1
[[ -d "$root" ]] || { echo "Помилка: '$root' не каталог"; exit 2; }

shopt -s nullglob

# Лише файли верхнього рівня теки
for path in "$root"/*; do
  [[ -f "$path" ]] || continue

  filename=$(basename -- "$path")
  if [[ "$filename" == *.* ]]; then
    ext="${filename##*.}"
  else
    ext="noext"
  fi

  dest="$root/$ext"
  mkdir -p -- "$dest"
  echo "Переміщую $path до ${ext}/"
  mv -- "$path" "$dest/"
done
