```
tzutil /s “Taipei Standard Time”
net stop w32time
w32tm /config /syncfromflags:manual /manualpeerlist:"time.google.com time.cloudflare.com"
net start w32time
w32tm /config /update
w32tm /resync /rediscover
```
