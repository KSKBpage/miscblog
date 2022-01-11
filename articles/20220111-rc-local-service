```
cat <<EOT > /etc/systemd/system/rc-local.service
[Unit]
Description=/etc/rc.local Compatibility
ConditionPathExists=/etc/rc.local
After=network.target
Requires=network-online.target
After=systemd-networkd-wait-online.service
Requires=systemd-networkd-wait-online.service

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOT

systemctl enable rc-local
chmod 755 /etc/rc.local
```
