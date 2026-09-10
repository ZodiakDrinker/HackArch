#!/bin/bash

set -e

if ! id zodiak >/dev/null 2>&1; then
    useradd \
        -m \
        -k /etc/skel \
        -u 1000 \
        -G wheel,video,audio,storage,network \
        -s /bin/zsh \
        zodiak
fi

passwd -d zodiak

install -d -m 0750 /etc/sudoers.d
printf '%s\n' 'zodiak ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/zodiak
chmod 440 /etc/sudoers.d/zodiak
