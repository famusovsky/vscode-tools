#!/bin/sh

usage() {
    echo "USAGE: $0 [-o output_file (default: ./import_code_extensions.sh)] [-c vscode_cmd (default: code)]"
    exit 1
}

output_file="./import_code_extensions.sh"
vscode_cmd="code"

while getopts ":o:c:h" opt; do
    case ${opt} in
        o )
            output_file=$OPTARG
            ;;
        c )
            vscode_cmd=$OPTARG
            ;;
        h )
            usage
            ;;
        \? )
            echo "Invalid option: $OPTARG" 1>&2
            usage
            ;;
        : )
            echo "Invalid option: $OPTARG requires an argument" 1>&2
            usage
            ;;
    esac
done
shift $((OPTIND -1))

$vscode_cmd --list-extensions | xargs -L 1 echo $vscode_cmd --install-extension > $output_file
