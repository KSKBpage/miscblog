Quick generate keys

```
easyrsa init-pki
easyrsa build-ca nopass
easyrsa gen-req server.kskb.ix nopass
easyrsa sign-req server server.kskb.ix
easyrsa gen-req client.leko.kskb.ix nopass
easyrsa sign-req client client.leko.kskb.ix
```

Quick p2p conn
```
openvpn --genkey

openvpn --port 1195 --cipher AES-256-CBC --proto tcp-server --dev-type tun --dev "ovpn-test-s" --secret static.key --ifconfig-ipv6 fdd6:5901:7cfb:1d23::1/124 fdd6:5901:7cfb:1d23::2
openvpn --remote example.com --port 1195 --cipher AES-256-CBC --proto tcp-client --dev-type tun --dev "ovpn-test-c" --secret static.key --ifconfig-ipv6 fdd6:5901:7cfb:1d23::2/124 fdd6:5901:7cfb:1d23::1
```
