[[ "$-" != *i* ]] && return

export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
# alias grep='grep --color'                     # show differences in colour
# alias egrep='egrep --color=auto'              # show differences in colour
# alias fgrep='fgrep --color=auto'              # show differences in colour
alias ls='ls -hF --color=tty --show-control-chars'                 # classify files in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
# alias ll='ls -l'                              # long list
# alias la='ls -A'                              # all but . and ..
# alias l='ls -CF'                              #
alias ll='ls -al'

alias cd='pushd'
alias p='popd'

PS1='\[\033[40;1;32m\]\u\[\033[2;32m\]@\[\033[0m\]\[\033[40;32m\]\h \[\033[1;34m\]\w\[\033[31m\]`__git_ps1`\[\033[00m\] \[\033[0m\]\[\033[40;2;37m\]`date +"%Y/%m/%d %H:%M:%S"` \[\033[0m\]\n\\$ '
export PS1=$PS1

# GitHub

function find-pr() {
  local parent=$2||'master'
  git log $1..$2 --merges --ancestry-path --reverse --oneline | head -n1
}

function find-pr-open() {
  local pr="$(find-pr $1 $2 | awk '{print substr($5, 2)}')"
  local repo="$(git config --get remote.origin.url | sed 's/git@github.com://' | sed 's/\.git$//')"
  local url="https://github.com/${repo}/pull/${pr}"

  if type open > /dev/null 2>&1; then
    open "${url}"
  else
    echo "${url}"
  fi
}
