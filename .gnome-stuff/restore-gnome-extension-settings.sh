requiredExts=("caffeine@patapon.info" "Vitals@CoreCoding.com" "blur-my-shell@aunetx" "dash-to-panel@jderose9.github.com")

output=$(gsettings get org.gnome.shell enabled-extensions)

set -f
exts="${output//[\[\]\',]/}"

function exists_in_list() {
    LIST=$1
    VALUE=$2
    for x in ${LIST[@]}; do
	if [ "$x" = "$VALUE" ]; then
            return 0
        fi
    done
    return 1
}


function restore_settings() {
    if [ "$1" = "dash-to-panel@jderose9.github.com" ]; then
	dconf load /org/gnome/shell/extensions/dash-to-panel/ < gnome-extension-settings/dtp_settings
    elif [ "$1" = "caffeine@patapon.info" ]; then
	dconf load /org/gnome/shell/extensions/caffeine/ < gnome-extension-settings/caffeine_settings
    elif [ "$1" = "blur-my-shell@aunetx" ]; then
	dconf load /org/gnome/shell/extensions/blur-my-shell/ < gnome-extension-settings/bms_settings
    elif [ "$1" = "Vitals@CoreCoding.com" ]; then
	dconf load /org/gnome/shell/extensions/Vitals/ < gnome-extension-settings/vitals_settings
    else
	echo "No backup found for $1"
    fi
    echo "Done"
}

for i in ${!requiredExts[@]}; do
  currentExt=${requiredExts[i]}
  if exists_in_list "$exts" "$currentExt"; then
    echo ""
    echo "Restoring Settings for $currentExt..."
    restore_settings $currentExt
  else
    echo ""
    echo "$currentExt is not installed!"
    echo "Please install $currentExt and run this script again!"
  fi
done

echo ""
