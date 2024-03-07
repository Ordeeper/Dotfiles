#!/usr/bin/env bash

if [ "$(systemctl is-active waydroid-container.service)" != 'active' ]; then
    sudo systemctl start waydroid-container.service;
fi

weston --xwayland &
export WAYLAND_DISPLAY=wayland-1;

sleep 2

waydroid session stop;
waydroid session start &
waydroid show-full-ui &
