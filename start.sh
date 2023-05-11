#!/bin/bash
#set -x # log

RM="rm -rfd"
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

AUTHOR='Zdenek Lapes'
EMAIL='lapes.zdenek@gmail.com'

PROJECT_NAME='ibt'
LOGIN="thesis"

##### FUNCTIONS
function error_exit() {
    printf "${RED}ERROR: $1${NC}\n"
    usage
    exit 1
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

function make_all() {
    for folder in "ibt-presentation" "thesis" "itt-presentation"; do
        cd $folder || error_exit "Cannot cd to $folder"
        make
        cd - || error_exit "Cannot cd to -"
        cp ${folder}/out/*.pdf pdf/${folder}.pdf
    done
}

function pack_thesis() {
    zip -r ${LOGIN}.zip \
        ${LOGIN} \
        README.md \
        .editorconfig \
        start.sh \
        -x "*out*" \
        -x "*others*"
    mv "${LOGIN}.zip" "${HOME}/Downloads/"
    unzip -d "${HOME}/Downloads/${LOGIN}" "${HOME}/Downloads/${LOGIN}.zip"
}
function pack_itt() {
    zip -r itt.zip \
        itt-presentation \
        -x "*out*" \
        -x "*others*"
}
function pack_ibt() {
    zip -r ibt.zip \
        ibt-presentation \
        -x "*out*" \
        -x "*others*"
}

##### PARSE CLI-ARGS
[[ "$#" -eq 0 ]] && usage && exit 0
while [ "$#" -gt 0 ]; do
    case "$1" in
    '-ma' | '--make-all') make_all ;;
    '-h' | '--help') usage ;;
    '-pt' | '--pack-thesis') pack_thesis ;;
    '--pack-ibt') pack_ibt ;;
    '--pack-itt') pack_itt ;;
    esac
    shift
done
