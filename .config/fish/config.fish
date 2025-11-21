if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias vim=nvim
alias l='eza --group-directories-first'
alias la='l -a'
alias ll='l -l'
alias lw='ll -T -L1'
alias lww='ll -T -L2'
alias lwww='ll -T -L3'
alias lwwww='ll -T -L4'
alias llw='ll -T --ignore-glob=".git"'

# Improve less by adding some default flags
export LESS='-SXIFRs --incsearch'