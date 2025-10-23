#!/bin/bash
# ThinkPad T480 Comfort Setup for Kali XFCE
# Author: Nikita

echo -e "\n💻 ThinkPad Setup: запуск...\n"

DEVICE=$(xinput list --name-only | grep -i "synaptics" | head -n 1)

if [ -n "$DEVICE" ]; then
  echo "🖱 Найден тачпад: $DEVICE"
  xinput set-prop "$DEVICE" "libinput Scrolling Pixel Distance" 50
  xinput set-prop "$DEVICE" "libinput Accel Speed" 0.3
  xinput set-prop "$DEVICE" "libinput Accel Profile Enabled" 1, 0, 0

  mkdir -p ~/.config/autostart
  cat > ~/.config/autostart/touchpad_smooth.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Touchpad Smooth Scroll
Exec=xinput set-prop "$DEVICE" "libinput Scrolling Pixel Distance" 50 && xinput set-prop "$DEVICE" "libinput Accel Speed" 0.3 && xinput set-prop "$DEVICE" "libinput Accel Profile Enabled" 1, 0, 0
X-GNOME-Autostart-enabled=true
EOF
  echo "✅ Плавная прокрутка добавлена в автозапуск"
else
  echo "⚠️ Тачпад Synaptics не найден. Пропускаем шаг."
fi

echo -e "\n⌨️ Настройка клавиатуры..."

sudo bash -c 'cat > /etc/default/keyboard <<EOF
XKBLAYOUT="us,ru"
XKBVARIANT=","engineer"
XKBOPTIONS="grp:alt_shift_toggle"
EOF'

sudo dpkg-reconfigure -f noninteractive keyboard-configuration >/dev/null 2>&1
sudo service keyboard-setup restart

echo -e "\n✅ Всё готово!"
echo " - Плавная прокрутка включена"
echo " - Раскладка Windows-стиля (us + русская инженерная)"
echo " - Переключение Alt+Shift"
echo "🎉 Наслаждайся комфортом ThinkPad на Kali!"
