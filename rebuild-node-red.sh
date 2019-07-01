set -eux

# Kill chromium to avoid swap
set +e
killall /usr/lib/chromium-browser/chromium-browser
set -e

# Prepare Node-RED home directory
set +e
mv ~/.node-red ~/.node-red.`date "+%Y%m%d-%H%M%S"`.bak
set -e
mkdir ~/.node-red
cd ~/.node-red

# Install Node-RED nodes
set +e
sudo apt-get install -y npm
sudo npm install -g npm
hash -r
set -e
npm install node-red-contrib-media-utils
npm install node-red-contrib-google-tts
npm install node-red-node-watson
npm install node-red-dashboard
sudo apt-get install -y python-picamera python3-picamera
npm install node-red-contrib-camerapi
npm install node-red-contrib-image-output
sudo apt-get install -y libasound2-dev
npm install node-red-contrib-speakerpi
npm install node-red-contrib-play-audio
npm install node-red-contrib-browser-utils
npm install node-red-node-base64
sudo apt-get install -y libopencv-dev
npm install node-red-contrib-opencv
npm install node-red-contrib-cognitive-services
npm install node-red-contrib-google-translate
npm install node-red-contrib-cloud-vision-api
npm install node-red-contrib-qrcode
npm install node-red-contrib-model-asset-exchange@0.2.0
npm install node-red-contrib-embedded-file
npm install node-red-contrib-hostip
npm install node-red-contrib-moment
npm install node-red-contrib-openjtalk
curl -L -O https://github.com/julius-speech/julius/archive/v4.5.zip
unzip v4.5.zip
cd julius-4.5
./configure
make
sudo make install
cd ..
rm -fr julius-4.5
rm v4.5.zip
npm install node-red-contrib-julius
cd node_modules/node-red-contrib-julius
npm run build

# Save sample Node-RED flow
cd ~/.node-red
curl -L -O https://raw.githubusercontent.com/tjbotfan/tjbotzero-raspbian/master/flows_raspberrypi.json

# Use stable version of Node-RED temporarily
sudo npm install -g --unsafe-perm node-red@0.19.4

# Show messages
set +x
echo "((L|o_o| < The installation process has been completed successfully!"
echo "((L|o_o| < After rebooting Raspberry Pi, you can use your TJBot."
