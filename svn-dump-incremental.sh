#!/bin/sh
##Subversion decritory and file
SVN_HOME=/usr/bin/  
SVN_ADMIN=$SVN_HOME/svnadmin  
SVN_LOOK=$SVN_HOME/svnlook

SVN_REPOROOT=/data/svnroot

#backup file path
date=$(date '+%Y-%m-%d')  
#RAR_STORE=/data/svnbackup/incremental/$date  
RAR_STORE=/data/svnbackup/incremental
if [ ! -d "$RAR_STORE" ];then  
mkdir -p $RAR_STORE  
fi

#log file path
Log_PATH=/data/svnbackup/log  
if [ ! -d "$Log_PATH" ];then  
mkdir -p $Log_PATH  
fi

#read repo list
cd $SVN_REPOROOT  
#Projectname 指库名
for name in $(ls) 
#if [ -d "$name" ]; then

do  
if [ ! -d "$RAR_STORE/$name" ];then  
mkdir $RAR_STORE/$name  
fi

cd $RAR_STORE/$name  
if [ ! -d "$Log_PATH/$name" ];then  
mkdir $Log_PATH/$name  
fi
echo $name
echo ******Starting backup from $date****** >> $Log_PATH/$name/$name.log  
echo ******svn repository $name startting to backup****** >> $Log_PATH/$name/$name.log  
$SVN_LOOK youngest $SVN_REPOROOT/$name > $Log_PATH/A.TMP
UPPER=`head -1 $Log_PATH/A.TMP`

NUM_LOWER=`head -1 $Log_PATH/$name/last_revision.txt`  
let LOWER="$NUM_LOWER+1"

if [ $UPPER -ge $LOWER ]; then
$SVN_ADMIN dump $SVN_REPOROOT/$name -r $LOWER:$UPPER --incremental > $RAR_STORE/$name/$name.$LOWER-$UPPER.dump
rm -f $Log_PATH/A.TMP  
echo $UPPER > $Log_PATH/$name/last_revision.txt  
echo ******This time we bakcup from $LOWER to $UPPER****** >> $Log_PATH/$name/$name.log  
echo ******Back up ended****** >> $Log_PATH/$name/$name.log  
fi

#fi
done 