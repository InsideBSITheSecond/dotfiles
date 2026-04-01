#!/bin/bash
# Wait for Wayland socket to actually exist on disk
until [ -S "${XDG_RUNTIME_DIR}/wayland-1" ] 2>/dev/null || \
      [ -S "${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}" ] 2>/dev/null; do
    sleep 0.3
done

systemctl --user import-environment WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd --all
systemctl --user start hyprpolkitagent