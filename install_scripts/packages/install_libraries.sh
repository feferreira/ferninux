#!/bin/bash

set -e
SCRIPT=$(realpath -s "$0")
SCRIPT_PATH=$(dirname "$SCRIPT")

. /script/install_source.sh

declare -a recipes=()
recipes+=(libraries/pcre2)
recipes+=(libraries/pcre)
recipes+=(libraries/libxml2)
recipes+=(libraries/libxslt)
recipes+=(libraries/glib)
recipes+=(libraries/libarchive)
recipes+=(libraries/libuv)
recipes+=(libraries/gobject-introspection)
recipes+=(network_libraries/curl)
recipes+=(libraries/icu)
recipes+=(libraries/libqalculate)
recipes+=(libraries/libarchive)
recipes+=(libraries/libuv)
recipes+=(libraries/libunwind)
recipes+=(libraries/nghttp2)
recipes+=(network_libraries/curl)
recipes+=(libraries/boost)

install_package_list
