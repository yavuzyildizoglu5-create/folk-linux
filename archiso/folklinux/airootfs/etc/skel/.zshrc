#! /bin/zsh
# Folk Linux — zsh kullanıcı yapılandırması
# /etc/skel/.zshrc olarak kopyalanır

# Oh-my-zsh tarzı tema (opsiyonel, paket kuruluysa)
export ZSH="$HOME/.oh-my-zsh"
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Prompt
PROMPT='%F{green}%n%f@%F{cyan}%m%f %F{yellow}%~%f %# '

# Eklentiler
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliaslar
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias pac='sudo pacman'
alias folk='folk-install'

# Ortam
export EDITOR=nvim
export BROWSER=firefox
export XDG_CONFIG_HOME="$HOME/.config"
export HISTCONTROL=ignoredups
export HISTSIZE=10000

# Fastfetch — yeni terminalde sistem bilgisi
[[ -t 1 ]] && command -v fastfetch >/dev/null && fastfetch --logo-type small || true
