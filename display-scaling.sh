#!/usr/bin/env bash

# adapted from https://mensfeld.pl/2018/05/lenovo-thinkpad-x1-carbon-6th-gen-2018-ubuntu-18-04-tweaks/

# adjust display size if hd monitor attached with laptop wqhd display
xrandr --query  | grep ' connected' | grep 1920 > /dev/null
result=$?
if [ $result -ne 0 ]; then
	# WQHD monitor
	gsettings set org.gnome.desktop.interface text-scaling-factor 1.375
	gsettings set org.gnome.nautilus.icon-view default-zoom-level large
	gsettings set org.gnome.desktop.interface cursor-size 32
	gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 64
else
	# HD monitor
	gsettings set org.gnome.desktop.interface text-scaling-factor 1.0
	gsettings set org.gnome.nautilus.icon-view default-zoom-level small
	gsettings set org.gnome.desktop.interface cursor-size 24
	gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 48
fi
