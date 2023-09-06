```
[Unit]
Description=Script to enable SR-IOV on boot

[Service]
Type=oneshot
Environment=SRIOV_MAC_ADDR_PREFIX=2e:ce:5b:e3
ExecStartPre=/usr/bin/bash -c '/usr/bin/echo 32 > /sys/class/net/ens1f0/device/sriov_numvfs'
ExecStartPre=/usr/bin/bash -c '/usr/bin/echo 32 > /sys/class/net/ens1f1/device/sriov_numvfs'
ExecStartPre=bash -c "for((pf=0;pf<=1;pf++)); do for((vf=0;vf<=31;vf++));   do /usr/bin/ip link set dev ens1f$${pf}v$vf up ; /usr/bin/ip link set dev ens1f$pf vf $vf mac ${SRIOV_MAC_ADDR_PREFIX}:f$(printf '%%01x' $pf):$(printf '%%02x' $vf); /usr/bin/ip link set dev ens1f$pf vf $vf trust on ; /usr/bin/ip link set dev ens1f$${pf}v$vf down ; done; done; /bin/true"
ExecStart=/usr/bin/bash -c 'ip link set ens1f0 up'

[Install]
WantedBy=multi-user.target
```
