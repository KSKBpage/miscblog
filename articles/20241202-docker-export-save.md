save/load: for image
```
export IMG_NAME=myimage
export FILE_NAME=myimage
docker save $IMG_NAME | gzip > FILE_NAME.tar.gz
docker load --input FILE_NAME.tar.gz $IMG_NAME.tar.gz
```

export/import: for container
```
export IMG_NAME=myimage
export FILE_NAME=myimage
docker export $IMG_NAME | gzip > $FILE_NAME.tar.gz
gunzip < $FILE_NAME.tar.gz | docker import - $IMG_NAME
```

