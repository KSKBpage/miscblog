## .tar
安裝套件:
```
apt-get install -y tar
```
壓縮:
```
tar cvf FileName.tar DirName
```
解壓:
```
tar xvf FileName.tar
```

## .gz
安裝套件:
```
apt-get install -y gzip
```
壓縮:
```
gzip FileName
```
解壓:
```
gunzip FileName.gz
```
解壓2:
```
gzip -d FileName.gz
```

## .tar.gz
安裝套件:
```
apt-get install -y gzip
```
壓縮:
```
tar zcvf FileName.tar.gz DirName
```
解壓:
```
tar zxvf FileName.tar.gz
```

## .bz
安裝套件:
```
apt-get install -y bzip2
```
解壓:
```
bzip2 -d FileName.bz
```
解壓2:
```
bunzip2 FileName.bz
```

## .tar.bz
安裝套件:
```
apt-get install -y bzip2
```
解壓:
```
tar jxvf FileName.tar.bz
```

## .bz2
安裝套件:
```
apt-get install -y bzip2
```
壓縮:
```
bzip2 -z FileName
```
解壓:
```
bzip2 -d FileName.bz2
```
解壓2:
```
bunzip2 FileName.bz2
```

## .tar.bz2
安裝套件:
```
apt-get install -y bzip2
```
壓縮:
```
tar jcvf FileName.tar.bz2 DirName
```
解壓:
```
tar jxvf FileName.tar.bz2
```

## .tar.bz2 (parallel)
安裝套件:
```
apt-get install -y lbzip2
```
壓縮:
```
tar -I lbzip2 -cvf FileName.tar.bz2 DirName
```

## .xz
安裝套件:
```
apt-get install -y xz-utils
```
壓縮:
```
xz -z FileName
```
解壓:
```
xz -d FileName.xz
```

## .tar.xz
安裝套件:
```
apt-get install -y xz-utils
```
壓縮:
```
tar Jcvf FileName.tar.xz DirName
```
解壓:
```
tar Jxvf FileName.tar.xz
```

## .Z
安裝套件:
```
apt-get install -y ncompress
```
壓縮:
```
compress FileName
```
解壓:
```
uncompress FileName.Z
```

## .tar.Z
安裝套件:
```
apt-get install -y ncompress
```
壓縮:
```
tar Zcvf FileName.tar.Z DirName
```
解壓:
```
tar Zxvf FileName.tar.Z
```

## .tgz
安裝套件:
```
apt-get install -y gzip
```
壓縮:
```
tar zcvf FileName.tgz FileName
```
解壓:
```
tar zxvf FileName.tgz
```

## .tar.tgz
安裝套件:
```
apt-get install -y gzip
```
壓縮:
```
tar zcvf FileName.tar.tgz FileName
```
解壓:
```
tar zxvf FileName.tar.tgz
```

## .7z
安裝套件:
```
apt-get install -y p7zip-full
```
壓縮:
```
7z a FileName.7z FileName
```
使用密碼 (PASSWORD) 壓縮:
```
7z a FileName.7z FileName -pPASSWORD
```
解壓:
```
7z x FileName.7z
```

## .zip
安裝套件:
```
apt-get install -y zip unzip
```
壓縮:
```
zip -r FileName.zip DirName
```
解壓:
```
unzip FileName.zip
```

## .rar
安裝套件:
```
apt-get install -y rar unrar
```
壓縮:
```
rar a FileName.rar DirName
```
解壓:
```
rar e FileName.rar
```
解壓2:
```
unrar e FileName.rar
```
解壓3:
```
rar x FileName.rar DirName
```

## .lha
安裝套件:
```
apt-get install -y lha
```
壓縮:
```
lha -a FileName.lha FileName
```
解壓:
```
lha -e FileName.lha
```

## .zst
安裝套件:
```
apt-get install -y zstd
```
壓縮:
```
zst FileName
```
解壓:
```
zstd -d FileName.zst
```

## .tar.zst
安裝套件:
```
apt-get install -y zstd
```
壓縮:
```
tar -I zstd -cvf FileName.tar.zst DirName
```
```
tar -I zstd -cvf FileName.tar.zst File1 File2
```
解壓:
```
tar -I zstd -xvf FileName.tar.zst
```
