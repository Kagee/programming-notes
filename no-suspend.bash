#!/bin/bash

# Bash script for trying to turn of all suspend/
# hibernation etc, for systemd and GDM.
set -x

mkdir -p \
        /etc/systemd/sleep.conf.d \
        /etc/systemd/logind.conf.d \
        /usr/share/gdm/dconf/

cat > /usr/share/gdm/dconf/91-nosuspend <<EOF
[org/gnome/settings-daemon/plugins/power]
sleep-inactive-ac-timeout=0
sleep-inactive-ac-type='nothing'
sleep-inactive-battery-timeout=0
sleep-inactive-battery-type='nothing'
EOF

chown root:root /usr/share/gdm/dconf/91-nosuspend
chmod 644 /usr/share/gdm/dconf/91-nosuspend


cat > /etc/systemd/sleep.conf.d/nosuspend.conf <<EOF
[Sleep]
AllowSuspend=no
AllowHibernation=no
AllowSuspendThenHibernate=no
AllowHybridSleep=no
EOF

chown root:root /etc/systemd/sleep.conf.d/nosuspend.conf
chmod 644 /etc/systemd/sleep.conf.d/nosuspend.conf

systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target

loginctl enable-linger $USER

cat > /etc/systemd/logind.conf.d/no-sleep.conf<<EOF
[Login]
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
HandleSuspendKey=ignore
HandleSuspendKeyLongPress=ignore
HandleHibernateKey=ignore
HandleHibernateKeyLongPress=ignore
IdleAction=ignore
EOF

chown root:root /etc/systemd/logind.conf.d/no-sleep.conf
chmod 644 /etc/systemd/logind.conf.d/no-sleep.conf

