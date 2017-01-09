printf "%125s\n"| tr " " =
#colors
ESC="\033["
BOLD=$ESC"1m"
RESET=$ESC";0m"
RED=$'\e[1;31m'
GRN=$'\e[1;32m'
YEL=$'\e[1;33m'
BLU=$'\e[1;34m'
MAG=$'\e[1;35m'
# LOGO :)
cat << "EOF"
#
#    ____    U _____ u     _        ____       ____        _
#   |  _"\   \| ___"|/ U  /"\  u   |  _"\   U |  _"\ u    |"|
#  /| | | |   |  _|"    \/ _ \/   /| | | |   \| |_) |/  U | | u
#  U| |_| |\  | |___    / ___ \   U| |_| |\   |  _ <     \| |/__
#   |____/ u  |_____|  /_/   \_\   |____/ u   |_| \_\     |_____|
#    |||_     <<   >>   \\    >>    |||_      //   \\_    //  \\
#   (__)_)   (__) (__) (__)  (__)  (__)_)    (__)  (__)  (_")("_) ")"
#
#
EOF
echo -e "#	  ${MAG}*-A dead simple URL verifier for RST and MD docs-*${RESET}"
echo "#"
printf "%125s\n"| tr " " =
