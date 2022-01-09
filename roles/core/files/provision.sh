#!/usr/bin/env bash

log_dir='/home/jason/test'
log_file="${log_dir}/$(date +'%Y%m%d')_provisioner.log"
log_retention_days="30"
log_retention_cutoff_date=$(date -d "${log_retention_days} days ago" +'%Y%m%d')

exec >> "$log_file"

logger() {
  awk '{ print strftime("[%Y-%m-%d %H:%M:%S]: "), $0; fflush(); }' 
}

purge_logs() {
  echo "Checking for old logs to purge..."
  expired_logs=($(ls "$log_dir" | awk -v d="$log_retention_cutoff_date" '$0 < d'))
  if [[ "${#expired_logs[@]}" != 0 ]]; then
    echo "Found expired logs: " "${expired_logs[@]}"
    for log in "${expired_logs[@]}"; do
      echo "Purging log file: ${log}"
      rm "${log_dir}/${log}" 2>&1
    done
  else
    echo "No expired logs found"
  fi
}

run_provisioner() {
  echo "Provisioner run started"
  /usr/bin/ansible-pull -oU \
    'https://github.com/zenmerlin/ansible-workstation-configs.git'
  echo "Provisioner run ended, exit code: ${?}"
}

run_provisioner | logger
purge_logs | logger
