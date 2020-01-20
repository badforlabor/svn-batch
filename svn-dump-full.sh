#!/bin/sh
##Subversion decritory and file
SVN_HOME=/usr/bin/  
SVN_ADMIN=$SVN_HOME/svnadmin  
SVN_LOOK=$SVN_HOME/svnlook

SVN_REPOROOT=/data/svnroot/repository                    

#backup file path
date=$(date '+%Y-%m-%d')  
RAR_STORE=/data/svnbackup/full/$date  
if [ ! -d "$RAR_STORE" ];then  
mkdir -p $RAR_STORE  
fi

cd $SVN_REPOROOT  
#Projectname 指库名
for name in $(ls|grep Projectname)  
do  
$SVN_ADMIN dump $SVN_REPOROOT/$name > $RAR_STORE/full.$name.bak
done  