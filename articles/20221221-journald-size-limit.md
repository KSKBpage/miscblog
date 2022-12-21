```
echo "SystemMaxUse=100M" >> /etc/systemd/journald.conf
systemctl restart systemd-journald
journalctl --vacuum-size=100M
```
