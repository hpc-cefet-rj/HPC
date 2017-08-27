#!/bin/sh

set -e

my_curl="curl"
url="https://put-here-linux-full-download-URL"
if [ "$(uname)" = "Darwin" ]; then
    url="https://put-here-macOS-full-download-URL"
fi
# TODO: put here code to Windows-full-download-URL

cmde() {
  command -v "$@" > /dev/null 2>&1
  echo $?
}

do_install() {
  # -E in sudo Indicates to the security policy that the user wishes 
  # to preserve their existing environment variables
  user="$(id -un 2>/dev/null || true)"
  shc="sh -c"
  if [ "$user" != "root" ]; then
    echo "you are logged as $user"
      if command -v "sudo" > /dev/null 2>&1; then
        shc="sudo -E sh -c"
        echo "using shc = $shc"
        # else
        #   cat >&2 <<-"EOF"
        #   * Error: this installer must be able to run commands as root
        #   Unable to find "sudo" to perform the operation
        #   EOF
        #   exit 1
      fi
  fi

  echo "Important: You will prompt to sudo password."
  echo "Downloading App CLI..."
  echo "$shc $my_curl $url > /usr/local/bin/wff_cli"
  $shc "$my_curl $url > /usr/local/bin/wff_cli"
  $shc "chmod +x /usr/local/bin/wff_cli"
  $shc "wff_cli --silent > /dev/null 2>&1 || true"
  echo "Download complete. Type wff_cli to launch the App CLI"
  # put your code here

  echo "put your code here"
}

if command -v "curl" > /dev/null 2>&1; then
  my_curl="curl -sSL"
  echo "command curl is instaled. Using it"
  do_install x y z
  exit
fi
if command -v "wget" > /dev/null 2>&1; then
  my_curl="wget -qO-"
  echo "command wget is instaled. Using it"
  do_install x y z
  exit
fi
if command -v "busybox" > /dev/null 2>&1; then
  my_curl="busybox wget -qO-"
  echo "command busybox is instaled. Using wget from it"
  do_install x y z
  exit
fi

cat >&2 <<-"EOF"
* Error: this installer must be able to download files
Unable to find "curl" or "wget" to perform the operation.
Please install curl or wget and try again
EOF
exit 1