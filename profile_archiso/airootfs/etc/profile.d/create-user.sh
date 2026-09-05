#!/bin/sh
if ! id "zodiak" >/dev/null 2>&1; then
    # Crear el usuario zodiak desde /etc/skel y sin contraseña
    useradd -m -k /etc/skel -u 1000 -G wheel,video,audio,storage,network -s /bin/bash zodiak
    passwd -d zodiak >/dev/null 2>&1
    
    # Otorgar acceso sudo sin contraseña
    echo "zodiak ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/zodiak
    chmod 440 /etc/sudoers.d/zodiak
fi
