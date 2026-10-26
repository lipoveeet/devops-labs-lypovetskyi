cd ~ && whoami; hostname
---
ps
---
ps aux | head -25
---
ps -ef --forest | head -30
---
top -b -n 1 | head -20
---
pstree -p | head -20
---
xvfb-run -a gnome-calculator > /dev/null 2>&1 &
sleep 4
---
ps aux | grep -i calculator | grep -v grep
---
pgrep -af gnome-calculator
---
kill $(pgrep -f gnome-calculator)
sleep 1
---
ps aux | grep -i calculator | grep -v grep || echo "process gnome-calculator not found"
---
firefox --headless > /dev/null 2>&1 &
sleep 5
---
pgrep -a firefox | head -5
---
kill -9 $(pgrep -o firefox); sleep 1; pgrep -a firefox || echo "firefox killed"
---
mkdir -p ~/user_dir && echo "created by $(whoami)" > ~/user_dir/user_file.txt && ls -ld ~/user_dir && ls -l ~/user_dir
---
sudo -i
---
#@root
whoami; id
---
#@root
mkdir /root/root_dir && echo "created by $(whoami)" > /root/root_dir/root_file.txt
---
#@root
ls -ld /root/root_dir; ls -l /root/root_dir
---
#@root
mkdir -p /srv/root_dir && echo "created by root" > /srv/root_dir/root_file.txt && ls -ld /srv/root_dir && ls -l /srv/root_dir
---
cat /srv/root_dir/root_file.txt; echo "test" >> /srv/root_dir/root_file.txt
---
ls /root
---
crontab -l
---
(crontab -l 2>/dev/null; echo "*/1 * * * * date >> /tmp/cron_test.log") | crontab -
---
crontab -l
---
sudo service cron start; sleep 65; cat /tmp/cron_test.log
