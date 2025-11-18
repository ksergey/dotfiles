#!/usr/bin/env bash

set -e

FIFO="${HOME}/.cache/.niri-do"

function cleanup {
  echo "removing ${FIFO}"
  rm -f "${FIFO}"
}

do_expel_next_flag=0

function do_expel_next {
  do_expel_next_flag=1
}

function do_cancel_expel_next {
  do_expel_next_flag=0
}

function do_niri_exec {
  niri msg action spawn -- "$*"

  if [ ${do_expel_next_flag} -eq 1 ]; then
    do_expel_next_flag=0
    sleep 0.3 && niri msg action consume-or-expel-window-left
  fi
}

function daemon {
  echo "creating ${FIFO}"
  mkfifo "${FIFO}"

  trap cleanup EXIT

  echo "listening"

  while read -r line < "${FIFO}"; do
    local args=( ${line} )
    local action=${args[0]}
    # remove first element from array
    local args=( ${args[@]:1} )

    case "${action}" in
      exec)
        do_niri_exec ${args}
        ;;
      expel-next)
        do_expel_next ${args}
        ;;
      cancel-expel-next)
        do_cancel_expel_next ${args}
        ;;
    esac
  done
}

function action {
  if [ -p "${FIFO}" ]; then
    echo $* > "${FIFO}"
  else
    echo "no fifo ${FIFO}"
  fi
}

WHAT="$1"
shift

case "${WHAT}" in
  daemon)
    daemon
    ;;
  action)
    action $*
    ;;
esac


