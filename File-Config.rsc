# nov/30/2023 09:10:17 by RouterOS 6.45.9
# software id = WNIV-835A
#
# model = RB941-2nD
# serial number = D1130D1645FD
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n channel-width=20/40mhz-Ce \
    comment=08:55:31:99:EF:76 country=no_country_set disabled=no frequency=\
    auto frequency-mode=superchannel hide-ssid=yes mac-address=\
    D4:10:E7:00:04:00 mode=ap-bridge radio-name="" ssid=DALONET@WIFI vlan-id=\
    20 vlan-mode=use-tag wps-mode=disabled
/interface bridge
add name=bridge1 protocol-mode=none
/interface ethernet
set [ find default-name=ether1 ] comment=08:55:31:99:EF:71 mac-address=\
    D4:10:E7:00:04:01
set [ find default-name=ether2 ] comment=08:55:31:99:EF:72 mac-address=\
    D4:10:E7:00:04:02
set [ find default-name=ether3 ] comment=08:55:31:99:EF:73 full-duplex=no \
    mac-address=D4:10:E7:00:04:03
set [ find default-name=ether4 ] comment=08:55:31:99:EF:74 full-duplex=no \
    mac-address=D4:10:E7:00:04:04 speed=10Mbps
/interface wireless nstreme
set wlan1 comment=08:55:31:99:EF:76
/interface wireless manual-tx-power-table
set wlan1 comment=08:55:31:99:EF:76
/interface vlan
add interface=bridge1 name=vlan10-HS-SEI-R vlan-id=10
add interface=bridge1 name=vlan20-HS-DALONET vlan-id=20
add interface=bridge1 name=vlan30-HS-SEI-R-OUTDOOR vlan-id=30
add interface=bridge1 name=vlan40-FAKE vlan-id=40
add interface=bridge1 name=vlan50-MANAGEMENT-SMKN-5 vlan-id=50
add interface=bridge1 name=vlan100-PPPoE-HS-DALONET vlan-id=100
add interface=bridge1 name=vlan1000-PPPoE-HS-SEI-R vlan-id=1000
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip firewall layer7-protocol
add name=SpeedTest regexp="^.+(speedtest-+[a-z0-9.]+[a-z]+.net.id|nflxvideo.ne\
    t|ooklaserver.net|speedtestcustom.com|speedtest.net|fast.com|speedtest.+[a\
    -z]+.id|.speedtest.|openspeedtest.com).*\$"
/ip hotspot profile
set [ find default=yes ] dns-name=dalonet.wifi html-directory=flash \
    https-redirect=no login-by=http-chap,https,http-pap
add dns-name=dalonet.wifi hotspot-address=192.168.10.1 html-directory=flash \
    https-redirect=no login-by=http-chap,https,http-pap name=PROF-VLAN10
add dns-name=dalonet.wifi hotspot-address=192.168.20.1 html-directory=flash \
    https-redirect=no login-by=http-chap,https,http-pap name=PROF-VLAN20
add dns-name=dalonet.wifi hotspot-address=192.168.30.1 html-directory=flash \
    https-redirect=no login-by=http-chap,https,http-pap name=PROF-VLAN30
add dns-name=dalonet.wifi hotspot-address=10.0.0.1 html-directory=flash \
    https-redirect=no login-by=http-chap,https,http-pap name=PROF-VLAN-1000
add dns-name=dalonet.wifi hotspot-address=192.168.40.1 html-directory=flash \
    https-redirect=no login-by=http-chap,https,http-pap name=PROF-VLAN40-FAKE
/ip hotspot user profile
set [ find default=yes ] add-mac-cookie=no name=DALONET rate-limit=100M/100M \
    shared-users=5
add add-mac-cookie=no !mac-cookie-timeout name=2JAM on-login=":put (\",remc,20\
    00,2h,2000,,Disable,Disable,\"); :local mode \"X\"; {:local date [ /system\
    \_clock get date ];:local year [ :pick \$date 7 11 ];:local month [ :pick \
    \$date 0 3 ];:local comment [ /ip hotspot user get [/ip hotspot user find \
    where name=\"\$user\"] comment]; :local ucode [:pic \$comment 0 2]; :if (\
    \$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ /sys sch ad\
    d name=\"\$user\" disable=no start-date=\$date interval=\"2h\"; :delay 2s;\
    \_:local exp [ /sys sch get [ /sys sch find where name=\"\$user\" ] next-r\
    un]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$ex\
    p 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\
    \$year \$t\"); /ip hotspot user set comment=\"\$exp \$mode\" [find where n\
    ame=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\
    \$date \$exp \$mode\" [find where name=\"\$user\"];}; :if (\$getxp > 15) d\
    o={ /ip hotspot user set comment=\"\$exp \$mode\" [find where name=\"\$use\
    r\"];}; /sys sch remove [find where name=\"\$user\"]; :local mac \$\"mac-a\
    ddress\"; :local time [/system clock get time ]; /system script add name=\
    \"\$date-|-\$time-|-\$user-|-2000-|-\$address-|-\$mac-|-2h-|-2JAM-|-\$comm\
    ent\" owner=\"\$month\$year\" source=\$date comment=mikhmon}}" \
    parent-queue=none rate-limit=512k/1m status-autorefresh=10m
add add-mac-cookie=no !mac-cookie-timeout name=5JAM on-login=":put (\",remc,50\
    00,5h,5000,,Disable,Disable,\"); :local mode \"X\"; {:local date [ /system\
    \_clock get date ];:local year [ :pick \$date 7 11 ];:local month [ :pick \
    \$date 0 3 ];:local comment [ /ip hotspot user get [/ip hotspot user find \
    where name=\"\$user\"] comment]; :local ucode [:pic \$comment 0 2]; :if (\
    \$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ /sys sch ad\
    d name=\"\$user\" disable=no start-date=\$date interval=\"5h\"; :delay 2s;\
    \_:local exp [ /sys sch get [ /sys sch find where name=\"\$user\" ] next-r\
    un]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$ex\
    p 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\
    \$year \$t\"); /ip hotspot user set comment=\"\$exp \$mode\" [find where n\
    ame=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\
    \$date \$exp \$mode\" [find where name=\"\$user\"];}; :if (\$getxp > 15) d\
    o={ /ip hotspot user set comment=\"\$exp \$mode\" [find where name=\"\$use\
    r\"];}; /sys sch remove [find where name=\"\$user\"]; :local mac \$\"mac-a\
    ddress\"; :local time [/system clock get time ]; /system script add name=\
    \"\$date-|-\$time-|-\$user-|-5000-|-\$address-|-\$mac-|-5h-|-5JAM-|-\$comm\
    ent\" owner=\"\$month\$year\" source=\$date comment=mikhmon}}" \
    parent-queue=none rate-limit=512k/1m status-autorefresh=10m
add name=30-Hari on-login=":put (\",remc,70000,30d,70000,,Disable,Disable,\");\
    \_:local mode \"X\"; {:local date [ /system clock get date ];:local year [\
    \_:pick \$date 7 11 ];:local month [ :pick \$date 0 3 ];:local comment [ /\
    ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]\
    ; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"\
    up\" or \$comment = \"\") do={ /sys sch add name=\"\$user\" disable=no sta\
    rt-date=\$date interval=\"30d\"; :delay 2s; :local exp [ /sys sch get [ /s\
    ys sch find where name=\"\$user\" ] next-run]; :local getxp [len \$exp]; :\
    if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 1\
    6]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /ip hotspot user \
    set comment=\"\$exp \$mode\" [find where name=\"\$user\"];}; :if (\$getxp \
    = 8) do={ /ip hotspot user set comment=\"\$date \$exp \$mode\" [find where\
    \_name=\"\$user\"];}; :if (\$getxp > 15) do={ /ip hotspot user set comment\
    =\"\$exp \$mode\" [find where name=\"\$user\"];}; /sys sch remove [find wh\
    ere name=\"\$user\"]; :local mac \$\"mac-address\"; :local time [/system c\
    lock get time ]; /system script add name=\"\$date-|-\$time-|-\$user-|-7000\
    0-|-\$address-|-\$mac-|-30d-|-30-Hari-|-\$comment\" owner=\"\$month\$year\
    \" source=\$date comment=mikhmon}}" parent-queue=none rate-limit=512k/2m \
    status-autorefresh=10m
add name=15-Hari on-login=":put (\",remc,38000,15d,38000,,Disable,Disable,\");\
    \_:local mode \"X\"; {:local date [ /system clock get date ];:local year [\
    \_:pick \$date 7 11 ];:local month [ :pick \$date 0 3 ];:local comment [ /\
    ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]\
    ; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"\
    up\" or \$comment = \"\") do={ /sys sch add name=\"\$user\" disable=no sta\
    rt-date=\$date interval=\"15d\"; :delay 2s; :local exp [ /sys sch get [ /s\
    ys sch find where name=\"\$user\" ] next-run]; :local getxp [len \$exp]; :\
    if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 1\
    6]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /ip hotspot user \
    set comment=\"\$exp \$mode\" [find where name=\"\$user\"];}; :if (\$getxp \
    = 8) do={ /ip hotspot user set comment=\"\$date \$exp \$mode\" [find where\
    \_name=\"\$user\"];}; :if (\$getxp > 15) do={ /ip hotspot user set comment\
    =\"\$exp \$mode\" [find where name=\"\$user\"];}; /sys sch remove [find wh\
    ere name=\"\$user\"]; :local mac \$\"mac-address\"; :local time [/system c\
    lock get time ]; /system script add name=\"\$date-|-\$time-|-\$user-|-3800\
    0-|-\$address-|-\$mac-|-15d-|-15-Hari-|-\$comment\" owner=\"\$month\$year\
    \" source=\$date comment=mikhmon}}" parent-queue=none rate-limit=512k/1m \
    status-autorefresh=10m
/ip pool
add name=POOL-VLAN10 ranges=192.168.10.2-192.168.10.254
add name=POOL-VLAN20 ranges=192.168.20.2-192.168.20.254
add name=POOL-VLAN30 ranges=192.168.30.2-192.168.30.254
add name=POOL-VLAN-1000 ranges=10.0.0.2-10.255.255.254
add name=POOL-VLAN50-SMKN-5 ranges=192.168.50.2-192.168.50.254
add name=POOL-VLAN40-FAKE ranges=192.168.40.2-192.168.40.254
add name=POOL-PPPoE-UpTo-10 ranges=192.168.70.2-192.168.70.254
add name=POOL-PPPoE-UpTo-1 ranges=192.168.90.2-192.168.90.254
add name=POOL-PPPoE-UpTo-5 ranges=192.168.80.2-192.168.80.254
add name=POOL-PPPoE-UpTo-20 ranges=192.168.60.2-192.168.60.254
/ip dhcp-server
add address-pool=POOL-VLAN10 disabled=no interface=vlan10-HS-SEI-R \
    lease-time=6h name=DHCPS-VLAN10
add address-pool=POOL-VLAN20 disabled=no interface=vlan20-HS-DALONET \
    lease-time=6h name=DHCPS-VLAN20
add address-pool=POOL-VLAN30 disabled=no interface=vlan30-HS-SEI-R-OUTDOOR \
    lease-time=6h name=DHCPS-VLAN30
add address-pool=POOL-VLAN-1000 disabled=no interface=vlan1000-PPPoE-HS-SEI-R \
    lease-time=6h name=DHCPS-VLAN-1000
add address-pool=POOL-VLAN50-SMKN-5 disabled=no interface=\
    vlan50-MANAGEMENT-SMKN-5 lease-time=6h name=DHCPS-VLAN50-SMKN-5
add address-pool=POOL-VLAN40-FAKE disabled=no interface=vlan40-FAKE \
    lease-time=6h name=DHCPS-VLAN40-FAKE
/ip hotspot
add address-pool=POOL-VLAN10 addresses-per-mac=1 disabled=no interface=\
    vlan10-HS-SEI-R keepalive-timeout=5m name=HS-SEI-R profile=PROF-VLAN10
add address-pool=POOL-VLAN20 addresses-per-mac=1 disabled=no interface=\
    vlan20-HS-DALONET keepalive-timeout=5m name=HS-DALONET profile=\
    PROF-VLAN20
add address-pool=POOL-VLAN30 addresses-per-mac=1 disabled=no interface=\
    vlan30-HS-SEI-R-OUTDOOR keepalive-timeout=5m name=HS-SEI-R-OUTDOOR \
    profile=PROF-VLAN30
add address-pool=POOL-VLAN-1000 addresses-per-mac=1 disabled=no interface=\
    vlan1000-PPPoE-HS-SEI-R name=HS-PPPoE-VLAN-1000-SEI-R profile=\
    PROF-VLAN-1000
add address-pool=POOL-VLAN40-FAKE addresses-per-mac=1 disabled=no interface=\
    vlan40-FAKE name=HS-VLAN40-FAKE profile=PROF-VLAN40-FAKE
/queue simple
add comment=BYPASS limit-at=512k/1M max-limit=512k/1M name=OP-HP \
    packet-marks=BYPASS-OP-HP target="10.0.0.0/8,192.168.10.0/24,192.168.20.0/\
    24,192.168.30.0/24,192.168.40.0/24"
add max-limit=25600k/38400k name=PPPoE-UpTo-1 target=192.168.90.0/24
add max-limit=128M/192M name=PPPoE-UpTo-5 target=192.168.80.0/24
add disabled=yes max-limit=5M/5M name=SPEEDTEST-5MB packet-marks=\
    "PAKET=SPEEDTEST" target=192.168.80.0/24
add max-limit=256M/384M name=PPPoE-UpTo-10 target=192.168.70.0/24
add max-limit=512M/768M name=PPPoE-UpTo-20 target=192.168.60.0/24
/ppp profile
add local-address=192.168.90.1 name=UpTo-1 only-one=yes parent-queue=\
    PPPoE-UpTo-1 rate-limit="512K/1024K 0/0 0/0 8/8 512K/768K" \
    remote-address=POOL-PPPoE-UpTo-1
add local-address=192.168.60.1 name=UpTo-20 only-one=yes parent-queue=\
    PPPoE-UpTo-20 rate-limit="10240K/20480K 0/0 0/0 8/8 7680K/15360K" \
    remote-address=POOL-PPPoE-UpTo-20
add local-address=192.168.80.1 name=UpTo-5 only-one=yes parent-queue=\
    PPPoE-UpTo-5 rate-limit="2560K/5120K 0/0 0/0 8/8 1920K/3840K" \
    remote-address=POOL-PPPoE-UpTo-5
add local-address=192.168.70.1 name=UpTo-10 only-one=yes parent-queue=\
    PPPoE-UpTo-10 rate-limit="5120K/10240K 0/0 0/0 8/8 3840K/7680K" \
    remote-address=POOL-PPPoE-UpTo-10
/snmp community
add addresses=0.0.0.0/0 name=HelpTECHSNMP
/system logging action
set 0 memory-lines=500
set 1 disk-file-name=log disk-lines-per-file=500
/interface bridge port
add bridge=bridge1 interface=vlan10-HS-SEI-R
add bridge=bridge1 interface=vlan20-HS-DALONET
add bridge=bridge1 interface=vlan30-HS-SEI-R-OUTDOOR
add bridge=bridge1 interface=vlan1000-PPPoE-HS-SEI-R
add bridge=bridge1 interface=vlan40-FAKE
add bridge=bridge1 interface=ether1
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=vlan50-MANAGEMENT-SMKN-5
add bridge=bridge1 interface=vlan100-PPPoE-HS-DALONET
add bridge=bridge1 interface=ether4
add bridge=bridge1 interface=wlan1
add bridge=bridge1 interface=ether3
/ip firewall connection tracking
set enabled=yes generic-timeout=5m icmp-timeout=5s tcp-close-timeout=1s \
    tcp-close-wait-timeout=5s tcp-fin-wait-timeout=5s tcp-last-ack-timeout=1s \
    tcp-syn-received-timeout=1s tcp-syn-sent-timeout=1s \
    tcp-time-wait-timeout=1s udp-stream-timeout=1m udp-timeout=1s
/ip neighbor discovery-settings
set discover-interface-list=none
/interface bridge vlan
add bridge=bridge1 tagged=vlan20-HS-DALONET untagged=wlan1 vlan-ids=20
/interface pppoe-server server
add disabled=no interface=vlan100-PPPoE-HS-DALONET service-name=PPPoE-Server
/ip address
add address=172.16.0.2/16 interface=bridge1 network=172.16.0.0
add address=192.168.10.1/24 interface=vlan10-HS-SEI-R network=192.168.10.0
add address=192.168.20.1/24 interface=vlan20-HS-DALONET network=192.168.20.0
add address=192.168.30.1/24 interface=vlan30-HS-SEI-R-OUTDOOR network=\
    192.168.30.0
add address=10.0.0.1/8 interface=vlan1000-PPPoE-HS-SEI-R network=10.0.0.0
add address=192.168.50.1/24 interface=vlan50-MANAGEMENT-SMKN-5 network=\
    192.168.50.0
add address=192.168.40.1/24 interface=vlan40-FAKE network=192.168.40.0
add address=192.168.80.1/24 interface=vlan100-PPPoE-HS-DALONET network=\
    192.168.80.0
/ip cloud
set update-time=no
/ip dhcp-server network
add address=10.0.0.0/8 dns-server=10.0.0.1,1.1.1.1,1.0.0.1 gateway=10.0.0.1 \
    netmask=32
add address=192.168.10.0/24 dns-server=192.168.10.1,1.1.1.1,1.0.0.1 gateway=\
    192.168.10.1 netmask=32
add address=192.168.20.0/24 dns-server=192.168.20.1,1.1.1.1,1.0.0.1 gateway=\
    192.168.20.1 netmask=32
add address=192.168.30.0/24 dns-server=192.168.30.1,1.1.1.1,1.0.0.1 gateway=\
    192.168.30.1 netmask=32
add address=192.168.40.0/24 dns-server=192.168.40.1,1.1.1.1,1.0.0.1 gateway=\
    192.168.40.1 netmask=32
add address=192.168.50.0/24 dns-server=192.168.50.1,1.1.1.1,1.0.0.1 gateway=\
    192.168.50.1 netmask=32
/ip dns
set allow-remote-requests=yes servers=1.1.1.1,1.0.0.1
/ip firewall address-list
add address=192.168.10.0/24 list=ISP+HOTSPOT
add address=192.168.20.0/24 list=ISP+HOTSPOT
add address=192.168.30.0/24 list=ISP+HOTSPOT
add address=10.0.0.0/8 list=ISP+HOTSPOT
add address=172.16.0.0/16 list=ISP+HOTSPOT
add address=192.168.50.0/24 list=ISP+HOTSPOT
add address=192.168.40.0/24 list=ISP+HOTSPOT
add address=10.0.0.1 list=DNS
add address=192.168.10.1 list=DNS
add address=192.168.20.1 list=DNS
add address=192.168.30.1 list=DNS
add address=192.168.40.1 list=DNS
add address=1.1.1.1 list=DNS
add address=1.0.0.1 list=DNS
add address=192.168.80.0/24 list=ISP+HOTSPOT
add address=192.168.60.0/24 list=ISP+HOTSPOT
add address=192.168.70.0/24 list=ISP+HOTSPOT
add address=192.168.90.0/24 list=ISP+HOTSPOT
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=drop chain=forward comment="DNS BLOCK" dst-address=8.8.8.8 \
    dst-port=54,443 protocol=tcp
add action=drop chain=forward dst-address=8.8.4.4 dst-port=54,443 protocol=\
    tcp
add action=drop chain=input dst-address=8.8.8.8 dst-port=54,443 protocol=tcp
add action=drop chain=input dst-address=8.8.4.4 dst-port=54,443 protocol=tcp
add action=drop chain=input dst-address=8.8.8.8 dst-port=54,443 protocol=udp
add action=drop chain=input dst-address=8.8.4.4 dst-port=54,443 protocol=udp
add action=drop chain=forward dst-address=8.8.8.8 dst-port=54,443 protocol=\
    udp
add action=drop chain=forward dst-address=8.8.4.4 dst-port=54,443 protocol=\
    udp
add action=drop chain=input comment="BLOCK !DNS" dst-address-list=!DNS \
    dst-port=53 protocol=udp
add action=drop chain=input dst-address-list=!DNS dst-port=53 protocol=tcp
add action=drop chain=forward dst-address-list=!DNS dst-port=53 protocol=udp
add action=drop chain=forward dst-address-list=!DNS dst-port=53 protocol=tcp
add action=jump chain=forward comment=ddos connection-state=new jump-target=\
    detect-ddos
add action=return chain=detect-ddos dst-limit=32,32,src-and-dst-addresses/10s
add action=return chain=detect-ddos src-address-list=ISP+HOTSPOT
add action=return chain=detect-ddos src-address-list=ISP+HOTSPOT
add action=add-dst-to-address-list address-list=ddosed address-list-timeout=\
    10m chain=detect-ddos
add action=add-src-to-address-list address-list=ddoser address-list-timeout=\
    10m chain=detect-ddos
add action=drop chain=forward connection-state=new dst-address-list=ddosed \
    log=yes log-prefix=DDoS src-address-list=ddoser
add action=drop chain=input comment="drop SSH&TELNET Brute Forcers" dst-port=\
    22-23 log=yes log-prefix=BruteForcesSshTelnet protocol=tcp \
    src-address-list=IP_BlackList
add action=add-src-to-address-list address-list=IP_BlackList \
    address-list-timeout=1d chain=input connection-state=new dst-port=22-23 \
    protocol=tcp src-address-list=SSH_BlackList_3
add action=add-src-to-address-list address-list=SSH_BlackList_3 \
    address-list-timeout=1m chain=input connection-state=new dst-port=22-23 \
    protocol=tcp src-address-list=SSH_BlackList_2
add action=add-src-to-address-list address-list=SSH_BlackList_2 \
    address-list-timeout=1m chain=input connection-state=new dst-port=22-23 \
    protocol=tcp src-address-list=SSH_BlackList_1
add action=add-src-to-address-list address-list=SSH_BlackList_1 \
    address-list-timeout=1m chain=input connection-state=new dst-port=22-23 \
    protocol=tcp
add action=drop chain=input comment="drop FTP Brute Forcers" dst-port=21 log=\
    yes log-prefix=BruteForcesFtp protocol=tcp src-address-list=FTP_BlackList
add action=add-dst-to-address-list address-list=FTP_BlackList \
    address-list-timeout=1d chain=output content="530 Login incorrect" \
    protocol=tcp
add action=add-dst-to-address-list address-list=FTP_BlackList \
    address-list-timeout=1d chain=output content="530 Login incorrect" \
    protocol=tcp
add action=accept chain=output content="530 Login incorrect" dst-limit=\
    1/1m,9,dst-address/1m protocol=tcp
add action=drop chain=input comment="drop Winbox Brute Forces" dst-port=8291 \
    log=yes log-prefix=BruteForcesWinbox protocol=tcp src-address-list=\
    IP_BlackList_Winbox
add action=add-src-to-address-list address-list=IP_BlackList_Winbox \
    address-list-timeout=1d chain=input connection-state=new dst-port=8291 \
    protocol=tcp src-address-list=SSH_BlackList_Winbox_3
add action=add-src-to-address-list address-list=SSH_BlackList_Winbox_3 \
    address-list-timeout=1m chain=input connection-state=new dst-port=8291 \
    protocol=tcp src-address-list=SSH_BlackList_Winbox_2
add action=add-src-to-address-list address-list=SSH_BlackList_Winbox_2 \
    address-list-timeout=1m chain=input connection-state=new dst-port=8291 \
    protocol=tcp src-address-list=SSH_BlackList_Winbox_1
add action=add-src-to-address-list address-list=SSH_BlackList_Winbox_1 \
    address-list-timeout=1m chain=input connection-state=new dst-port=8291 \
    protocol=tcp
add action=drop chain=input comment="drop port scanners" log=yes log-prefix=\
    PortScanner src-address-list=port_scanners
add action=add-src-to-address-list address-list=port_scanners \
    address-list-timeout=2w chain=input protocol=tcp tcp-flags=\
    fin,!syn,!rst,!psh,!ack,!urg
add action=add-src-to-address-list address-list=port_scanners \
    address-list-timeout=2w chain=input protocol=tcp tcp-flags=fin,syn
add action=add-src-to-address-list address-list=port_scanners \
    address-list-timeout=2w chain=input protocol=tcp tcp-flags=syn,rst
add action=add-src-to-address-list address-list=port_scanners \
    address-list-timeout=2w chain=input protocol=tcp tcp-flags=\
    fin,psh,urg,!syn,!rst,!ack
add action=add-src-to-address-list address-list=port_scanners \
    address-list-timeout=2w chain=input protocol=tcp tcp-flags=\
    fin,syn,rst,psh,ack,urg
add action=add-src-to-address-list address-list=port_scanners \
    address-list-timeout=2w chain=input protocol=tcp tcp-flags=\
    !fin,!syn,!rst,!psh,!ack,!urg
add action=tarpit chain=input comment="FAKE PORT" dst-port=21,22,23,80,8291 \
    protocol=tcp
add action=drop chain=forward comment="DROP NETCUT" src-address-list=\
    IP_NETCUT
/ip firewall mangle
add action=add-dst-to-address-list address-list=SPEEDTEST-LIST \
    address-list-timeout=1h chain=prerouting comment=SPEEDTEST disabled=yes \
    dst-address-list=!ISP+HOTSPOT layer7-protocol=SpeedTest src-address-list=\
    ISP+HOTSPOT
add action=mark-connection chain=prerouting disabled=yes dst-address-list=\
    SPEEDTEST-LIST new-connection-mark=KONEKSI-SPEEDTEST passthrough=yes \
    src-address-list=SPEEDTEST-LIST
add action=mark-packet chain=forward connection-mark=KONEKSI-SPEEDTEST \
    disabled=yes new-packet-mark="PAKET=SPEEDTEST" passthrough=no
add action=change-ttl chain=postrouting comment=\
    "BLOKIR SHARE VOUCHER VLAN1000" new-ttl=set:1 out-interface=\
    vlan1000-PPPoE-HS-SEI-R passthrough=no
add action=change-ttl chain=postrouting comment="BLOKIR SHARE VOUCHER VLAN10" \
    new-ttl=set:1 out-interface=vlan10-HS-SEI-R passthrough=no
add action=change-ttl chain=postrouting comment="BLOKIR SHARE VOUCHER VLAN20" \
    new-ttl=set:1 out-interface=vlan20-HS-DALONET passthrough=no
add action=change-ttl chain=postrouting comment="BLOKIR SHARE VOUCHER VLAN30" \
    new-ttl=set:1 out-interface=vlan30-HS-SEI-R-OUTDOOR passthrough=no
add action=change-ttl chain=postrouting comment=\
    "BLOKIR SHARE VOUCHER VLAN40 FAKE" new-ttl=set:1 out-interface=\
    vlan40-FAKE passthrough=no
add action=mark-connection chain=prerouting comment=BYPASS-OP#HP \
    new-connection-mark=MAC-OP-HP passthrough=yes src-mac-address=\
    BC:2D:EF:4B:8E:A1
add action=mark-packet chain=prerouting connection-mark=MAC-OP-HP \
    new-packet-mark=BYPASS-OP-HP passthrough=no
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=redirect chain=dstnat comment="BLOCK CHANGE DNS" dst-address-list=\
    !DNS dst-port=53 protocol=udp to-ports=53
add action=redirect chain=dstnat comment="BLOCK CHANGE DNS" dst-address-list=\
    !DNS dst-port=53 protocol=tcp to-ports=53
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.168.10.0/24
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.168.20.0/24
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.168.30.0/24
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.168.40.0/24
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=10.0.0.0/8
add action=masquerade chain=srcnat comment="masquerade PPoE-UpTo" \
    src-address=192.168.80.0/24
/ip firewall raw
add action=drop chain=prerouting dst-address-list=!DNS dst-port=53,853 \
    protocol=udp src-address=10.0.0.2-10.255.255.254
add action=drop chain=prerouting dst-address-list=!DNS dst-port=53,853 \
    protocol=tcp src-address=10.0.0.2-10.255.255.254
add action=drop chain=prerouting dst-address-list=!DNS dst-port=53,853 \
    protocol=udp src-address=192.168.10.2-192.168.10.254
add action=drop chain=prerouting dst-address-list=!DNS dst-port=53,853 \
    protocol=tcp src-address=192.168.10.2-192.168.10.254
add action=drop chain=prerouting dst-address-list=!DNS dst-port=53,853 \
    protocol=udp src-address=192.168.20.2-192.168.20.254
add action=drop chain=prerouting dst-address-list=!DNS dst-port=53,853 \
    protocol=tcp src-address=192.168.20.2-192.168.20.254
add action=drop chain=prerouting dst-address-list=!DNS dst-port=53,853 \
    protocol=udp src-address=192.168.30.2-192.168.30.254
add action=drop chain=prerouting dst-address-list=!DNS dst-port=53,853 \
    protocol=tcp src-address=192.168.30.2-192.168.30.254
add action=drop chain=prerouting dst-address-list=!DNS dst-port=53,853 \
    protocol=udp src-address=192.168.40.2-192.168.40.254
add action=drop chain=prerouting dst-address-list=!DNS dst-port=53,853 \
    protocol=tcp src-address=192.168.40.2-192.168.40.254
add action=add-src-to-address-list address-list=IP_NETCUT \
    address-list-timeout=10m chain=prerouting content=.arcai.com \
    dst-address-list=!ISP+HOTSPOT src-address-list=ISP+HOTSPOT
/ip firewall service-port
set ftp disabled=yes
set tftp disabled=yes
set irc disabled=yes
set h323 disabled=yes
set sip disabled=yes
set pptp disabled=yes
set udplite disabled=yes
set dccp disabled=yes
set sctp disabled=yes
/ip hotspot ip-binding
add comment="AP EKSTERNAL" mac-address=2C:C8:1B:6C:46:E1 type=bypassed
add comment="AP EKSTERNAL" mac-address=2C:C8:1B:6C:46:E0 type=bypassed
add comment=CCTV mac-address=A0:36:DA:18:97:23 type=bypassed
add comment="HP OPERATOR SEI RAYA" mac-address=BC:2D:EF:4B:8E:A1 type=\
    bypassed
add comment="RASPBERRY PI" mac-address=DC:A6:32:B8:56:6D type=bypassed
/ip hotspot service-port
set ftp disabled=yes
/ip hotspot user
add name=admin password=@p3Xqwerty
/ip hotspot walled-garden
add comment="place hotspot rules here" disabled=yes
/ip hotspot walled-garden ip
add action=accept disabled=no !dst-address !dst-address-list dst-host=\
    dalonet.com !dst-port !protocol !src-address !src-address-list
/ip proxy
set cache-administrator="" parent-proxy=0.0.0.0
/ip route
add check-gateway=ping distance=1 gateway=172.16.0.1
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www port=8008
set ssh disabled=yes
set api disabled=yes
set winbox port=8009
set api-ssl disabled=yes
/ppp secret
add local-address=192.168.80.1 name=jakarya password=jakarya profile=UpTo-5 \
    remote-address=192.168.80.254 service=pppoe
add name=cl-upto-5 password=cl-upto-5 profile=UpTo-5 service=pppoe
add name=cl-upto-20 password=cl-upto-20 profile=UpTo-20 service=pppoe
add name=cl-upto-10 password=cl-upto-10 profile=UpTo-10 service=pppoe
/snmp
set enabled=yes trap-community=HelpTECHSNMP trap-generators="" trap-version=2
/system clock
set time-zone-autodetect=no time-zone-name=Asia/Jakarta
/system identity
set name=-
/system logging
add action=disk prefix=-> topics=hotspot,info,debug
/system ntp client
set enabled=yes server-dns-names=0.id.pool.ntp.org,1.id.pool.ntp.org
/system package update
set channel=long-term
/system scheduler
add comment="Mikhmon Expire Monitor" interval=1m name=Mikhmon-Expire-Monitor \
    on-event=":local dateint do={:local montharray ( \"jan\",\"feb\",\"mar\",\
    \"apr\",\"may\",\"jun\",\"jul\",\"aug\",\"sep\",\"oct\",\"nov\",\"dec\" );\
    :local days [ :pick \$d 4 6 ];:local month [ :pick \$d 0 3 ];:local year [\
    \_:pick \$d 7 11 ];:local monthint ([ :find \$montharray \$month]);:local \
    month (\$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:r\
    eturn [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\
    \$year\$month\$days\")];}};:local timeint do={:local hours [ :pick \$t 0 2\
    \_];:local minutes [ :pick \$t 3 5 ];:return (\$hours * 60 + \$minutes) ;}\
    ;:local date [ /system clock get date ];:local time [ /system clock get ti\
    me ];:local today [\$dateint d=\$date] ;:local curtime [\$timeint t=\$time\
    ] ;:local tyear [ :pick \$date 7 11 ];:local lyear (\$tyear-1);:foreach i \
    in [ /ip hotspot user find where comment~\"/\$tyear\" || comment~\"/\$lyea\
    r\" ] do={:local comment [ /ip hotspot user get \$i comment]; :local limit\
    \_[ /ip hotspot user get \$i limit-uptime]; :local name [ /ip hotspot user\
    \_get \$i name]; :local gettime [:pic \$comment 12 20];:if ([:pic \$commen\
    t 3] = \"/\" and [:pic \$comment 6] = \"/\") do={:local expd [\$dateint d=\
    \$comment] ;:local expt [\$timeint t=\$gettime] ;:if ((\$expd < \$today an\
    d \$expt < \$curtime) or (\$expd < \$today and \$expt > \$curtime) or (\$e\
    xpd = \$today and \$expt < \$curtime) and \$limit != \"00:00:01\") do={ :i\
    f ([:pic \$comment 21] = \"N\") do={[ /ip hotspot user set limit-uptime=1s\
    \_\$i ];[ /ip hotspot active remove [find where user=\$name] ];} else={[ /\
    ip hotspot user remove \$i ];[ /ip hotspot active remove [find where user=\
    \$name] ];}}}}}" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=mar/23/2023 start-time=00:00:00
add disabled=yes interval=1d name=enable-trial on-event="/ip hotspot profile s\
    et PROF-VLAN10 login-by=http-chap,http-pap,https,trial;\r\
    \n/ip hotspot profile set PROF-VLAN20 login-by=http-chap,http-pap,https,tr\
    ial;\r\
    \n/ip hotspot profile set PROF-VLAN30 login-by=http-chap,http-pap,https,tr\
    ial;\r\
    \n/ip hotspot profile set PROF-DALONET login-by=http-chap,http-pap,https,t\
    rial;\r\
    \n/ip hotspot profile set PROF-VLAN-1000 login-by=http-chap,http-pap,https\
    ,trial;\r\
    \n/ip hotspot profile set default login-by=http-chap,http-pap,https,trial;\
    " policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=mar/23/2023 start-time=17:30:00
add disabled=yes interval=1d name=disable-trial on-event="/ip hotspot profile \
    set PROF-VLAN10 login-by=http-chap,http-pap,https;\r\
    \n/ip hotspot profile set PROF-VLAN20 login-by=http-chap,http-pap,https;\r\
    \n/ip hotspot profile set PROF-VLAN30 login-by=http-chap,http-pap,https;\r\
    \n/ip hotspot profile set PROF-DALONET login-by=http-chap,http-pap,https;\
    \r\
    \n/ip hotspot profile set PROF-VLAN-1000 login-by=http-chap,http-pap,https\
    ;\r\
    \n/ip hotspot profile set default login-by=http-chap,http-pap,https;" \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=mar/23/2023 start-time=19:00:00
add disabled=yes interval=1d name=hapus-user-trial on-event="/ip hotspot user \
    remove number=[find where name~\"T-\"];\r\
    \n/ip hotspot active remove number=[find where user~\"T-\"];" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=mar/23/2023 start-time=19:00:10
add interval=25m name=HAPUS-HS on-event=\
    "/queue simple remove [ find name ~\"hs-<\" ]" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
add interval=5m name=AUTO-BLOK-USER-ANEH on-event="local hblock \"1048576\";\r\
    \n/ip hotspot host remove [find authorized=no bypassed=no ((bytes-in+bytes\
    -out) < \$hblock)];\r\
    \n/ip hotspot host make-binding type=blocked comment=\"BLOKIR USER AFK DI \
    HOST\" [find authorized=no bypassed=no ((bytes-in+bytes-out) > \$hblock)];\
    " policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
add interval=30m name=AUTO-UNBLOCK-USER-ANEH on-event="/ip hotspot ip-binding \
    remove [find comment=\"BLOKIR USER AFK DI HOST\"];" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
/system watchdog
set automatic-supout=no watchdog-timer=no
/tool bandwidth-server
set enabled=no
/tool mac-server
set allowed-interface-list=none
/tool mac-server mac-winbox
set allowed-interface-list=none
/tool mac-server ping
set enabled=no
