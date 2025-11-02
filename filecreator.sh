#!/usr/bin/env bash
# filecreator.sh — create files in batches of 25 with incremental numbers
set -euo pipefail

usage() {
  echo "Використання: $0 <ім'я_префікс>" >&2
  exit 1
}

[[ $# -eq 1 ]] || usage
prefix=$1

shopt -s nullglob

# Знаходимо максимальний номер серед існуючих файлів prefix<число>
max=0
for f in ${prefix}[0-9]*; do
  base=$(basename -- "$f")
  if [[ "$base" =~ ^${prefix}([0-9]+)$ ]]; then
    n=${BASH_REMATCH[1]}
    (( n > max )) && max=$n
  fi
done

start=$((max + 1))
end=$((start + 24))

for ((i=start; i<=end; i++)); do
  touch -- "${prefix}${i}"
done

echo "Створено файли: ${prefix}${start} .. ${prefix}${end}"
