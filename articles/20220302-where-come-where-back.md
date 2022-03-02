```
ip6tables -t mangle -A PREROUTING -j CONNMARK --restore-mark 
ip6tables -t mangle -A PREROUTING -i ens160 ! -d fe80::/10 -j MARK --set-mark 0x160
ip6tables -t mangle -A PREROUTING -m mark --mark 0x160 -j CONNMARK --save-mark
ip6tables -t mangle -A OUTPUT -j CONNMARK --restore-mark

ip -6 rule add fwmark 0x160 table 160
ip -6 route add default via fe80::281:2dff:fe29:f22e dev ens160 table 160
```
