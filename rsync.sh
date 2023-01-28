#!/bin/bash

#rsync -auzP --delete --exclude="./.rsync-filter " remote:Documents/ .

while true; do
    inotifywait -r -e modify,attrib,move,create,delete /home/wang/Documents/
    sleep 1
    rsync -auzP --delete --max-size=100k . remote:Documents/
done

