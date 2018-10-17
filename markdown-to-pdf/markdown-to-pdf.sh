#!/bin/bash

show_usage() {
    echo "Markdown to PDF"
    echo ""
    echo "Usage: $0 [options] file [file...]"
    echo ""
    echo "Options:"
    echo "  -f   Overwrite existing output files."
    echo "  -h   Print usage."
}

OVERWRITE=0

while getopts fh option
do
    case "${option}"
    in
        f)
            OVERWRITE=1;
            shift;;
        h)
            show_usage;
            exit 0;
    esac
done

if [ $# -eq 0 ]
then
    show_usage
    exit 1
fi

for FILE in "$@" ; do
    md_file="$(cd "$(dirname "$FILE")"; pwd)/$(basename "$FILE")"
    pdf_file="${FILE%.*}.pdf"

    if [ ! -e $md_file ]
    then
        echo "Input file $md_file does not exist!"
        exit 2
    fi

    if [ -e $pdf_file ] && [ $OVERWRITE = 0 ]
    then
        echo "Error: output file $pdf_file exists. Please use -f option if you want to overwrite it."
        exit 3
    fi

    osascript <<EOF
        on run argv
            set md_file to "$md_file"
            set md_file to POSIX file md_file
            set out_file to "$pdf_file"
            set out_file to POSIX file out_file
            tell application "Deckset"
                activate
                open file md_file
                tell document 1
                    activate
                    export to out_file
                end tell
            end tell
        end run
EOF
done
