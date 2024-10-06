#!/bin/bash

echo "Restoring dash-to-panel settings..."
dconf load /org/gnome/shell/extensions/dash-to-panel/ < gnome-extension-settings/dtp_settings
echo "Restoring caffeine settings..."
dconf load /org/gnome/shell/extensions/caffeine/ < gnome-extension-settings/caffeine_settings
echo "Restoring blur-my-shell settings..."
dconf load /org/gnome/shell/extensions/blur-my-shell/ < gnome-extension-settings/bms_settings
echo "Restoring Vitals settings..."
dconf load /org/gnome/shell/extensions/Vitals/ < gnome-extension-settings/vitals_settings

echo "All Done!"
