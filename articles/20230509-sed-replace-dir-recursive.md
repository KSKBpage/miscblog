```
find . -type f -print | xargs -d \n -L 1 sed -i 's/STR_A/STR_B/g'
```
