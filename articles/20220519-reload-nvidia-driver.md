reload nvidia driver

```
lsof -n -w  /dev/nvidia* | awk '{print $2}' | xargs -L 1 kill
systemctl stop gdm
rmmod nvidia_drm
rmmod nvidia_uvm
rmmod nvidia_modeset
rmmod nvidia
nvidia-smi
```
