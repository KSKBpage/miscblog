```
[Interface]
PrivateKey = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
Address = 172.16.0.2/32
Address = fdXX:XXXX:XXXX:XXXX:XXX:XXXX:XXXX:XXXX/128
MTU = 1440
Table = off

PostUP = ip -6 route replace default dev %i
PostUP = ip route add default dev %i table 2222
PostUP = ip rule add fwmark 0x2222 table 2222
PostUP = iptables -A OUTPUT -t mangle -p tcp --dport 22 -j MARK --set-mark 0x2222

PostDown = ip rule del fwmark 0x2222
PostDown = iptables -D OUTPUT -t mangle -p tcp --dport 22 -j MARK --set-mark 0x2222

[Peer]
PublicKey = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
AllowedIPs = 0.0.0.0/0
AllowedIPs = ::/0
Endpoint = engage.cloudflareclient.com:2408
```
