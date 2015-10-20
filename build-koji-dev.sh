#!/bin/bash
#
# build-koji-dev.sh
#
# This script uses tito in order to build koji for deployment in a development
# environment. It is meant to make iterative workflows easier.
#
# Exit codes:
#   1 - Missing dependency for script
#   2 - Missing args
#
# Author: Adam Miller <maxamillion@fedoraproject.org>
#
#
# Conventions:
#   - function names are prefixed with f_

f_ctrl_c() {
    printf "\n*** Exiting ***\n"
    exit $?
}

# trap int (ctrl-c)
trap f_ctrl_c SIGINT

# Print usage
f_usage() {
    local name=$(basename ${0})
cat <<EOF
NAME
    ${name}

SYNOPSIS
    ${name} [-h] -b [-m mock_target]

DESCRIPTION
    This script uses tito in order to build koji for deployment in a development
    environment. It is meant to make iterative workflows easier.

OPTIONS
    -h      Show this help dialog
    -b      Perform a build
    -m mock_target
        mock_target is a target config to build for (e.g fedora-rawhide-x86_64)
EOF
  exit 1
}

f_error_usage() {
    printf "**ERROR: %s\n\n" "${1}"
    f_usage
}

# Sanity checking
if ! [[ -f "/usr/bin/tito" ]]; then
    printf "**ERROR: tito not found, do you need to install it?\n\n"
    exit 1
fi

if [[ -z "${1}" ]]; then
    f_error_usage "Missing args"
    exit 2
fi

tito_args=""
# parse options/args
while getopts ":hm:b" opt; do
    case $opt in
        h)
            f_usage
            exit 0
            ;;
        m)
            mock_target="$OPTARG"
            ;;
        b)
            tito_args="build --rpm --test"
            ;;
        *)
            f_error_usage "INVALID ARG $OPTARG"
            exit 1
            ;;
    esac
done

if [[ -z "${tito_args}" ]]; then
    f_error_usage "Missing required build arg -b"
    exit 2
fi

# Check for cached tito builds and remove them
# FIXME - This is flawed based on assumptions of tito defaults
if [[ -d "/tmp/tito" ]]; then
    printf "INFO: Cleaning old tito build dir"
    rm -fr /tmp/tito
fi

if [[ -n "${mock_target}" ]]; then
    tito_args+=" --builder mock --arg mock=${mock_target}"
fi

/usr/bin/tito ${tito_args}
