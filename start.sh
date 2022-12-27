#!/bin/bash
#set -x # log

RM="rm -rfd"
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

AUTHOR='Zdenek Lapes'
EMAIL='lapes.zdenek@gmail.com'

PROJECT_NAME='ibt'

##### FUNCTIONS
function error_exit() {
    printf "${RED}ERROR: $1${NC}\n"
    usage
    exit 1
}

function clean() {
    ${RM} *.zip

    # Folders
    for folder in "venv" "__pycache__"; do
        find . -type d -iname "${folder}" | xargs "${RM}"
    done

    # Files
    for file in ".DS_Store" "*.log"; do
        find . -type f -iname "${file}" | xargs "${RM}"
    done
}

function tags() {
    ctags -R --fields=+l \
        --exclude=.git \
        --exclude=.idea \
        --exclude=node_modules \
        --exclude=tests* \
        --exclude=venv* .
    cscope -Rb
}

function upload_code() {
    rsync -avPz \
        --exclude-from=.rsync_ignore_code \
        ./src ./requirements.txt \
        xlapes02@sc-gpu1.fit.vutbr.cz:/home/xlapes02/ai-investing
}

function usage() {
    echo "USAGE:
    '-c' | '--clean') clean ;;
        #
    '-sc' | '--sync-code') upload_code ;;
        #
    '-t' | '--tags') tags ;;
    '-h' | '--help') usage ;;
    '-p' | '--pack') pack ;;"
}

function pack() {
    zip -r thesis.zip \
        thesis \
        -x "*out*" \
        -x "*others*"
}

##### PARSE CLI-ARGS
[[ "$#" -eq 0 ]] && usage && exit 0
while [ "$#" -gt 0 ]; do
    case "$1" in
    '-c' | '--clean') clean ;;
        #
    '-sc' | '--sync-code') upload_code ;;
        #
    '-t' | '--tags') tags ;;
    '-h' | '--help') usage ;;
    '-p' | '--pack') pack ;;
    esac
    shift
done
