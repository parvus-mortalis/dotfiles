# Folder Viewing
alias ls="exa --group-directories-first"
alias l="exa --group-directories-first"
alias la="exa -a --group-directories-first"
alias ll="exa -lahg --git --group-directories-first"
alias lc="clear && exa -lahg --git --group-directories-first"
alias lt="exa --tree"
alias c.="cd .."
alias c="cd ~"

alias q="clear"
alias e="exit"

# Folder switching shortcuts
alias cdd="cd ~/dotfiles"
alias cdb="cd ~/.build"
alias cdc="cd ~/code"

# Easy source of config
alias sb="source ~/.zshrc"

# Git stuff
alias gh="git hist"
alias "gc-"="git checkout --"
alias gapr="git apply -R"
alias gcaa="git commit -v --amend"
alias gdf="git difftool"

# Program substitutions
alias more=less
alias which=whence
alias vim=nvim
alias mutt=neomutt
alias man=manpages

#===========#
#-Functions-#
#===========#

gal() { alias | grep "^$1" }
ec() { find ~/dotfiles/* -type f | grep -v ".*\.png" | fzf | xargs -r $EDITOR }
ses() { find ~/.vim/sessions/* -type f | fzf | xargs -r $EDITOR -S }
