#!/bin/bash
# ThinkPad T480 Comfort Setup for Kali XFCE
# Author: Nikita (full-stackmycologist)

# Цвета
PINK="\e[95m"
CYAN="\e[36m"
RESET="\e[0m"

clear

# --- Анимация мигания ---
for i in 1 2 3; do
  clear
  echo -e "${PINK}"
  cat <<'EOF'
          ／⌒ヽ
        （｡・-・｡)  
       ⊂(   つ🍵つ       
        ｜   _つ💻_つ     
        `しし′
EOF
  echo -e "${RESET}"
  sleep 0.25
  clear
  echo -e "${PINK}"
  cat <<'EOF'
          ／⌒ヽ
        （－﹏－） < zzz...
       ⊂(   つ🍵つ       
        ｜   _つ💻_つ     
        `しし′
EOF
  echo -e "${RESET}"
  sleep 0.25
done

clear
echo -e "${PINK}"
cat <<'EOF'
          ／⌒ヽ
        （｡・‿・｡)  <  Хай, Никита~!
       ⊂(   つ🍵つ       Я — чиби-тян!
        ｜   _つ💻_つ     Настраиваю твой ThinkPad ❤️
        `しし′

       ✿･ﾟ:* ｡ﾟ･ﾟ*.｡ﾟ･ﾟ✿･ﾟ:*｡ﾟ･ﾟ*.｡ﾟ･ﾟ✿
EOF
echo -e "${RESET}"

sleep 0.6
echo -e "${CYAN}💬  Готовлю комфортную среду под твой ThinkPad T480...${RESET}"
sleep 1
echo ""

# --- Настройка тачпада ---
DEVICE=$(xinput list --name-only | grep -i "synaptics" | head -n 1)

if [ -n "$DEVICE" ]; then
  echo "🖱 Найден тачпад: $DEVICE"
  xinput set-prop "$DEVICE" "libinput Scrolling Pixel Distance" 50
  xinput set-prop "$DEVICE" "libinput Accel Speed" 0.3
  xinput set-prop "$DEVICE" "libinput Accel Profile Enabled" 1, 0, 0

  mkdir -p ~/.config/autostart
  cat > ~/.config/autostart/touchpad_smooth.desktop <<EOF2
[Desktop Entry]
Type=Application
Name=Touchpad Smooth Scroll
Exec=xinput set-prop "$DEVICE" "libinput Scrolling Pixel Distance" 50 && xinput set-prop "$DEVICE" "libinput Accel Speed" 0.3 && xinput set-prop "$DEVICE" "libinput Accel Profile Enabled" 1, 0, 0
X-GNOME-Autostart-enabled=true
EOF2
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

echo ""
echo -e "${PINK}✨ Всё готово, семпай! ✨${RESET}"
echo -e "${CYAN}— Плавная прокрутка активна${RESET}"
echo -e "${CYAN}— Раскладка Windows-стиля (us + русская инженерная)${RESET}"
echo -e "${CYAN}— Переключение Alt+Shift${RESET}"
echo ""
echo -e "${PINK}💖 Чиби-тян говорит: «Мягкий скролл и быстрая клавиатура — идеал!»${RESET}"
