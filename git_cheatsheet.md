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

# Create Empty repository on server

    git init --bare --shared project_name.git
	
# Create local repository

create a directory to store all files need version control

    cd project_root
    git init    	
	
Start tracking files

    git add *.v
    git add *.vhd
    git add --all
Create your initial “snapshot”:

    git commit -a –m "some information"
	
Link the local repository to remote repository

	git remote add origin URL(/opt/gitroot/project.git)
Push the local repository to remote repository

	git push origin master

# clone from another client
	git clone URL(/opt/gitroot/project.git)
	
# Other usefull command
Show current status:

	git status -s
	

# Create Archive without .git directory
execute in the git project root directory
	git archive -o relase.zip HEAD

# rename the managed file
    git mv old_name new_name
	
# tag managment
	git tag -a v1.1 -m "my versin"	#create tag
	git push origin --tags			#sync up the tag to remote server
	git diff v01 v02				#compare differences between two tags
	git tag							#list all tags
	
# clean untracked files
	git clean -i  #interact with deleted file
	git clean -n  #see what will be remove