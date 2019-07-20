Git cheatsheet 

# Git env setup

Setup the env for the first time use

-Your identity

    git config --global user.name ¡°Your name here¡±
    git config --global user.email you@Xilinx.com 

-Preferred editor

    git config --global core.editor "'C:/Program Files (x86)/Notepad++/notepad++.exe' -multiInst -nosession¡°

-Checking your settings

    git config --list

# Create repository on server

    git init --bare --shared project.git
