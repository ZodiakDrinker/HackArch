#!/bin/sh

# Detectar la interfaz que está usando la ruta por defecto
interface=$(
    ip -4 route get 1.1.1.1 2>/dev/null |
    awk '{
        for (i = 1; i <= NF; i++)
            if ($i == "dev") {
                print $(i+1)
                exit
            }
    }'
)

# Si no hay conexión de red
if [ -z "$interface" ]; then
    echo "%{F#e51d0b}󰅛 %{F#ffffff}Offline%{u-}"
    exit 0
fi

# Obtener la IPv4 de la interfaz detectada
ip_address=$(
    ip -4 -o addr show dev "$interface" scope global 2>/dev/null |
    awk '{print $4}' |
    cut -d/ -f1 |
    head -n1
)

# Si la interfaz existe pero todavía no tiene IPv4
if [ -z "$ip_address" ]; then
    echo "%{F#e51d0b}󰅛 %{F#ffffff}No IP%{u-}"
    exit 0
fi

echo "%{F#2495e7}󰱓 %{F#ffffff}$ip_address%{u-}"
