#!/usr/bin/env bash

# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# Co=Author: Eleengineer
# License: MIT
# https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE

source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"                       # Crafty Controller requires Python 3.9+
$STD sudo add-apt-repository ppa:deadsnakes/ppa
$STD sudo apt update
$STD sudo apt install python3.9 -y
# Update and upgrade packages
$STD apt update && apt upgrade -y
# $STD apt install python3
# Install Git
$STD apt install git -y
msg_ok "Git Installed"
# Install JDK 21
$STD apt install openjdk-21-jdk -y
msg_ok "openjdk Installed"
msg_info "cloning crafty"
# Clone the Crafty installer and run it
$STD git clone https://gitlab.com/crafty-controller/crafty-installer-4.0.git
msg_info "Installing Crafty"

$STD cd crafty-installer-4.0 && sudo ./install_crafty.sh


msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/crafty.service
[Unit]
Description=Crafty-Controller: Take Control of Your Servers
After=network-online.target
Wants=network-online.target

[Service]
Environment="LC_ALL=C.UTF-8"
Environment="LANG=C.UTF-8"
Type=exec
User=crafty
ExecStart=/opt/crafty/bin/crafty serve

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now crafty.service
msg_ok "Created Service"

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
