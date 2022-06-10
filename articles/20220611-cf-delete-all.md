Delete all record in cloudflare 

```
#!/bin/bash
apt install jq parallel
EMAIL=me@gmail.com
TOKEN="XXXXXXXXXXXXXXXXXXXXXXXXXX"
ZONE_ID="XXXXXXXXXXXXXXXXXXXX"

echo "" > deldns.txt

curl -s -X GET https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records?per_page=500 \
    -H "X-Auth-Email: ${EMAIL}" \
    -H "X-Auth-Key: ${TOKEN}" \
    -H "Content-Type: application/json" | jq .result[].id |  tr -d '"' | (
  while read id; do     
    echo curl -s -X DELETE https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${id} \
      -H \"X-Auth-Email: ${EMAIL}\"  \
      -H \"X-Auth-Key: ${TOKEN}\" \
      -H \"Content-Type: application/json\" >> deldns.txt;
  done;   
  )
  
cat deldns.txt | parallel --jobs 100
```
