#!/usr/bin/env bash
set -euo pipefail

unset CDPATH

function follow_links() (
  cd -P "$(dirname -- "$1")"
  file="$PWD/$(basename -- "$1")"
  while [[ -h "$file" ]]; do
    cd -P "$(dirname -- "$file")"
    file="$(readlink -- "$file")"
    cd -P "$(dirname -- "$file")"
    file="$PWD/$(basename -- "$file")"
  done
  echo "$file"
)

PROG_NAME="$(follow_links "${BASH_SOURCE[0]}")"
BIN_DIR="$(cd "${PROG_NAME%/*}" ; pwd -P)"
OS="$(uname -s)"
DART="$FLUTTER_ROOT/bin/dart"

"$DART" "$BIN_DIR/cmd.dart" "$@"
 
