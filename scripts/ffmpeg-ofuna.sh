#!/bin/bash

# The only GPU in szproto is the integrated intel GPU (which is actually pretty
# good for video encoding, but folks claim that CPU encoding with x264 yeilds
# better quality, and is fast enough).

# Note that I can't prevent dropped frames. And I get a lot of them. The video
# seems OK, though. I tried `-r 30` in the codec and it forced framerate to 30
# in the status for ffmpeg, but otherwise still had dropped frames.

# Don't think I need this, but can supply right after hwaccel if needed
# -vaapi_device /dev/dri/renderD128 \

# Removed from acodec section (for output) - no longer needed for aac on more
# recent versions of ffmpeg
# -strict -2 \

# I removed this to avoid the second pass at the end, so it doesn't take as
# long for ffmpeg to finalize:
# -movflags faststart \

# This seems necessary but not sufficient for the XBox microphone, which has 4
# channels. We should explore using two for one camera and two for the other!
# -codec:a pcm_s32le \

dt=$(date +%Y%m%dT%H%M)
desc=${1:-unknown}

ffmpeg -hwaccel vaapi \
  -f v4l2 -framerate 30 -video_size hd1080 -input_format yuv420p \
  -thread_queue_size 1024 \
  -i /dev/video0 \
  -f alsa -thread_queue_size 1024 \
  -i hw:1 \
  -threads 4 \
  -codec:a aac \
  -codec:v libx264 \
  -preset faster \
  -crf 20 \
  -pix_fmt yuv420p \
  -t 49:00 \
  ${dt}-ofuna-${desc}-video0-alsa1-hd1080.mp4
