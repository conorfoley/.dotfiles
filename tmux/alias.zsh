# -*- mode: shell-script; -*-

alias tma='tmux attach -t'
alias tmk='tmux kill-session -t'
alias tmka='tmux kill-server'

tml() {
  tmux list-sessions 2>/dev/null
  if [ $? -gt 0 ]; then
    >&2 echo "no tmux session"
  fi
}

tmn() {
  local dir=$(
  find_project \
    $ZSH 1 $1 \
    $PROJECTS/$USER 1 $1 \
    $PROJECTS 2 $1 \
    ~ 1 $1 \
    ~ 2 $1 \
    /tmp 1 $1
  )

  if [ -z $dir ]; then
    if [ $1 =~ ^/ ]; then
      tmux_start_session $1
    else
      tmux_start_session ~/Projects/mndvns/$1
    fi
  else
    tmux_start_session $dir
  fi
}

tmux_start_session() {
  local dir=`echo $1 | sed "s,$HOME,~,"`
  vared -p "path: " dir
  test $? -gt 0 && return 1
  local realdir=`echo $dir | sed "s,~,$HOME,"`

  local safename=`echo $realdir | tr -d '.' | xargs basename`
  vared -p "name: " safename
  test $? -gt 0 && return 1

  if [[ ! -d $realdir ]]; then
    echo "creating $dir..."
    mkdir -p $realdir
  fi

  cd $realdir
  tmux new-session -A -s $safename
}

find_project() {
  local directory=$1
  local depth=$2
  local query=$3

  find \
    -L $directory \
    -maxdepth $depth \
    -type d -name $query \
    2> /dev/null | read -r project

  if [ ! -z $project ]; then
    echo $project
    exit
  fi

  if [ $# -gt 3 ]; then
    shift 3
    find_project $@
  else
    >&2 echo "no projects found"
    exit 1
  fi
}
