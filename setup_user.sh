# tmk_firmware with ChibiOS
cd && git clone https://github.com/tmk/tmk_keyboard.git
cd ~/tmk_keyboard/tmk_core/tool/chibios && git clone https://github.com/ChibiOS/ChibiOS.git
cd ~/tmk_keyboard/tmk_core/tool/chibios && git clone https://github.com/ChibiOS/ChibiOS-Contrib.git

# PJRC hid_listen
cd ~ && mkdir bin
cd /tmp && wget https://www.pjrc.com/teensy/hid_listen_1.01.zip && unzip hid_listen_1.01.zip && cd hid_listen && make && cp hid_listen ~/bin


