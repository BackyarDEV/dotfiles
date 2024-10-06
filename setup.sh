#!/bin/bash

echo "Checking for dependecies..."

requiredPkgs=("zsh" "git" "neovim" "zsh-autosuggestions" "zsh-syntax-highlighting" "ncurses" "oh-my-posh")

checkForPKG() {
  if [ "oh-my-posh" = "$pkg" ]; then
    PKG_OK=$(whereis $pkg | grep "/")
      if [ "" = "$PKG_OK" ]; then
        echo "0"
      else
        echo "1"
      fi
  else
    PKG_OK=$(rpm -q $1 | grep "not installed")
    if [ "" = "$PKG_OK" ]; then
      echo "1"
    else
      echo "0"
    fi
  fi
}
installOMP="0"
installOthers="0"
for pkg in ${requiredPkgs[@]}; do
  has_pkg=$(checkForPKG $pkg)
  if [ "0" = "$has_pkg" ]; then
    if [ "oh-my-posh" = "$pkg" ]; then
      installOMP="1"
    else
      installOthers="1"
      unavailablePkgs="$unavailablePkgs $pkg "
    fi
  fi
done


if [ "1" = $installOthers ]; then
  sudo dnf install $unavailablePkgs -y
else
  if [[ "1" = $installOMP ]]; then
    curl -s https://ohmyposh.dev/install.sh | bash -s
  fi
fi

