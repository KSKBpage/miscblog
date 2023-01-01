```
[Interface]
PrivateKey = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
Address = 172.16.0.2/32
Address = XXXX:XXXX:XXX:XXXX:XXXX:XXXX:XXXX:XXXX/128
MTU = 1440
Table=13335

PostUP=  ip    rule add from 192.168.35.0/24          lookup 13335
PostUP=  ip -6 rule add from fd4d:f0e9:5128:9785::/64 lookup 13335
PostUP=  iptables  -t nat -A POSTROUTING -o %i -j MASQUERADE
PostUP=  ip6tables -t nat -A POSTROUTING -o %i -j MASQUERADE

PostDown=ip    rule del from 192.168.35.0/24          lookup 13335 || true
PostDown=ip -6 rule del from fd4d:f0e9:5128:9785::/64 lookup 13335 || true
PostDown=iptables  -t nat -D POSTROUTING -o %i -j MASQUERADE       || true
PostDown=ip6tables -t nat -D POSTROUTING -o %i -j MASQUERADE       || true

[Peer]
PublicKey = bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=
AllowedIPs = 0.0.0.0/0
AllowedIPs = ::/0
Endpoint = 162.159.192.1:2408
```

```
docker network create \
    --driver=bridge \
    --subnet=192.168.35.0/24 \
    --gateway=192.168.35.1 \
    --ipv6 \
    --subnet=fd4d:f0e9:5128:9785::/64 \
    --gateway=fd4d:f0e9:5128:9785::1 \
    net-wgcf
```

```
docker run -it --rm --network=net-wgcf debian
```
