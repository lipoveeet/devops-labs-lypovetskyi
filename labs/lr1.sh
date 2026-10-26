cat /etc/os-release | head -4
---
ls /
---
ls -l /
---
mkdir -p ~/PI-23-03/Lypovetskyi ~/PI-23-03/Kochetov ~/PI-23-03/Mysliuk
---
touch ~/PI-23-03/Lypovetskyi/7.txt ~/PI-23-03/Kochetov/8.txt ~/PI-23-03/Mysliuk/9.txt
---
echo "Lypovetskyi Bohdan, PI-23-03, No 7" > ~/PI-23-03/Lypovetskyi/7.txt
---
ls -R ~/PI-23-03
---
tree ~/PI-23-03
---
sudo adduser --disabled-password --gecos "Bohdan Lypovetskyi" blypovetskyi
---
id blypovetskyi
---
grep blypovetskyi /etc/passwd
---
ls -lR ~/PI-23-03
---
sudo chown -R blypovetskyi:blypovetskyi ~/PI-23-03
---
sudo chmod -R u=rwX,go= ~/PI-23-03
---
sudo ls -lR ~/PI-23-03
---
ls ~/PI-23-03/Lypovetskyi
---
ifconfig
---
ip -4 addr show eth0
---
ping -c 4 google.com
---
ping -c 4 8.8.8.8
---
curl -sS -o /dev/null -w "HTTP %{http_code}, %{time_total}s\n" https://www.google.com
