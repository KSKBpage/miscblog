```
# If Upgrade is empty, Connection = close
map $http_upgrade $connection_upgrade {
    default upgrade;
    ''      close;
}

# HTTP server to redirect all 80 traffic to SSL/HTTPS
server {
  listen [::]:80;
  listen 80;
 
  server_name mydomain.kskb.eu.org;
  return 302 https://$host$request_uri; 
}
    
# HTTPS server to handle requests
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name mydomain.kskb.eu.org;
    ssl_certificate     '/etc/letsencrypt/live/mydomain.kskb.eu.org/fullchain.pem';
    ssl_certificate_key '/etc/letsencrypt/live/mydomain.kskb.eu.org/privkey.pem';
    location /.well-known {
        alias /var/www/html/.well-known;
    }
    # Managing literal requests to the JupyterHub front end
    location / {
        proxy_pass https://127.0.0.1:8000;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        # websocket headers
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
    }

}
```
