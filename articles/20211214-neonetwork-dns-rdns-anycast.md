## DNS record
https://github.com/NeoCloud/NeoNetwork/commit/b23507e891fae79a78a6b207197b56e2f6c8c072

## runit service

```bash
#!/bin/bash
. /.denv
if [[ "$BIND9" == 1 ]]; then
  echo "bind9 enabled, start"
  mkdir -p /var/cache/bind
  mkdir -p /var/named
  exec named -g -c /etc/bind/named.conf
else
  echo "bind9 not enabled, down"
  sv down bind9
  exec sleep infinity
fi
```

## BIND9
 
/etc/bind/db.10.127.111
```
; SOA record
$TTL    3600
; name  class  type  nameserver        contact             (sn ref ret ex min)
@       IN     SOA   ns.kskb.neo.  dn42.kskb.eu.org  (
                                        4086       ; serial number
                                        3600       ; refresh
                                        180        ; update retry
                                        86400      ; expiry
                                        300        ; nxdomain ttl
                                        )
;
@              IN    NS      ns.kskb.neo.
1              IN    PTR     hk.kskb.neo.
9              IN    PTR     jp.kskb.neo.
17             IN    PTR     sg.kskb.neo.
33             IN    PTR    usw.kskb.neo.
51             IN    PTR     ca.kskb.neo.
65             IN    PTR     ch.kskb.neo.
66             IN    PTR     nl.kskb.neo.
81             IN    PTR     au.kskb.neo.
89             IN    PTR    uae.kskb.neo.
233            IN    PTR     ns.kskb.neo.
```
/etc/bind/db.fd10.127.e00f
```
; SOA record
$TTL    3600
; name  class  type  nameserver        contact             (sn ref ret ex min)
@       IN     SOA   ns.kskb.neo.  dn42.kskb.eu.org  (
                                        4086       ; serial number
                                        3600       ; refresh
                                        180        ; update retry
                                        86400      ; expiry
                                        300        ; nxdomain ttl
                                        )
;
@                                             IN    NS     ns.kskb.neo.
1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.1.0.0.0       IN    PTR    hk.kskb.neo.
1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.9.0.0.0       IN    PTR    jp.kskb.neo.
1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.1.1.0.0       IN    PTR    sg.kskb.neo.
1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.1.2.0.0       IN    PTR   usw.kskb.neo.
1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.3.3.0.0       IN    PTR    ca.kskb.neo.
1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.1.4.0.0       IN    PTR    ch.kskb.neo.
1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.2.4.0.0       IN    PTR    nl.kskb.neo.
1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.1.5.0.0       IN    PTR    au.kskb.neo.
1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.9.5.0.0       IN    PTR   uae.kskb.neo.
3.3.2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.c.a       IN    PTR    ns.kskb.neo.
```
/etc/bind/db.kskb.neo
```
; SOA record
$TTL    3600
; name  class  type  nameserver        contact             (sn ref ret ex min)
@       IN     SOA   ns.kskb.neo.  dn42.kskb.eu.org  (
                                        4086       ; serial number
                                        3600       ; refresh
                                        180        ; update retry
                                        86400      ; expiry
                                        300        ; nxdomain ttl
                                        )
;
; NS records
@                         IN    NS       ns.kskb.neo.
; A records or CNAME records
ns                        IN    A        10.127.111.233
hk                        IN    A        10.127.111.1
jp                        IN    A        10.127.111.9
sg                        IN    A        10.127.111.17
usw                       IN    A        10.127.111.33
ca                        IN    A        10.127.111.51
ch                        IN    A        10.127.111.65
nl                        IN    A        10.127.111.66
au                        IN    A        10.127.111.81
uae                       IN    A        10.127.111.89
ns                        IN    AAAA     fd10:127:e00f:aca::23
hk                        IN    AAAA     fd10:127:e00f:01::1
jp                        IN    AAAA     fd10:127:e00f:09::1
sg                        IN    AAAA     fd10:127:e00f:11::1
usw                       IN    AAAA     fd10:127:e00f:21::1
ca                        IN    AAAA     fd10:127:e00f:33::1
ch                        IN    AAAA     fd10:127:e00f:41::1
nl                        IN    AAAA     fd10:127:e00f:42::1
au                        IN    AAAA     fd10:127:e00f:51::1
uae                       IN    AAAA     fd10:127:e00f:59::1
```
/etc/bind/named.conf.default-zones
```
// prime the server with knowledge of the root servers
zone "." {
        type hint;
        file "/usr/share/dns/root.hints";
};

// be authoritative for the localhost forward and reverse zones, and for
// broadcast zones as per RFC 1912

zone "localhost" {
        type master;
        file "/etc/bind/db.local";
};

zone "127.in-addr.arpa" {
        type master;
        file "/etc/bind/db.127";
};

zone "0.in-addr.arpa" {
        type master;
        file "/etc/bind/db.0";
};

zone "255.in-addr.arpa" {
        type master;
        file "/etc/bind/db.255";
};

zone "kskb.neo" {
        type master;
        file "/etc/bind/db.kskb.neo";
};

zone "111.127.10.in-addr.arpa" {
        type master;
        file "/etc/bind/db.10.127.111";
};

zone "f.0.0.e.7.2.1.0.0.1.d.f.ip6.arpa" IN {
        type master;
        file "/etc/bind/db.fd10.127.e00f";
};

zone "neo." IN {
	type forward;
	forward only;
	forwarders { 10.127.255.54; fd10:127:53:53::;};
};

zone "dn42." {
  type forward;
  forwarders { 172.20.0.53; fd42:d42:d42:54::1; };
}; 
```
/etc/bind/named.conf.options
```
options {
    directory "/var/cache/bind";

        // If there is a firewall between you and nameservers you want
        // to talk to, you may need to fix the firewall to allow multiple
        // ports to talk.  See http://www.kb.cert.org/vuls/id/800113

        // If your ISP provided one or more IP addresses for stable 
        // nameservers, you probably want to use them as forwarders.  
        // Uncomment the following block, and insert the addresses replacing 
        // the all-0's placeholder.

        // forwarders {
        //      0.0.0.0;
        // };

        //========================================================================
        // If BIND logs error messages about the root key being expired,
        // you will need to update your keys.  See https://www.isc.org/bind-keys
        //========================================================================
    // directory "/var/named";
    pid-file "/run/named/named.pid";

    listen-on port 53 { 10.127.111.233; };
    listen-on-v6 port 53 { fd10:127:e00f:aca::233; };

    allow-recursion { any; };
    allow-transfer { none; };
    allow-query { any; };
    allow-update { none; };

    forwarders {
        1.1.1.1;
        8.8.4.4;
    };

    forward only;
    version none;
    hostname none;
    server-id none;

    dnssec-validation yes;
    dnssec-must-be-secure neo. no;
    dnssec-must-be-secure dn42. no;
}; 
```
/etc/bind/zones.rfc1918
```
// NeoNetwork
zone "127.10.in-addr.arpa" IN {
    type forward;
    forwarders { 10.127.255.54; fd10:127:53:53::;};
};
zone "7.2.1.0.0.1.d.f.ip6.arpa" IN {
    type forward;
    forward only;
    forwarders { 10.127.255.54; fd10:127:53:53::;};
};
// DN42 Network
zone "10.in-addr.arpa" {
  type forward;
  forwarders { 172.20.0.53; fd42:d42:d42:54::1; };
};
zone "20.172.in-addr.arpa" {
  type forward;
  forwarders { 172.20.0.53; fd42:d42:d42:54::1; };
};
zone "21.172.in-addr.arpa" {
  type forward;
  forwarders { 172.20.0.53; fd42:d42:d42:54::1; };
};
zone "22.172.in-addr.arpa" {
  type forward;
  forwarders { 172.20.0.53; fd42:d42:d42:54::1; };
};
zone "23.172.in-addr.arpa" {
  type forward;
  forwarders { 172.20.0.53; fd42:d42:d42:54::1; };
};
 zone "d.f.ip6.arpa" {
  type forward;
  forwarders { 172.20.0.53; fd42:d42:d42:54::1; };
};


zone "16.172.in-addr.arpa"  { type master; file "/etc/bind/db.empty"; };
zone "17.172.in-addr.arpa"  { type master; file "/etc/bind/db.empty"; };
zone "18.172.in-addr.arpa"  { type master; file "/etc/bind/db.empty"; };
zone "19.172.in-addr.arpa"  { type master; file "/etc/bind/db.empty"; };

zone "24.172.in-addr.arpa"  { type master; file "/etc/bind/db.empty"; };
zone "25.172.in-addr.arpa"  { type master; file "/etc/bind/db.empty"; };
zone "26.172.in-addr.arpa"  { type master; file "/etc/bind/db.empty"; };
zone "27.172.in-addr.arpa"  { type master; file "/etc/bind/db.empty"; };
zone "28.172.in-addr.arpa"  { type master; file "/etc/bind/db.empty"; };
zone "29.172.in-addr.arpa"  { type master; file "/etc/bind/db.empty"; };
zone "30.172.in-addr.arpa"  { type master; file "/etc/bind/db.empty"; };
zone "31.172.in-addr.arpa"  { type master; file "/etc/bind/db.empty"; };

zone "168.192.in-addr.arpa" { type master; file "/etc/bind/db.empty"; }; 
```

## Anycast

### linux
```bash
ip link set lo up
ip    addr  add       $DN42_IPV4_NET_BOARDCAST_ANYCAST dev lo
ip -6 route add local $DN42_IPV6_NET_BOARDCAST_ANYCAST dev lo
```

### BIRD
```
protocol static {
    route OWNNET reject { bgp_community.add((64511, DN42_REGION)); };
    route OWNNET_ANYCAST reject;

    ipv4 {
        import all;
        export none;
    };
}

protocol static {
    route OWNNETv6 reject { bgp_community.add((64511, DN42_REGION)); };
    route OWNNETv6_ANYCAST reject;
    
    ipv6 {
        import all;
        export none;
    };
}
```
