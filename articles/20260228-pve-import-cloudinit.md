## Set STORAGE POOL

```bash
STORAGE_POOL=local-lvm
```

## Debian
```bash
apt install libguestfs-tools -y
# Debian
ARCH=amd64
VER=13
CODE=trixie
wget https://cloud.debian.org/images/cloud/$CODE-backports/daily/latest/debian-$VER-backports-generic-$ARCH-daily.qcow2
virt-customize -a debian-$VER-backports-generic-$ARCH-daily.qcow2 --install qemu-guest-agent
qm create 900$VER --name "Cloudinit-D$VER" --memory 2048 --balloon 0 --cores 1 --net0 virtio,bridge=vmbr0 --bios ovmf --machine q35 --ostype l26
qm importdisk 900$VER debian-$VER-backports-generic-amd64-daily.qcow2 $STORAGE_POOL
qm set 900$VER --virtio0 $STORAGE_POOL:vm-900$VER-disk-0
qm set 900$VER --efidisk0 $STORAGE_POOL:0,format=raw,efitype=4m,pre-enrolled-keys=0
qm set 900$VER --ide2 $STORAGE_POOL:cloudinit
qm set 900$VER --ciuser debian --cipassword changeme --ipconfig0 ip=dhcp,ip6=auto --ciupgrade 1
qm set 900$VER --serial0 socket --vga serial0
qm set 900$VER --boot c --bootdisk virtio0
qm set 900$VER --agent enabled=1
qm resize 900$VER virtio0 8G
# Enable 3D accelration
# qm set 900$VER --args "-device virtio-vga-gl,venus=true,blob=true,hostmem=4G -display egl-headless,rendernode=/dev/dri/renderD128"
qm template 900$VER
```

## Ubuntu
```bash
apt install libguestfs-tools -y
# Ubuntu
ARCH=amd64
VER=24
CODE=noble
wget https://cloud-images.ubuntu.com/$CODE/current/$CODE-server-cloudimg-$ARCH.img
virt-customize -a $CODE-server-cloudimg-$ARCH.img --install qemu-guest-agent
qm create 900$VER --name "Cloudinit-U$VER" --memory 2048 --balloon 0 --cores 1 --net0 virtio,bridge=vmbr0 --bios ovmf --machine q35 --ostype l26
qm importdisk 900$VER $CODE-server-cloudimg-$ARCH.img $STORAGE_POOL
qm set 900$VER --virtio0 $STORAGE_POOL:vm-900$VER-disk-0
qm set 900$VER --efidisk0 $STORAGE_POOL:0,format=raw,efitype=4m,pre-enrolled-keys=0
qm set 900$VER --ide2 $STORAGE_POOL:cloudinit
qm set 900$VER --ciuser ubuntu --cipassword changeme --ipconfig0 ip=dhcp,ip6=auto --ciupgrade 1
qm set 900$VER --serial0 socket --vga serial0
qm set 900$VER --boot c --bootdisk virtio0
qm set 900$VER --agent enabled=1
qm resize 900$VER virtio0 8G
# Enable 3D accelration
# qm set 900$VER --args "-device virtio-vga-gl,venus=true,blob=true,hostmem=4G -display egl-headless,rendernode=/dev/dri/renderD128"
qm template 900$VER
```
