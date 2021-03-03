#!/usr/bin/env bash

# Make Pype documentation


art () {
  cat <<-EOF
  ____________
 /\\      ___  \\
 \\ \\     \\/_\\  \\
  \\ \\     _____/ ______   ___ ___ ___
   \\ \\    \\___/ /\\     \\  \\  \\\\  \\\\  \\
    \\ \\____\\    \\ \\_____\\  \\__\\\\__\\\\__\\
     \\/____/     \\/_____/  . PYPE Club .

EOF
}

# Colors for terminal

RST='\033[0m'             # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White


##############################################################################
# Return absolute path
# Globals:
#   None
# Arguments:
#   Path to resolve
# Returns:
#   None
###############################################################################
realpath () {
  echo $(cd $(dirname "$1"); pwd)/$(basename "$1")
}

# Main
main () {
  echo -e "${BGreen}"
  art
  echo -e "${RST}"

  # Directories
  pype_root=$(realpath $(dirname $(dirname "${BASH_SOURCE[0]}")))
  pushd "$pype_root" > /dev/null || return > /dev/null

  echo -e "${BIGreen}>>>${RST} Running apidoc ..."
  poetry run sphinx-apidoc -M -e -d 10  --ext-intersphinx --ext-todo --ext-coverage --ext-viewcode -o "$pype_root/docs/source" igniter
  poetry run sphinx-apidoc -M -e -d 10 --ext-intersphinx --ext-todo --ext-coverage --ext-viewcode -o "$pype_root/docs/source" pype vendor, pype\vendor

  echo -e "${BIGreen}>>>${RST} Building html ..."
  poetry run python3 "$pype_root/setup.py" build_sphinx
}

main
