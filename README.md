# magnet2torrent

This little script will grab as many magnet links as you want from a text file, start downloading the meta data only and save it as a .torrent file.

Magnet links can be all in one line, or seperated by new lines.

If the magnet link contains a url encoded name it will be decoded and attached to the file, otherwise it'll just have the torrents hash as a name.

# Prerequisites

aria2 - Install with sudo apt install aria2

# Configuration

Edit the config part of the script.
file: location/name of the text file containing your magnet links.
folder: folder in which we want our torrents to end up (e.g. watching folder to automatically add torrents to client)
timeout: time until it stops trying to grab a magnet link.
errorLocation: error log location (for downloads that timed out)

# Usage

1. Fill textfile with magnet links
2. Execute Script

## Notes

This script will do one magnet link after the other, so older links  ~~might take aconsiderable amount of time until they're done~~ will timeout, they'll be written into the error log.

This script will remove each magnet link after it finished downloading, while it is downloading you can add new links with echo "magnet=?whatever" >> magnetlinks.txt.

This script will stop as soon as the textfile is empty.
