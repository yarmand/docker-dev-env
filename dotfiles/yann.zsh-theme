# vim:ft=zsh ts=2 sw=2 sts=2

git_subdir_or_path() {
  repo_root=$(git_repo_root)
  if [ -n "$repo_root" ] ; then
    repo__basename="[$(basename $repo_root)]"
    echo "${PWD/$repo_root/$repo__basename}"
  else
    echo "${PWD/#$HOME/~}"
  fi
}

git_repo_root(){
  git rev-parse --show-toplevel 2>/dev/null
}

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

git_tainted() {
  if [ -n "$(git status -s 2>/dev/null)" ];  then
    echo "%{$fg[red]%}[!]%{$reset_color%}"
  fi
}

PROMPT='
%F{071}$(git_subdir_or_path)%{$reset_color%}$(parse_git_branch)$(git_tainted) %F{069}[%m %*]%{$reset_color%}
$ '

ZSH_THEME_GIT_PROMPT_PREFIX=" %F{242}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{242}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

RPROMPT='%{$fg_bold[green]%}$(git_repo_root)%{$reset_color%}'
