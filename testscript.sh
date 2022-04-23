function check_github()
{
#the check
    command git --version
    if [ $? -ne 0 ] #github not installed
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

check_github
gh auth status || USERNAME=`gh auth login`
echo $USERNAME
