update gpu config for all containers with bash and sed

```bash
systemctl stop docker
ls */hostconfig.json | xargs -I input.txt sed -i 's/{"Driver":"","Count":-1,"DeviceIDs":null,"Capabilities":\[\["gpu"]],"Options":{}}/{"Driver":"","Count":0,"DeviceIDs":["0","1","2","3","5","6"],"Capabilities":[["gpu"]],"Options":{}}/g' input.txt
systemctl start docker
```
