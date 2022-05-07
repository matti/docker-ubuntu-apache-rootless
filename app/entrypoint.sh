#!/usr/bin/env bash
set -euo pipefail

_shutdown() {
  trap '' TERM INT ERR
  apache2ctl graceful-stop

  kill 0
  wait
  exit
}

trap '_shutdown' TERM INT ERR

apache2ctl start

tail -f /dev/null & wait