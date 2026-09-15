#!/bin/bash

# Prevenir ejecuciones múltiples si ya se configuró en esta sesión
[ -f /tmp/.hardware_configured ] && exit 0

# Comprobar si hay conectividad básica antes de consultar las APIs
if ! ping -c 1 -w 2 1.1.1.1 >/dev/null 2>&1; then
    COUNTRY="DEFAULT"
else
    # Intento 1: ipapi.co
    COUNTRY=$(curl -s --max-time 2 https://ipapi.co/country/ 2>/dev/null)

    # Intento 2: ip-api.com (Fallback 1)
    if [ -z "$COUNTRY" ] || echo "$COUNTRY" | grep -q "<"; then
        COUNTRY=$(curl -s --max-time 2 http://ip-api.com/line/?fields=countryCode 2>/dev/null)
    fi

    # Intento 3: ipinfo.io (Fallback 2)
    if [ -z "$COUNTRY" ] || echo "$COUNTRY" | grep -q "<"; then
        COUNTRY=$(curl -s --max-time 2 https://ipinfo.io/country 2>/dev/null | tr -d '[:space:]')
    fi
fi

# Aplicar configuración según el país detectado
case "$COUNTRY" in
    ES)
        sudo loadkeys es
        sudo timedatectl set-timezone Europe/Madrid 2>/dev/null
        ;;
    *)
        # Por defecto para US o cualquier otro país / fallo de red
        sudo loadkeys us
        sudo timedatectl set-timezone UTC 2>/dev/null
        ;;
esac

# Marcar como configurado para no ralentizar la terminal en cada comando
touch /tmp/.hardware_configured
