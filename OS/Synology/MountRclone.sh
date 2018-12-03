#!/bin/bash
#
# Environment 
# OS : Ubuntu 18.04 LTS
# Rclone Ver : v1.44
#
# Cron Use Exp
#   */5 * * * * /bin/bash /<path>/MountRclone.sh

# 2018-12-03
# Synology Root HomeDir : /root/
# Example : Rcloneconf="/root/.config/rclone/rclone.conf"

# 2018-12-03
# Add Synology(Combin Xpen) Chunk Option
# Example : ChunkPATH="/volume1/rclone.cache/.cache/rclone/cache-backend"

MountDir="/<yourpath>/cache"
RcloneConf="/<homedir>/.config/rclone/rclone.conf"
ChunkPATH="/<your_chunk_path>"

# Temp Is Check Directory. Not Over
if [ ! -d "$MountDir/Temp" ]; then
    rclone mount cache: "$MountDir" \
    --config "$RcloneConf" \
    --allow-non-empty --allow-other --read-only \
    --cache-dir "$ChunkPATH" \
    --cache-db-path "$ChunkPATH" \
    --cache-chunk-path "$ChunkPATH" \
    --uid <current_uid> --gid <current_gid> &
else
    echo "Pre Mounting"
fi
