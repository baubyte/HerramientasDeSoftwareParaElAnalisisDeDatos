#!/bin/bash

# Ejecuta git log y captura la salida
log=$(git log main --no-merges --date=short --pretty=format:"%ad|%s")

# Variables de control
lastDate=""
output_file="CHANGELOG.md"

> "$output_file"

# Procesar cada línea
while IFS='|' read -r date msg; do
    # Filtrado por tipo de commit
    #if [[ "$msg" =~ \((Add|Fix|Upgrade|Update|Refactor|Remove|Security|Perf)\) ]]; then
        # Si cambia la fecha, crear nuevo encabezado solo si hay un commit válido
        if [[ "$date" != "$lastDate" ]]; then
            if [[ -n "$lastDate" ]]; then
                echo "" >> "$output_file"
            fi
            echo "## $date" >> "$output_file"
            lastDate="$date"
        fi
        echo "- $msg" >> "$output_file"
    #fi
done <<< "$log"