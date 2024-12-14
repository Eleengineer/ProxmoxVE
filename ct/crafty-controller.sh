#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/community-scripts//ProxmoxVE/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
   ______           ______              ______            __             ____         
  / ____/________ _/ __/ /___  __      / ____/___  ____  / /__________  / / /__  _____
 / /   / ___/ __ `/ /_/ __/ / / /_____/ /   / __ \/ __ \/ __/ ___/ __ \/ / / _ \/ ___/
/ /___/ /  / /_/ / __/ /_/ /_/ /_____/ /___/ /_/ / / / / /_/ /  / /_/ / / /  __/ /    
\____/_/   \__,_/_/  \__/\__, /      \____/\____/_/ /_/\__/_/   \____/_/_/\___/_/     
                        /____/                                                        
EOF
}
header_info
echo -e "Loading..."
APP="Crafty-Controller"
var_disk="20"
var_cpu="2"
var_ram="2048"
var_os="ubuntu"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
    header_info
    if [[ ! -d /opt/crafty ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
    # msg_info "Stopping Crafty-Controller"
    # systemctl stop crafty
    # msg_ok "Stopped Crafty-Controller"

    # msg_info "Updating Crafty-Controller"
    # source /opt/crafty/bin/activate
    # pip3 install Crafty --upgrade &>/dev/null
    # msg_ok "Updated Crafty-Controller"

    # msg_info "Starting Crafty"
    # systemctl start crafty
    # msg_ok "Started Crafty"
    # msg_ok "Updated Successfully"
    exit
}

# function install_crafty() {
#     }

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
         ${BL}https://${IP}:8443${CL} \n"
