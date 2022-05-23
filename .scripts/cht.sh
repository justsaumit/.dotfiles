#!/bin/sh
languages=`echo "cpp c python rust golang lua typescript" | tr ' ' '\n'`
core_utils=`echo "xargs find mv sed awk" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
read -p "query: " query

if printf $languages | grep -qs $selected; then
    curl cht.sh/$selected/`echo $query | tr ' ' '+' | bat`
else
    curl cht.sh/$selected~$query | bat
fi
