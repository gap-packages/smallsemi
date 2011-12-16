#!/bin/bash

#17/03/08 JDM

VERS=$1
#filenameVERS=$2
DIR=/Users/jdm/Desktop/Maths/Computation/GAP/gapdev/4.0/pkg/smallsemi
cd $DIR

#update the version number and date in package info

sed -e '/Date/s/"[^"]*"//' PackageInfo.g > PackTmp 
	#delete between the "" in the Date line

sed -e "s/Date := /Date := \" $(date) \"/" PackTmp > PackageInfo.g 
	#insert the current date

sed -e "/^Version/s/\"[^\"]*\"/\"$VERS\"/" PackageInfo.g > PackTmp

mv PackTmp PackageInfo.g

cd $DIR
cp -r ../smallsemi /tmp
DIR=/tmp/smallsemi
cd $DIR

#zip and tar 

rm -rf .svn
rm -rf */.svn
rm -rf */*/.svn
rm -rf */*/*/.svn
rm -rf .DS_Store
rm -rf */.DS_Store
rm -rf */*/.DS_Store
rm -rf */*/*/.DS_Store
rm -rf dev
cd /tmp

tar -f smallsemi-$VERS.tar.gz -cz smallsemi
chmod a+rx smallsemi-$VERS.tar.gz
cp smallsemi-$VERS.tar.gz /Users/jdm/Desktop
cp smallsemi-$VERS.tar.gz /Users/jdm/Desktop/Maths/Computation/GAP/gapdev/4.0/pkg/smallsemi/dev/ARCHIVES
rm -r /tmp/smallsemi
rm smallsemi-$VERS.tar.gz
scp /Users/jdm/Desktop/smallsemi-$VERS.tar.gz jamesm@wedderburn.mcs.st-and.ac.uk:/user3/jamesm/public_html/smallsemi
ssh jamesm@wedderburn.mcs.st-and.ac.uk chmod a+rx /user3/jamesm/public_html/smallsemi/smallsemi-$VERS.tar.gz
