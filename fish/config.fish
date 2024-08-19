set fish_greeting ""

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme dracula
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
#alias ls "ls -p -G"
#alias lla "eza -T --sort=name --color=always --long --git --icons=always --no-time --no-user"
#alias la "eza -a" #List View with .dotfiles
#alias lt "ll -T" #Tree view
alias g git
command -qv nvim && alias vim nvim

# Define aliases for eza commands
alias ld 'eza -lD'
alias lf 'eza -lf --color=always | grep -v /'
alias lh 'eza -dl .* --group-directories-first'
alias ll 'eza -al --sort=name --long --git --icons=always --no-time --no-user --group-directories-first'
alias ls 'eza -alf --color=always --sort=size | grep -v /'
alias lt 'eza -al --sort=modified'



set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# NVM
function __check_rvm --on-variable PWD --description 'Do nvm stuff'
  status --is-command-substitution; and return

  if test -f .nvmrc; and test -r .nvmrc;
    nvm use
  else
  end
end

switch (uname)
  case Darwin
    source (dirname (status --current-filename))/config-osx.fish
  case Linux
    source (dirname (status --current-filename))/config-linux.fish
  case '*'
    source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
  source $LOCAL_CONFIG
end


#Starship 
#starhip init fish | source

# Atuin
atuin init fish | source

#FZF
eval "$(fzf --fish)"



