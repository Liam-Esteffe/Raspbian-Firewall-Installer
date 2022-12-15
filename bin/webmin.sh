#!/bin/sh


# This script will install and configure the webmin

wget https://prdownloads.sourceforge.net/webadmin/webmin_1.941.tar.gz

tar -xvzf webmin_1.941.tar.gz

cd webmin-1.941

sudo ./setup.sh /usr/share/webmin