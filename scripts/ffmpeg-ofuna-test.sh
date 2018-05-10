#!/bin/bash

# A simpler / faster version of the ffmpeg-ofuma.sh script. See that one for more comments

dt=$(date +%Y%m%dT%H%M)
desc=${1:-unknown}

ffmpeg -hide_banner -nostats \
  -hwaccel vaapi \
  -f v4l2 -framerate 30 -video_size hd720 -input_format yuv420p \
  -thread_queue_size 1024 \
  -i /dev/video0 \
  -f pulse -thread_queue_size 1024 \
  -i 1 \
  -threads 4 \
  -codec:a aac \
  -codec:v libx264 \
  -preset faster \
  -crf 20 \
  -pix_fmt yuv420p \
  -t 5 \
  ${dt}-ofuna-${desc}-video0-alsa1-hd720.mp4
