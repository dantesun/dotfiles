#!/bin/bash
if grep microsoft /proc/sys/kernel/osrelease &>/dev/null; then
  WSL_HOST=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null)
  sudo sed -i.bkp -nr "/wsl\\.local$/!p;\$a ${WSL_HOST} wsl.local" /etc/hosts
fi
