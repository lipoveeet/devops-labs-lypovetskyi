ip addr
---
ip route
---
ip route | grep default
---
ping -c 4 8.8.8.8
---
ping -c 4 google.com
---
nslookup google.com
---
traceroute -m 20 google.com
---
sudo traceroute -T -p 443 -m 20 google.com
---
ss -tuln
---
curl -s https://example.com
---
curl -I https://example.com
---
curl -s ifconfig.me; echo
---
ip -4 addr show eth0 | grep inet
---
nc -vz google.com 443
---
cat /etc/resolv.conf
---
resolvectl status | head -20
