#!/bin/bash

mkdir /tmp/linver
touch /tmp/linver/linver.info

infofile=/tmp/linver/linver.info

# Modelo do PC
if [[ -d /system/app/ && -d /system/priv-app ]]; then
    model="$(getprop ro.product.brand) $(getprop ro.product.model)"

elif [[ -f /sys/devices/virtual/dmi/id/product_name ||
        -f /sys/devices/virtual/dmi/id/product_version ]]; then
    model=$(< /sys/devices/virtual/dmi/id/product_name)
    model+=" $(< /sys/devices/virtual/dmi/id/product_version)"

elif [[ -f /sys/firmware/devicetree/base/model ]]; then
    model=$(< /sys/firmware/devicetree/base/model)

elif [[ -f /tmp/sysinfo/model ]]; then
    model=$(< /tmp/sysinfo/model)
fi

echo "Model: $model" >> $infofile

# Consegue o desktop

if [[ $DESKTOP_SESSION == *regolith ]]; then
    de=Regolith

elif [[ $XDG_CURRENT_DESKTOP ]]; then
    de=${XDG_CURRENT_DESKTOP/X\-}
    de=${de/Budgie:GNOME/Budgie}
    de=${de/:Unity7:ubuntu}

elif [[ $DESKTOP_SESSION ]]; then
    de=${DESKTOP_SESSION##*/}

elif [[ $GNOME_DESKTOP_SESSION_ID ]]; then
    de=GNOME

elif [[ $MATE_DESKTOP_SESSION_ID ]]; then
    de=MATE

elif [[ $TDE_FULL_SESSION ]]; then
    de=Trinity
fi

echo "DE: $de" >> $infofile

# Pega informação sobre o processador
cat /proc/cpuinfo >> $infofile

# Pega o nome do usuário mesmo que ele esteja usando sudo
echo "Login: $(logname)" >> $infofile
