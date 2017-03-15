#!/bin/bash

# Name:        start-dev.sh
# Description: This script provides the mechanism for assigning the correct UID and GID for the web root files.
#              How does this work?
#                * Checks the webroot directories UID and GID
#                * Deletes existing users with the UID and GID
#                * Assigns these UID and GID ids to the www-data user and group

DIR="/data"
WWW_ID="33"
WWW_USER="www-data"
USER_ID=$(stat -c '%u' ${DIR})
GROUP_ID=$(stat -c '%g' ${DIR})

USER_ID_ASSIGNED=$(grep ":${USER_ID}:" /etc/passwd | grep -v ${WWW_USER} | wc -l)
if [ $USER_ID_ASSIGNED -gt 0 ]; then
  REMOVE_USER=$(grep ":${USER_ID}:" /etc/passwd | cut -d ':' -f 1)
  echo "Removing user $REMOVE_USER to make room for our new uid"
  userdel $REMOVE_USER
fi

GROUP_ID_ASSIGNED=$(grep ":${GROUP_ID}:" /etc/group | grep -v ${WWW_USER} | wc -l)
if [ $GROUP_ID_ASSIGNED -gt 0 ]; then
  REMOVE_GROUP=$(grep ":${GROUP_ID}:" /etc/group | cut -d ':' -f 1)
  echo "Removing group $REMOVE_GROUP to make room for our new gid"
  groupdel $REMOVE_GROUP
fi

sed -i "s/${WWW_ID}:${WWW_ID}/${USER_ID}:${GROUP_ID}/g" /etc/passwd
sed -i "s/${WWW_ID}/${GROUP_ID}/g" /etc/group

# Defer back to the parent containers script.
/usr/local/bin/start
