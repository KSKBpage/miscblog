# Shrink pve-root without reinstall

create `/etc/initramfs-tools/scripts/local-premount/resizefs` with permission 755
```bash
#!/bin/sh

set -e

PREREQS=""

prereqs() { echo "$PREREQS"; }

case "$1" in
    prereqs)
        prereqs
        exit 0
    ;;
esac

/sbin/e2fsck -yf /dev/pve/root
/sbin/resize2fs /dev/pve/root 14G #use 14G first
/sbin/e2fsck -yf /dev/pve/root
```

create `/etc/initramfs-tools/hooks/resizefs` with permission 755
```bash
#!/bin/sh

set -e

PREREQS=""

prereqs() { echo "$PREREQS"; }

case $1 in
    prereqs)
        prereqs
        exit 0
    ;;
esac

. /usr/share/initramfs-tools/hook-functions

copy_exec /sbin/e2fsck
copy_exec /sbin/resize2fs

exit 0
```


update initramfs, perform our action at next boot
```
chmod 755 /etc/initramfs-tools/hooks/resizefs
chmod 755 /etc/initramfs-tools/scripts/local-premount/resizefs
update-initramfs -u -k $(uname -r)
reboot
```

after reboot, you will find out the `/dev/pve/root` has been shrinked
then we can reduce the size of the LVM volume with `lvreduce`

```
lvreduce -L 16G /dev/mapper/pve-root
resize2fs /dev/mapper/pve-root  # expand to 16G
```

Finally, we can expand our data storage size
```
lvextend -l +100%FREE /dev/pve/data
```

remove unnecessary files
```
rm /etc/initramfs-tools/hooks/resizefs
rm /etc/initramfs-tools/scripts/local-premount/resizefs
update-initramfs -u -k $(uname -r)
```
