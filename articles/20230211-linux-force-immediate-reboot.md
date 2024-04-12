強制重啟，約等於斷電重啟
```
sync
echo 1 > /proc/sys/kernel/sysrq
echo b > /proc/sysrq-trigger
```
