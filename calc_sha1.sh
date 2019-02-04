find ./roms | grep '\.nes$' | xargs sha1sum | awk -F '[ /]' '{ ORS=","; OFS=":";print "\"" $5 "\"", "\"" $1 "\""}' | echo "{$(cat | sed s'/.$//')}" > _data/roms_sha1sums.json
