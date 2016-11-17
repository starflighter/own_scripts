#deletes all files with an time older 7 days on the given path

find /home/pi/Freigabe_AccessLog -ctime +7 -exec rm {} \;
