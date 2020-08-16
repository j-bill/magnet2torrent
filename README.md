# magnet2torrent

This little script will grab as many magnet links as you want from a text file, start downloading the meta data only and save it as a .torrent file.

Magnet links can be all in one line, or seperated by new lines.

If the magnet link contains a url encoded name it will be decoded and attached to the file, otherwise it'll just have the torrents hash as a name.

# Prerequisites

aria2 - Install with sudo apt install aria2

# Configuration

There are only two variables in the shell script that need to be changed. "file" and "folder".
file: location/name of the text file containing your magnet links.
folder: folder in which you want to deposit the finished torrent files. **needs to exist**

# Usage

1. Fill textfile with magnet links
2. Execute Script

## Notes

This script will do one magnet link after the other, so older links might take a considerable amount of time until they're done.

This script will remove each magnet link after it finished downloading, while it is downloading you can add new links with echo "magnet=?whatever" >> magnetlinks.txt.

This script will stop as soon as the textfile is empty.
