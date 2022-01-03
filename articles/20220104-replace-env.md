```
cd /var/www/html
for template in *.template; do
    [ -f "$template" ] || continue
    conf=${template::-9}
    cat $template | sed -e 's/\${/＄/g' | sed 's/\$/${DOLLAR}/g' | sed 's/＄/${/g' | envsubst > $conf
done
```
