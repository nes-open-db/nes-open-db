
for url in `grep -oR '"/roms/.*"' _data/roms | awk '{FS=":"; print "http://localhost:4000" $2}' | sed 's/"//g'`
do
    result=`curl -Is $url | grep HTTP`

    if [[ $result != *"200"* ]]; then
      printf $url
      printf " "
      echo $result
    fi
done