#!/bin/bash

set -e

USUARIO="zodiak"
if ! id $USUARIO >/dev/null 2>&1; then
    useradd \
        -m \
        -k /etc/skel \
        -u 1000 \
        -G wheel,video,audio,storage,network \
        -s /bin/zsh \
        $USUARIO
fi

passwd -d $USUARIO

install -d -m 0750 /etc/sudoers.d
printf '%s\n' "$USUARIO ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USUARIO
chmod 440 /etc/sudoers.d/$USUARIO
chmod +x /home/$USUARIO/.config/bspwm/bspwmrc
chmod +x /home/$USUARIO/.config/polybar/ -R
