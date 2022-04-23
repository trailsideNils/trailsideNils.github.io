#!/bin/bash

function check_github()
{
    command git --version
    if [ $? -ne 0 ]
    #github not installed
    then
        read -p 'You do not have Github Terminal installed, but this program requires it to function. Would you like to do so now? [y/n] ' INSTALLCONFIRM
        
#installing github
        if [ $INSTALLCONFIRM = "y" ]
        then
            command curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
            command sudo apt update
            command sudo apt install gh
        fi
    #else github is installed
    fi
}

function setup()
{
    echo 'Attempting to install utility libQRencode...'
    sudo apt-get install qrencode 

#logging in if not already
    gh auth status || gh auth login
    read -p 'Please enter your Github username: ' USERNAME
#the repository
    git init QR-repo/
    echo $USERNAME > $PWD/QR-repo/user.txt
}

check_github
setup
mv $PWD/qr.sh $PWD/QR-repo
cd $PWD/QR-repo
echo "The script ./qr.sh is now capable of pushing files to git and generating QR codes that can easily be sent in the files' stead."
rm $PWD/initialize.sh