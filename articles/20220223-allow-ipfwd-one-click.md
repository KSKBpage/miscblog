人品過濾器，防火牆forward，ip_forward 一鍵三連
```
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv4.conf.all.rp_filter=0
sysctl -w net.ipv4.conf.default.rp_filter=0
sysctl -w net.ipv6.conf.all.disable_ipv6=0
sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv6.conf.default.forwarding=1
sysctl -a |grep -F ".rp_filter" |sed "s/= 2/= 0/g"| sysctl -p -
sysctl -a |grep -F ".rp_filter" |sed "s/= 1/= 0/g"| sysctl -p -
```
