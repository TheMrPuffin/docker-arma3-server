#!/bin/sh
echo "Initialisation script..."

/home/steam/steamcmd/steamcmd.sh +force_install_dir /home/steam/arma3/server +login $STEAM_USER $STEAM_PASSWORD +app_update 233780 +quit

echo "Finished Initialisation..."

if [ "$FILEMANAGER_ENABLED" = TRUE ]
then
  echo 'Generating password hash... from the env var of $FILEMANAGER_HASH...'
  $FILEMANAGER_HASH=$( mkpasswd $FILEMANAGER_PASSWORD -m bcrypt )
  echo "Starting filemanager webserver..."
  /home/steam/filebrowser -r /home/steam/arma3/server/ -d /home/steam/filebrowser.db -a 0.0.0.0 --password $FILEMANAGER_HASH &
fi

echo "Starting Arma 3 server..."

./arma3server_x64 -name="Dockerised Arma 3 Server" -profiles="/home/steam/arma3/server/configs/profiles/" -config="/home/steam/arma3/server.cfg" -port=2302 -world=empty

echo "Stopping Arma 3 server..."
