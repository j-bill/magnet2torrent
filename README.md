# magnet2torrent

This little script will grab as many magnet links as you want from a text file, start downloading the meta data only and save it as a .torrent file.

If the magnet link contains a url encoded name it will be decoded and attached to the file, otherwise it'll just have the torrents hash as a name.

Requires aria2 - install with sudo apt install aria2

*Edit the file and folder variables in the shell script to change the magnet link containing file and target folder.*

*Note: this script will do one magnet link after the other, so older links might take a considerable amount of time until they're done.*
