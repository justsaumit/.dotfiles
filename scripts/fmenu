#!/bin/bash

usage()
{
    cat << EOF
usage: $0 options

Index and search files using dmenu

OPTIONS:
   -h      Show this message
   -o      Store index [default: /tmp/fmenu_index]
   -i      Search folders [default: $HOME]
   -x      Exclude files [default: ".*\/..*" (i.e. dot-files)]
   -d      dmenu parameters [default: -i -l 20]
   -f      force reloading index [default: false]
   -t      time [default: 5min]
   -u      Just update the index
EOF
}

FORCE=false
INDEX="/tmp/fmenu_index"
DMENU="-i -l 20"
TIME="+5"
INPUT=$HOME
EXCLUDE='.*/\..*'
DRY=false
while getopts "ht:fd:o:i:x:u" OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         f)
             FORCE=true
             ;;
         d)
             DMENU=$OPTARG
             ;;
         t)
             TIME=$OPTARG
             ;;
         o)
             INDEX=$OPTARG
             ;;
         i)
             INPUT=$OPTARG
             ;;
         x)
             EXCLUDE=$OPTARG
             ;;
         u)
             FORCE=true
             DRY=true
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

function index_files {
    find "$INPUT" \( ! -regex "$EXCLUDE" \) | sed 's/ /\\ /g' | sort -f > "$INDEX"
}

if [[ ! -a "$INDEX" ]] ||  ( test `find $INDEX -mmin $TIME` ) || ($FORCE)
then
    index_files
fi

if ( ! $DRY )
then
    cat "$INDEX" | `dmenu $DMENU > /tmp/dmenu_find_output.txt` && cat /tmp/dmenu_find_output.txt | xargs xdg-open
fi
