# Starship Prompt Configuration
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# Sistema de Autocompletado Zsh
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command "ps -u $USER -o pid,%cpu,tty,cputime,cmd"

# Carga de Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Integración de fzf
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# Alias
alias cat='bat'
alias catn='bat --style=plain'
alias catnp='bat --style=plain --paging=never'

alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'

alias nfs-on='sudo mount /mnt && echo "Synology montado en /mnt"'
alias nfs-off='sudo umount /mnt && echo "Synology desmontado"'
alias renew-ip='sudo dhclient -r && sudo dhclient'

# Auto-configuración de hardware por IP
if [ -f /usr/local/bin/autoconfig-hardware.sh ]; then
    /usr/local/bin/autoconfig-hardware.sh
fi

# Mapeo de Teclas
bindkey "^[[3~" delete-char

# Funciones Personalizadas
function settarget(){
    ip_address=$1
    machine_name=$2
    mkdir -p $HOME/.config/polybar/hack/scripts
    echo "$ip_address $machine_name" > $HOME/.config/polybar/hack/scripts/target
}

function cleartarget(){
    mkdir -p $HOME/.config/polybar/hack/scripts
    echo '' > $HOME/.config/polybar/hack/scripts/target
}

function mkt(){
    mkdir -p {content,exploits,obsidian,walkthrough}
}

function extractPorts(){
    if [ -z "$1" ] || [ ! -f "$1" ]; then
        echo "Uso: extractPorts <archivo_nmap>"
        return 1
    fi

    ports="$(grep -oP '\d{1,5}/open' "$1" | awk -F'/' '{print $1}' | xargs | tr ' ' ',')"
    ip_address="$(grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' "$1" | sort -u | head -n 1)"

    echo -e "\n[*] Extracting information...\n"
    echo -e "\t[*] IP Address: $ip_address"
    echo -e "\t[*] Open ports: $ports\n"

    if command -v xclip >/dev/null 2>&1; then
        echo -n "$ports" | xclip -sel clip
        echo -e "[*] Ports copied to clipboard\n"
    else
        echo -e "[!] xclip no está instalado. Añádelo a packages.x86_64\n"
    fi
}

eval "$(starship init zsh)"
