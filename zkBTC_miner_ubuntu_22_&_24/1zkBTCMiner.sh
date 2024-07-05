#!/usr/bin/env bash

if ! command -v curl &> /dev/null
then
    echo "curl is not found or not installed."
    sudo apt install -y curl
else
    echo "curl is already installed."
fi

#Check for dotnet
if ! command -v dotnet &> /dev/null
then
    echo "dotnet 5.0 is not found or not installed."
    echo "Installing dotnet 5.0..."
    
    # Update and upgrade system
    sudo apt update && sudo apt upgrade -y
    sudo apt install build-essential cmake git -y
    curl 'http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1-1ubuntu2.1~18.04.23_amd64.deb' -O
    sudo dpkg -i libssl1.1_1.1.1-1ubuntu2.1~18.04.23_amd64.deb 
    curl 'https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb' -O
    sudo dpkg -i packages-microsoft-prod.deb
    sudo apt update
    sudo apt install -y dotnet-sdk-5.0

    # Verify the installation
    dotnet --version

    echo "dotnet 5.0 is installed. Rerun the script to start."

    goto end
else
    echo "dotnet 5.0 is already installed."
fi




if ! dpkg-query -W -f='${Status}' ubuntu-drivers-common 2>/dev/null | grep -q "ok installed"; then
    echo "ubuntu-drivers is not installed. Reboot system after fresh install"
    sudo apt-get update
    sudo apt-get install -y ubuntu-drivers-common
    sudo ubuntu-drivers autoinstall
    sudo reboot
else
    echo "ubuntu-drivers is already installed."
fi
# Optionally, you can also run the autoinstall command after checking
#sudo ubuntu-drivers autoinstall

while : ; do
  output=$(dotnet _zkBitcoinMiner.dll allowCPU=false allowIntel=true allowAMD=true pool=http://pool.zkbitcoin.org:6122 minerAddress=0xF8B99643fAfC79d9404DE68E48C4D49a3936f78 allowCUDA=true web3api=https://mainnet.era.zksync.io abiFile=zkBTC.abi contract=0x366d17aDB24A7654DbE82e79F85F9Cb03c03cD0D MaxZKBTCperMint=200 MinZKBTCperMint=150 HowManyBlocksAWAYFromAdjustmentToSendMinimumZKBTC=500 gasToMine=0.35 gasApiMax=1 gasLimit=1000000 gasApiURL= gasApiPath=$.safeLow gasApiMultiplier=0.1 gasApiOffset=1.0 2>&1 | tee /dev/tty)
  [[ $? -eq 22 ]] || break
done

if [[ "$output" == *"CUDA driver version is insufficient"* ]]; then
  echo "Error: Cuda driver version is insufficient for Cuda runtime version."
  echo "ubuntu-drivers is not installed. Reboot system after fresh install"
  sudo apt-get update
  sudo apt-get install -y ubuntu-drivers-common
  sudo ubuntu-drivers autoinstall
  echo "We installed drivers waiting 10 seconds then rebooting machine"
  sleep 10
  sudo reboot
else
  echo "Output says cuda driver version is okay"
  echo "$output"
fi
