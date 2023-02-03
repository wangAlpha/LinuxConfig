docker pull syncthing/syncthing;

sudo docker run -it -d -p 8384:8384 -p 22000:22000 \
    -v /storage/conf/syncthing:/home/liwang/syncthing/config \
    -v /storage/data/syncthing:/home/liwang/syncthing/data \
    syncthing/syncthing:latest
