#!/bin/bash

show_usage() {
    echo "Pecha Kucha for Deckset"
    echo ""
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -i <seconds>    Set the interval in which the slides should advance (default: 20)"
    echo "  -h              Print usage."
}

INTERVAL=20

while getopts i:h option
do
    case "${option}"
    in
        i)
            INTERVAL=$OPTARG;
            shift $((OPTIND-1));;
        h)
            show_usage;
            exit 0;
    esac
done


osascript <<EOF
    repeat
        tell application "Deckset"
            tell document 1
                set slideIndex to slideIndex + 1
            end tell
            delay $INTERVAL
        end tell
    end repeat
EOF
