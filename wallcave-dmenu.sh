#!/bin/bash

cachefile=$HOME/.cache/wallcavecacche
titlecache=$HOME/.cache/wallcavetitle
linkcache=$HOME/.cache/wallcaveinkcache

downloadwall() {
	for line in $(curl --user-agent 'Chrome/79' $1  | grep -o 'src="/wp...............................' | grep -oP '(?<=wp).*?(?=")')
	do
		curl --user-agent 'Chrome/79' https://wallpapercave.com/wp$line > $(echo $line | cut -c2-)
	done
}




### main
curl --user-agent 'Chrome/79' https://wallpapercave.com/search?q=$(echo | dmenu -p "wallpaper search :" | tr ' ' '+' | tr '\n' '+') | grep "class=\"albumphoto\"" > $cachefile


grep -oP '(?<=title\=").*?(?=")' $cachefile > $titlecache



title=$(cat $titlecache | dmenu -l 35)

echo $title

link=$(grep "title=\"$title\"" $cachefile | grep -oP '(?<=href\=").*?(?=")' )

downloadwall "https://wallpapercave.com$link"

rm $cachefile $titlecache ###$linkcache
