#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

cpu_temp_format="%2.0f"
cpu_temp_unit="C"

print_cpu_temp() {
  cpu_temp_format=$(get_tmux_option "@cpu_temp_format" "$cpu_temp_format")
  cpu_temp_unit=$(get_tmux_option "@cpu_temp_unit" "$cpu_temp_unit")
  if grep "Raspberry Pi" /proc/device-tree/model > /dev/null; then
    cat /sys/class/thermal/thermal_zone0/temp | awk -v format="$cpu_temp_format$cpu_temp_unit" '{printf(format, $1/1000)}'
  elif command_exists "sensors"; then
    ([ "$cpu_temp_unit" == F ] && sensors -f || sensors) | sed -e 's/^Tccd/Core /' | awk -v format="$cpu_temp_format$cpu_temp_unit" '/^Core [0-9]+/ {gsub("[^0-9.]", "", $3); sum+=$3; n+=1} END {printf(format, sum/n)}'
  fi
}

main() {
  print_cpu_temp
}
main
