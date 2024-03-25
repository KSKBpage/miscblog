Update exposed GPU to existing containers

```bash
#!/bin/bash

cd /var/lib/docker/containers || exit
export CURRENT='"Count":0,"DeviceIDs":\["0","1","2","3","5","6"\]'
export NEW_IDS='"Count":-1,"DeviceIDs":null'

export SED_SYNTEX='s/{"Driver":"",'"$CURRENT"',"Capabilities":\[\["gpu"]],"Options":{}}/{"Driver":"",'"$NEW_IDS"',"Capabilities":[["gpu"]],"Options":{}}/g'
echo "$SED_SYNTEX"

ls */hostconfig.json | xargs -I input.txt sed -i "$SED_SYNTEX" input.txt

systemctl restart docker
```
