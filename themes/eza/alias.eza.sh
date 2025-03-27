#!/usr/bin/env bash
# EZA Aliases for Bash
# This script defines simple shell aliases for common eza commands.
# It first checks if eza is available on the system.

# Check if 'eza' command exists; if not, exit the script.
if ! command -v eza >/dev/null 2>&1; then
    return 0 2>/dev/null || exit 0
fi

# Define common EZA parameters
EZA_COMMON_PARAMS="--group-directories-last --icons=always --color=always"

# Basic file listing aliases
alias ls="eza $EZA_COMMON_PARAMS"
alias la="eza -a $EZA_COMMON_PARAMS"
alias ll="eza -la $EZA_COMMON_PARAMS"
alias lg="eza -a $EZA_COMMON_PARAMS --git --git-repos --sort=modified --reverse --color-scale-mode=gradient --color-scale=age"
alias lsa="eza -a $EZA_COMMON_PARAMS"
alias lst="eza --tree --level=1 $EZA_COMMON_PARAMS"
alias lt="eza -la $EZA_COMMON_PARAMS --sort=modified --reverse"
alias lsize="eza -la $EZA_COMMON_PARAMS --sort=size --reverse"

# Directory navigation shortcuts
alias ..="cd .."
alias '...'="cd ../.."

# Tree view aliases
alias ltv="eza --tree $EZA_COMMON_PARAMS"
alias lst1="eza --tree --level=1 $EZA_COMMON_PARAMS"
alias lst2="eza --tree --level=2 $EZA_COMMON_PARAMS"
alias lst3="eza --tree --level=3 $EZA_COMMON_PARAMS"
alias lta="eza --tree --all $EZA_COMMON_PARAMS"
alias ltg="eza --tree --git $EZA_COMMON_PARAMS"
alias ltd="eza --tree --level=2 $EZA_COMMON_PARAMS"

# Special purpose aliases
alias lld="eza --long --only-dirs $EZA_COMMON_PARAMS"
alias llf="eza --long --only-files $EZA_COMMON_PARAMS"
alias lls="eza --long --sort=size $EZA_COMMON_PARAMS"
alias llr="eza --long --sort=modified --reverse $EZA_COMMON_
