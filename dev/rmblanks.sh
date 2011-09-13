#!/bin/sh

FILE=$1

# remove blanks
tmpfile=/tmp/tmp.g
sed -e 's/ //g' $FILE >> $tmpfile
mv $tmpfile $FILE
# gzip with highest compression
gzip -f -9 $FILE




