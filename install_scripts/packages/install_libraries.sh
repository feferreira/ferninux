#!/bin/bash

set -e
SCRIPT=$(realpath -s "$0")
SCRIPT_PATH=$(dirname "$SCRIPT")

. /script/install_source.sh

declare -a recipes=()
recipes+=(libraries/pcre2)
recipes+=(libraries/libxml2)
recipes+=(libraries/libxslt)
recipes+=(libraries/glib)

install_package_list
