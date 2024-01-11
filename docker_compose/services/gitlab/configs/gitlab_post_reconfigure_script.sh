#!/bin/sh

C_EOC='\033[0m'
C_BOLD='\033[1m'
C_BLACK='\033[30m'
C_RED='\033[31m'
C_GREEN='\033[32m'
C_YELLOW='\033[33m'
C_BLUE='\033[34m'
C_MAGENTA='\033[35m'
C_CYAN='\033[36m'
C_WHITE='\033[37m'

echo "${C_BOLD}/etc/gitlab/gitlab.rb${C_EOC}:"
grep -n -e '^[^#]' /etc/gitlab/gitlab.rb

