# ubuntu-22-24-Miner
A GPU miner for Ubuntu 22 &amp; 24
# Installing Script on Ubuntu 22 & 24 
please see other repsoitory for Ubuntu 18 & 20

Go to download Folder and
run 'sh install-deps.sh' to install dependencies.

sudo apt install build-essential

sudo apt install pkg-config libglvnd-dev

Download your graphics card driver
https://www.nvidia.com/download/index.aspx

sudo sh NVIDIA-Linux-x86_64-525.60.11.run

For NOUVEAU ERROR
https://askubuntu.com/questions/841876/how-to-disable-nouveau-kernel-driver


IF SCREEN RESOLUTION IS MESSED UP DO next two steps
1) sudo nvidia-xconfig

2) https://askubuntu.com/questions/441040/failed-to-get-size-of-gamma-for-output-default-when-trying-to-add-new-screen-res
Go to Downloaded Folder and Open Terminal


TO RUN SCRIPT OPEN TERMINAL IN FOLDER AND TYPE

chmod u+x 1zkBTCMiner.sh  or right click the file -> Properities -> Permissions and check "Allow executing file as Program"



chmod u+x 1zkBTCMiner.sh or right click the file -> Properities -> Permissions and check "Allow executing file as Program"

./1zkBTCMiner.sh

to run the miner

or

./1zkBTCMiner.sh

Mines normally using your eth account to mint the tokens

It should run!

Edit the 1zkBTCMiner.sh file and _zkBitcoinMiner.conf to edit your settings

