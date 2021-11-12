Git cheatsheet 

# Git env setup

Setup the env for the first time use

## Your identity

    git config --global user.name Your name here
    git config --global user.email you@Xilinx.com 

## Preferred editor

    git config --global core.editor "'C:/Program Files (x86)/Notepad++/notepad++.exe' -multiInst -nosession¡°

## Checking your settings

    git config --list
	
## setup external diff tools for git
    $git config diff.tool meld
    $git config --global difftool.prompt false
    $git difftool	
	
# git merge tools
	git config --global --add merge.tool meld
	git config --global --add mergetool.prompt false
	
	git merge branch
	git mergetool 	

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
Create your initial "snapshot"

    git commit -a –m "some information"
	
Link the local repository to remote repository

	git remote add origin URL(/opt/gitroot/project.git)
	
SSH server
	username@srv/home/git/root
	ssh://username@srv:port/path
	
Change the remote name
	git remote set-url name new_url
	git remote rename old new
	
Push the local repository to remote repository

	git push origin master
	
#  work with remote repo
	git remote -v		;display remote repo
	git remote add pb https://github.com/paulboone/ticgit
	
	git fetch <remote>	;pull down new data from remote to local repo
	git pull <remote> 	;If your current branch is set up to track a remote branch,
						;this will fetch and merge automatically
	
	git push <remote> <branch>
	git remove show <remote>    ;show default pull/push tracked local branch
	
	git remote set-url origin https://username:PAT@github.com/Jonathanga
o/scripts

# push local branch to remote branch with different name
	git push origin local-name:remote-name

# clone from another client

	git clone URL(/opt/gitroot/project.git)
	git clone ssh://jung@xnjws1/opt/ip_repo/bf_ifft_demo.git
	
	
# Branch management
    git branch -a			;list all branches
	git branch -D   		;deletedbranches
	git push origin --delete branch_name  ;delte remote branch
	git checkout    		;branch-name
	git checkout -b master remotes/GE/master
	git merge other_branch	;merge other_branch to current branch
	
	git branch -vv			;get branch infor of where is coming from
	
## checkout from remote repo
	git checkout -b serverfix origin/serverfix
	
## link local branch with remote branch
	git branch -u origin/serverfix
	git branch -vv			;check tracking status
	
## change the branch 
	git checkout branch_name
	git branch -a 	;show all branches	
## rename branch

	git checkout old_branch
	git branch -m new_branch		
	git push origin new_branch
	git push origin --delete old_branch
	
## get files from different branch	
	git checkout branch_name file_name
	git checkout remotes/origin/20.1_v++ ./main.cpp
	
# Other usefull command
Show current status:

	git status -s
	git status --untracked-files=no  
	

# Create Archive without .git directory
execute in the git project root directory
	git archive -o relase.zip HEAD

# rename the managed file
    git mv old_name new_name
	
# remove tracked files	
	git rm files
	
# untrack files
# you don't want to remove files from harddisk. Just to fix
# some files you added accidently

	git rm --cached README
	
# tag managment
	git tag -a v1.1 -m "my versin"	#create tag
	git push origin --tags			#sync up the tag to remote server
	git diff v01 v02				#compare differences between two tags
	git tag							#list all tags
	
# clean untracked files
	git clean -i  #interact with deleted file
	git clean -n  #see what will be remove
	git clean -d -f #remove directories

# Undoing things with 	

## adding files to single commit
	git commit --amend	

## Unstaging a Staged File
	git reset HEAD file_name    ;file will not changed but just removed from previous staged files
	
## unmodify a modified file
	git checkout file_name 		;this will remove your local copy of modified files
	git checkout -- . 			;drop all the local changes
	git checkout -- file_name
	
## revert to previous commit
	git revert HEAD
	




   
# check the file history
	git log ./file_name
	git log --name-only 		;display files have been changed
	git log -p 					;display differences of content

	git log --stat 				;display files and high level changes
	git log --pretty=oneline	;display one line of each commit
	
	git log --pretty=format:"%h - %an, %ar : %s" ;display name; time
#show all the branch in graph mode	
	
	git log --oneline --decorate --graph --all 

# Skipping the Staging Area


# this will commit modified files and add automatically
	git commit -a -m "asdfasdf" 
	
# diff changes 

	git difftool commit_hash file_name
	git diff --name-status 		;display only changed files
	git diff branch_a..remotes/origin/branch_2 --name-status
	
## diff will compare the unstaged files from commited files
	git diff --staged			;compare stagged files with commit
	
##compare specific files in two diffrent branch
	git diff master..20.1_v++ -- Makefile
	git ..20.1_v++ 				;compare checkout one from another
	
# show the updated files from one commit 
    git show --pretty="" --name-only e64f309a	;e64f309a is beginning strings

# git stash
	
	git stash		;store your staged and unstaged files
	git stash pop 	;pop and clean stashed files
	git stash apply	;apply and save for next time use
	
	
	