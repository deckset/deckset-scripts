#!/bin/bash

show_usage() {
    echo "Markdown to PDF"
    echo ""
    echo "Usage: $0 [options] file [file...]"
    echo ""
    echo "Options:"
    echo "  -f   Overwrite existing output files."
    echo "  -h   Print usage."
    echo "  -c   Ignore Code Highlights."
}

OVERWRITE=0
IGNORE_HIGHLIGHTS=0

while getopts fhc option
do
    case "${option}"
    in
        f)
            OVERWRITE=1;
            ;;
        c)
            IGNORE_HIGHLIGHTS=1;
            ;;
        h)
            show_usage;
            exit 0;
    esac
done
shift $((OPTIND - 1))

if [ $# -eq 0 ]
then
    show_usage
    exit 1
fi

for FILE in "$@" ; do
    md_file="$(cd "$(dirname "$FILE")"; pwd)/$(basename "$FILE")"
    pdf_file="${FILE%.*}.pdf"
    backup_file="${FILE%.*}.bak.md"

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

    if [ $IGNORE_HIGHLIGHTS = 1 ]
    then
      cp $md_file $backup_file;
      convert_file="${FILE%.*}.convert.md"
      sed -E 's/\[.code-highlight.+]//g' $md_file > $convert_file
      mv $convert_file $md_file
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

  if [ $IGNORE_HIGHLIGHTS = 1 ]
  then
    mv $backup_file $md_file
  fi

done


#      sed -Ei 's/\[.code-highlight.+]//g' $md_file # > $convert_file
