#!/bin/bash

# 更新系统包
sudo apt-get update
sudo apt-get upgrade -y

# 安装Python3和pip
sudo apt-get install -y python3 python3-pip

# 安装tkinter
sudo apt-get install -y python3-tk

# 安装Chrome浏览器
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f -y
rm google-chrome-stable_current_amd64.deb

# 安装Chrome驱动
CHROME_VERSION=$(google-chrome --version | cut -d ' ' -f3 | cut -d '.' -f1)
wget -N "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/$CHROME_VERSION.0.0/linux64/chromedriver-linux64.zip"
unzip chromedriver-linux64.zip
sudo mv chromedriver-linux64/chromedriver /usr/local/bin/
sudo chmod +x /usr/local/bin/chromedriver
rm -rf chromedriver-linux64.zip chromedriver-linux64

# 安装Python依赖
pip3 install selenium
pip3 install pyautogui
pip3 install pillow

cat > start_chrome_ubuntu.sh << 'EOL'
#!/bin/bash

# 直接启动新的Chrome实例
google-chrome --remote-debugging-port=9222 --user-data-dir="$HOME/chrome-debug" &

# 等待Chrome启动
sleep 1

echo "Chrome已启动，调试端口：9222"

EOL
# 设置启动脚本权限
chmod +x start_chrome_ubuntu.sh

echo "安装完成！请运行 ./start_chrome_ubuntu.sh 启动Chrome，然后运行 python3 crypto_trader.py 启动程序" 
