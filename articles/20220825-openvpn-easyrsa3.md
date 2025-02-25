Quick generate keys

```bash
export OVPN_SERVER_NAME=tpe.kskb.stuin
export EASYRSA_CA_EXPIRE=365000
export EASYRSA_CERT_EXPIRE=365000
export EASYRSA_CRL_DAYS=365000
./easyrsa init-pki
./easyrsa gen-dh
./easyrsa build-ca nopass
./easyrsa gen-req  server.$OVPN_SERVER_NAME nopass
./easyrsa sign-req server server.$OVPN_SERVER_NAME

cat pki/ca.crt
cat pki/issued/server.$OVPN_SERVER_NAME.crt
cat pki/private/server.$OVPN_SERVER_NAME.key
cat pki/dh.pem
```

Client:
```
export OVPN_CLIENT_NAME=haraguroicha
export OVPN_SERVER_NAME=tpe.kskb.stuin
./easyrsa gen-req  client.$OVPN_CLIENT_NAME.$OVPN_SERVER_NAME nopass
./easyrsa sign-req client client.$OVPN_CLIENT_NAME.$OVPN_SERVER_NAME

cat pki/ca.crt
cat pki/issued/client.$OVPN_CLIENT_NAME.$OVPN_SERVER_NAME.crt
cat pki/private/client.$OVPN_CLIENT_NAME.$OVPN_SERVER_NAME.key
cat pki/dh.pem
```

Quick p2p conn
```bash
openvpn --genkey

openvpn --port 1195 --cipher AES-256-CBC --proto tcp-server --dev-type tun --dev "ovpn-test-s" --secret static.key --ifconfig-ipv6 fdd6:5901:7cfb:1d23::1/124 fdd6:5901:7cfb:1d23::2
openvpn --remote example.com --port 1195 --cipher AES-256-CBC --proto tcp-client --dev-type tun --dev "ovpn-test-c" --secret static.key --ifconfig-ipv6 fdd6:5901:7cfb:1d23::2/124 fdd6:5901:7cfb:1d23::1
```
