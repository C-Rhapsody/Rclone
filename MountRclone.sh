#!/bin/bash
#
# Environment 
# OS : Ubuntu 18.04 LTS
# Rclone Ver : v1.44
#
# Cron Use Exp
#   */5 * * * * /bin/bash /<path>/MountRclone.sh

MountDir="/home/<username>/rclone/cache/"
RcloneConf="/home/<username>/.config/rclone/rclone.conf"

if [ ! -d "$MountDir/Temp" ]; then
    rclone mount cache: "$MountDir" \
    --config "$RcloneConf" \
    --allow-non-empty --allow-other --read-only \
    --uid <current_uid> --gid <current_gid> &
else
    echo "Pre Mounting"
fi
