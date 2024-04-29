Download cloudflare binary from https://github.com/cloudflare/cloudflared/releases/ and move to /usr/bin

Login and create tunnel on local machine
```bash
# 把 tw42 改成自定義名字
cloudflared login
cloudflared tunnel create tw42
# 把 tw42.kskb.eu.org 改成外部 domain
cloudflared tunnel route dns tw42 tw42.kskb.eu.org
grep -Irn tw42 ~/.cloudflared/ #把內容複製到web server上面
```

Run cloudflared on web server
```bash
# credentials.json 從PC複製過來
cloudflared --credentials-file /etc/cloudflared/credentials.json --url http://127.0.0.1:$WEB_PORT tunnel run tw42
```
