#! /bin/bash
#
# ---------------------------------------------------------------------------------
#   Copyright (c) 2020 j-bill
#   github.com/j-bill
#   This file is part of "magnet2torrent" which is released under the MIT license.
# ---------------------------------------------------------------------------------


# CONFIG
#############
# file containing all magnet links, doesn't matter if they're all in one line, or each magnet link a line, or empty lines
file=/mnt/hdd/magnetlinks.txt
# folder in which we want our torrents to end up (e.g. watching folder to automatically add torrents to client)
folder=/mnt/hdd/watching
# time until it stops trying to grab a magnet link.
timeout=60
# error log location (for downloads that timed out)
errorLocation=/mnt/hdd/errorLog.txt


# SCRIPT
############

# insert a new line infront of every magnet link
sed -i $'s/magnet/\\\nmagnet/g' $file

#clean out working directory in case older torrents are stuck here
mv *.torrent $folder

# function to clean up torrent name - throws error but it works ¯\_(ツ)_/¯
function urlDecode() { : "${*//+/ }"; parsedString=$(echo -e "${_//%/\\x}"); }

# if file isn't empty
if [ -s $file ]; then
    #while file isn't empty
    while [ -s $file ] ; do

        # grab first line in file
        line=$(head -n 1 $file)

        # check if line isn't empty
        if [[ $line == *"magnet"* ]] ; then

            # cut away hash and trackers
            cutURI=$(echo $line | cut -d "=" -f 3 | cut -d "&" -f 1 )

            # decode uri and make it look nice to save as name later
            urlDecode $cutURI

            # attempt to download
            aria2c --bt-metadata-only=true --bt-save-metadata=true --listen-port=6881 --bt-stop-timeout=$timeout $line

            # check if anything was downloaded
            check=`find . -maxdepth 1 -type f -name \*.torrent | wc -l`

            # if nothing was downloaded save the failed magnet link in extra text file
            if [ $check -eq 0 ] ; then
                echo $line >> $errorLocation
            else
                # check if there is a parsedString, use it to rename the torrentfile, else just move the file as is to the target location
                if [ ! -z $parsedString ]; then
                    find . -maxdepth 1 -type f -name \*.torrent -exec mv {} $folder/"$parsedString.torrent" \;
                else
                    find . -maxdepth 1 -type f -name \*.torrent -exec mv {} $folder \;
                fi
            fi
        fi

        # remove first line of file
        sed -i '1d' $file

    done
else
    echo "$file has no content"
fi
