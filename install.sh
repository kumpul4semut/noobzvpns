#!/bin/sh

echo ""
echo "#########################################################"
echo "## -> NoobzVpn-Server by Noobz-ID Software             ##"
echo "## -> Author : Muhammad Nurkholis                      ##"
echo "## -> Email : cholieztzuliz@gmail.com                  ##"
echo "## -> Github : https://github.com/zuliz95              ##"
echo "## -> (c) 2017-2022, Noobz-ID Software                 ##"
echo "#########################################################"
echo ""

BIN=/usr/bin
CONFIGS=/etc/noobzvpns
SYSTEMD=/etc/systemd/system
SYSTEMCTL=$(which systemctl)

if [ `id -u` != "0" ]; then
    echo "Error at installation, please run installer as root user"
    exit 1
fi

if [ ! -d $SYSTEMD ]; then
    echo "Error at installation, no systemd directory found. make sure your distro using systemd as default init"
    exit 1
fi

if [ ! -f $SYATEMCTL ]; then
    echo "Error at installation, no systemctl binary found. make sure your distro using systemd as default init"
    exit 1
fi

echo "Preparing installation..."
$SYSTEMCTL daemon-reload
$SYSTEMCTL stop noobzvpns.service
$SYSTEMCTL disable noobzvpns.service
rm $SYSTEMD/noobzvpns.service
rm $BIN/noobzvpns
rm $CONFIGS/cert.pem
rm $CONFIGS/key.pem

echo "Copying directory and files..."
mkdir $CONFIGS
cp noobzvpns $BIN/noobzvpns
cp cert.pem $CONFIGS/cert.pem
cp key.pem $CONFIGS/key.pem
cp noobzvpns.service $SYSTEMD/noobzvpns.service
if [ ! -f $CONFIGS/config.json ]; then
    cp config.json $CONFIGS/config.json
fi

echo "Setting files permission.."
chmod 700 $BIN/noobzvpns
chmod 700 $CONFIGS/cert.pem
chmod 700 $CONFIGS/config.json
chmod 700 $CONFIGS/key.pem
chmod 700 $SYSTEMD/noobzvpns.service

echo "Finishing installation..."
$SYSTEMCTL daemon-reload
$SYSTEMCTL enable noobzvpns.service

echo "Installation finished."

echo ""
echo "[ NOTE ]"
echo "-Config and SSL(KEY/CERT) location: $CONFIGS"
echo "-Service Commands :"
echo "   + Start -> systemctl start noobzvpns.service"
echo "   + Restart -> systemctl restart noobzvpns.service"
echo "   + Stop -> systemctl stop noobzvpns.service"
echo "   + Log/Status -> systemctl status noobzvpns.service -l"
echo "   + Enable auto-start (enabled by default) -> systemctl enable noobzvpns.service"
echo "   + Disable auto-start -> systemctl disable noobzvpns.service"
echo "   + Full logs -> journalctl -u noobzvpns.service"


