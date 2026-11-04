# Powerlevel10k instant prompt. Keep near the top; anything that needs console
# input (password prompts, y/n questions) must go above this block.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Environment -------------------------------------------------------------
export EDITOR=nvim VISUAL=nvim
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"   # uv adds ~/.local/bin

# systemd user ssh-agent (systemctl --user enable --now ssh-agent.socket).
# Leave an existing socket alone, e.g. one forwarded over ssh -A.
if [[ -z "$SSH_AUTH_SOCK" && -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

# --- Oh My Zsh ---------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)
(( $+commands[fzf] )) && plugins+=(fzf)
# Optional plugins: loaded only when cloned into $ZSH_CUSTOM/plugins
for p in zsh-autosuggestions zsh-syntax-highlighting; do  # syntax-highlighting must stay last
  [[ -d "${ZSH_CUSTOM:-$ZSH/custom}/plugins/$p" ]] && plugins+=($p)
done
unset p

source "$ZSH/oh-my-zsh.sh"

# --- History (on top of Oh My Zsh's defaults) --------------------------------
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY

# --- Tools -------------------------------------------------------------------
# Cache the output of slow `eval "$(tool ...)"` init commands; regenerate it
# when the tool's binary is newer than the cache file.
_zsh_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
_cached_source() {  # _cached_source <cache-name> <binary> <command...>
  local file="$_zsh_cache/$1.zsh" bin="$commands[$2]"
  shift 2
  [[ -n "$bin" ]] || return 0
  if [[ ! -s "$file" || "$bin" -nt "$file" ]]; then
    mkdir -p "$_zsh_cache"
    "$@" >| "$file"
  fi
  source "$file"
}
_cached_source uv-completion uv uv generate-shell-completion zsh
_cached_source uvx-completion uvx uvx --generate-shell-completion zsh
_cached_source jump jump jump shell --bind=j

# Node: fnm (fast, reads .nvmrc / .node-version), falling back to nvm.
if (( $+commands[fnm] )); then
  eval "$(fnm env --use-on-cd --shell zsh)"
elif [[ -s "$HOME/.nvm/nvm.sh" ]]; then
  export NVM_DIR="$HOME/.nvm"
  . "$NVM_DIR/nvm.sh"
fi

[[ -f ~/.aliases ]] && source ~/.aliases

# Prompt config: run `p10k configure` or edit ~/.p10k.zsh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
