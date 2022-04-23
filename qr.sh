#!/bin/bash

if [ $# -eq 0 ]
then
	echo "Error: Insufficient arguments!"
	echo "Please supply: <file-path>"
	echo
	echo "Example: /folder/file.ext"
	exit 1

fi

if [ ! -f $1 ]
then
	echo "Error: $1 was not found."
	exit 1
else
	cp $1 $PWD
	FILEPATH=$1
	FILENAME=${FILEPATH##*/}
	FILENOEXT=${FILENAME%.*}
	USERFILE=$(head -n 1 $PWD/user.txt)

	qrencode -o $FILENOEXT.png https://www.github.com/$USERFILE/qr-repo/blob/master/$FILENAME
	mv "$FILENAME".png $PWD

	git add .
	git commit -m 'new file'
	git push
fi