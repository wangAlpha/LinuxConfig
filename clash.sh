#!/bin/bash

set -x
add=
chmod +x `which clash`
proxy=https://sub.fnf.xyz/link/Z7ocRYnaT9I1T3u6?clash=1
wget -O config.yaml https://sub.fnf.xyz/link/Z7ocRYnaT9I1T3u6?clash=1
wget -O Country.mmdb https://www.sub-speeder.com/client-download/Country.mmdb

settings set org.gnome.system.proxy mode 'manual'
# gsettings set org.gnome.system.proxy.http port 7890
# gsettings set org.gnome.system.proxy.http host '127.0.0.1'
# gsettings set org.gnome.system.proxy.socks port 7891
# gsettings set org.gnome.system.proxy.socks host '127.0.0.1'
# gsettings set org.gnome.system.proxy ignore-hosts "['localhost', '127.0.0.0/8', '::1']"
clash_service
touch $clash_service
chmod +x $check_service
echo "[Unit]
Description=clash daemon
[Service]
Type=simple
User=root
ExecStart=/opt/clash/clash -d /opt/clash/
Restart=on-failure
[Install]
WantedBy=multi-user.target" > $clash_service

systemctl daemon-reload
# systemctl start clash.service
systemctl enable clash.service
systemctl start clash.service
# systemctl start clash.service

git config --global https.proxy 'socks5://127.0.0.1:7891'
