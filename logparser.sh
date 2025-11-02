#!/usr/bin/env bash
# logparser.sh — count unique IPs and most requested resource
set -euo pipefail

usage() {
  echo "Використання: $0 <шлях_до_access.log>" >&2
  exit 1
}

[[ $# -eq 1 ]] || usage
log=$1
[[ -f "$log" ]] || { echo "Помилка: файл '$log' не знайдено"; exit 2; }

# Унікальні IP — перше поле
unique_ips=$(awk '{print $1}' "$log" | sort -u | wc -l | tr -d ' ')

# Найпопулярніший ресурс:
# беремо частину в лапках (метод+URL+протокол), витягаємо URL (2-ге слово), рахуємо моду
popular_resource=$(
  awk -F\" '{print $2}' "$log" | awk '{print $2}' \
  | sort | uniq -c | sort -nr | awk 'NR==1{print $2}'
)

echo "Кількість унікальних IP: $unique_ips"
echo "Найпопулярніший ресурс: ${popular_resource:-N/A}"
