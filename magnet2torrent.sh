#! /bin/bash
#
# ---------------------------------------------------------------------------------
# Copyright (c) 2020 j-bill
# github.com/j-bill
# This file is part of "magnet2torrent" which is released under the MIT license.
# ---------------------------------------------------------------------------------

# file containing all magnet links, doesn't matter if they're all in one line, or each magnet link a line, or empty lines
file=magnetlinks.txt

# folder in which we want our torrents to end up (e.g. watching folder to automatically add torrents to client)
folder=./watching

# insearting a new line infront of every magnet link
sed -i $'s/magnet/\\\nmagnet/g' $file

#clean out working directory in case older torrents are stuck here
mv *.torrent $folder

# function to clean up torrent name - throws error but it works ¯\_(ツ)_/¯
function urlDecode() { : "${*//+/ }"; parsedString=$(echo -e "${_//%/\\x}"); }

if [ -s $file ]; then
	while [ -s $file ] ; do
		line=$(head -n 1 $file)
        	cutURI=$(echo $line | cut -d "=" -f 3 | cut -d "&" -f 1 )
        	urlDecode $cutURI
		aria2c --bt-metadata-only=true --bt-save-metadata=true --listen-port=6881 $line
        	if [ -z $parsedString ]; then
            		find . -maxdepth 1 -type f -name \*.torrent -exec mv {} $folder \;
        	else
            		find . -maxdepth 1 -type f -name \*.torrent -exec mv {} $folder/"$parsedString.torrent" \;
        	fi
	    	sed -i '1d' $file
	done
else 
	echo "$file has no content"
fi
