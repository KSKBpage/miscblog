Update exposed GPU to existing containers

Add limitation to existing containers  

```
#!/bin/bash
systemctl stop docker
cd /var/lib/docker/containers || exit
export CURRENT='"Count":-1,"DeviceIDs":null'
export NEW_IDS='"Count":0,"DeviceIDs":\["1","2","3","4","5","6","7"\]'


export SED_SYNTEX='s/{"Driver":"",'"$CURRENT"',"Capabilities":\[\["gpu"]],"Options":{}}/{"Driver":"",'"$NEW_IDS"',"Capabilities":[["gpu"]],"Options":{}}/g'
echo "$SED_SYNTEX"

ls */hostconfig.json | xargs -I input.txt sed -i "$SED_SYNTEX" input.txt

systemctl start docker
```

Remove the restrition added in previous step.
```
#!/bin/bash
systemctl stop docker
cd /var/lib/docker/containers || exit
export CURRENT='"Count":-1,"DeviceIDs":null'
export NEW_IDS='"Count":0,"DeviceIDs":\["1","2","3","4","5","6","7"\]'


export SED_SYNTEX='s/{"Driver":"",'"$CURRENT"',"Capabilities":\[\["gpu"]],"Options":{}}/{"Driver":"",'"$NEW_IDS"',"Capabilities":[["gpu"]],"Options":{}}/g'
echo "$SED_SYNTEX"

ls */hostconfig.json | xargs -I input.txt sed -i "$SED_SYNTEX" input.txt

systemctl start docker
```
