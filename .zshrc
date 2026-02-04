# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Default proxy configuration
__DEFAULT_PROXY_URL="http://proxy.huawei.com:8080"
__DEFAULT_NO_PROXY="localhost,127.0.0.1"
__APT_PROXY_CONF="/etc/apt/apt.conf.d/99proxy-wsl"

__configure_apt_proxy() {
  local proxy_url="$1"
  if command -v sudo >/dev/null 2>&1; then
    local apt_conf_dir
    apt_conf_dir="$(dirname "${__APT_PROXY_CONF}")"
    if [ ! -d "$apt_conf_dir" ]; then
      printf 'Skipping apt proxy configuration because %s is missing.\n' "$apt_conf_dir" >&2
      return
    fi
    if [ -n "$proxy_url" ]; then
      local apt_payload="Acquire::http::Proxy \"${proxy_url}\";\nAcquire::https::Proxy \"${proxy_url}\";\n"
      if printf '%b' "$apt_payload" | sudo tee "${__APT_PROXY_CONF}" >/dev/null; then
        printf 'Configured apt proxy at %s\n' "${__APT_PROXY_CONF}"
      else
        printf 'Warning: Unable to write apt proxy settings to %s\n' "${__APT_PROXY_CONF}" >&2
      fi
    fi
  else
    printf 'sudo not found; skipping apt proxy configuration.\n' >&2
  fi
}

__clear_apt_proxy() {
  if command -v sudo >/dev/null 2>&1; then
    if [ -f "${__APT_PROXY_CONF}" ]; then
      if sudo rm -f "${__APT_PROXY_CONF}" >/dev/null 2>&1; then
        printf 'Removed apt proxy configuration at %s\n' "${__APT_PROXY_CONF}"
      fi
    fi
  fi
}

set_proxy() {
  local proxy_url="${1:-${__DEFAULT_PROXY_URL}}"
  local no_proxy="${2:-${__DEFAULT_NO_PROXY}}"

  export HTTP_PROXY="$proxy_url"
  export HTTPS_PROXY="$proxy_url"
  export ALL_PROXY="$proxy_url"
  export NO_PROXY="$no_proxy"
  export http_proxy="$proxy_url"
  export https_proxy="$proxy_url"
  export all_proxy="$proxy_url"
  export no_proxy="$no_proxy"
  export GIT_SSL_NO_VERIFY=true
  printf 'Proxy environment variables set to %s\n' "$proxy_url"
  printf 'NO_PROXY is %s\n' "$no_proxy"

  __configure_apt_proxy "$proxy_url"
}

unset_proxy() {
  unset HTTP_PROXY HTTPS_PROXY ALL_PROXY NO_PROXY
  unset http_proxy https_proxy all_proxy no_proxy
  unset GIT_SSL_NO_VERIFY
  printf 'Proxy environment variables cleared\n'

  __clear_apt_proxy
}

OPENVPN_CONFIG="$HOME/huaweirc-tcp-socks-Leonardo.ovpn"
bz_connect() {
    sudo openvpn --config $OPENVPN_CONFIG --daemon 
    sleep 0.1
    systemd-tty-ask-password-agent
    sleep 0.1
    systemd-tty-ask-password-agent
}
bz_disconnect() {
    pkill -SIGTERM -f 'openvpn --config'
}

set_proxy

# PATH changes
export PATH=$HOME/installed/nvim-linux-x86_64/bin:$PATH
export PATH=$HOME/installed/node-v24.12.0-linux-x64/bin:$PATH

# tmux changes
if [[ $TMUX ]]; then
    tmux set-option -g status-interval 1
fi

# ssh shortcuts
export PATH=$HOME/dotfiles/ssh-binaries/bin:$PATH

