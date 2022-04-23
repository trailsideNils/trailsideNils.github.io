#!/bin/bash

if [ $# -eq 0 ]
then
	echo "Error: Insufficient arguments!"
	echo "Please supply: <file-path>"
	echo
	echo "Example: /folder/file.ext"
	exit 1

fi

if [ `ls $1` == '' ]
then
	echo "Error: $1 was not found."
	exit 1
else
	echo 'test'
	cp $1 $PWD
fi

USER=$(head -n 1 $PWD/user.txt)

qrencode https://www.github.com/$USER/QR-repo/blob/main/$1 $1.png

git add .
git commit -m 'new file'
git push