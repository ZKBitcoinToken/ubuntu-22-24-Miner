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


# Check for CUDA toolkit
if ! dpkg -l | grep -q cuda-toolkit-12-5; then
    echo "CUDA toolkit 12.5 is not found or not installed."
    curl -O 'https://developer.download.nvidia.com/compute/cuda/12.5.0/local_installers/cuda-repo-debian12-12-5-local_12.5.0-555.42.02-1_amd64.deb'
    sudo dpkg -i cuda-repo-debian12-12-5-local_12.5.0-555.42.02-1_amd64.deb
    sudo cp /var/cuda-repo-debian12-12-5-local/cuda-*-keyring.gpg /usr/share/keyrings/
    sudo add-apt-repository contrib
    sudo apt-get update
    sudo apt-get -y install cuda-toolkit-12-5

    # Verify the installation
    if dpkg -l | grep -q cuda-toolkit-12-5; then
        echo "CUDA toolkit 12.5 is installed."
    else
        echo "CUDA toolkit 12.5 installation failed."
        exit 1
    fi
else
    echo "CUDA toolkit 12.5 is already installed."
fi

if ! dpkg -l | grep -q ubuntu-drivers-common; then
    echo "ubuntu-drivers is not installed. Reboot system after fresh install"
    sudo apt-get update
    sudo ubuntu-drivers autoinstall
    sudo reboot
else
    echo "ubuntu-drivers is already installed."
fi

# Optionally, you can also run the autoinstall command after checking
#sudo ubuntu-drivers autoinstall

while : ; do
  dotnet _zkBitcoinMiner.dll allowCPU=false allowIntel=true allowAMD=true pool=http://pool.zkbitcoin.org:6122 minerAddress=0xF8B99643fAfC79d9404DE68E48C4D49a3936f78 allowCUDA=true web3api=https://mainnet.era.zksync.io abiFile=zkBTC.abi contract=0x366d17aDB24A7654DbE82e79F85F9Cb03c03cD0D MaxZKBTCperMint=200 MinZKBTCperMint=150 HowManyBlocksAWAYFromAdjustmentToSendMinimumZKBTC=500 gasToMine=0.35  gasApiMax=1 gasLimit=1000000 gasApiURL= gasApiPath=$.safeLow gasApiMultiplier=0.1 gasApiOffset=1.0
  [[ $? -eq 22 ]] || break
done
