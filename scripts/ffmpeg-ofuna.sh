# The only GPU in szproto is the integrated intel GPU (which is actually pretty
# good for video encoding, but folks claim that CPU encoding with x264 yeilds
# better quality, and is fast enough).

# Don't think I need this, but can supply right after hwaccel if needed
# -vaapi_device /dev/dri/renderD128 \

    # Removed from acodec section (for output)
# -strict -2 \

# This seems necessary but not sufficient for the XBox microphone
# -codec:a pcm_s32le \

ffmpeg -hwaccel vaapi \
  -f v4l2 -framerate 30 -video_size hd720 -input_format yuv420p \
  -thread_queue_size 1024 \
  -i /dev/video0 \
  -f alsa -thread_queue_size 1024 \
  -i hw:1 \
  -threads 4 \
  -codec:a aac \
  -codec:v libx264 \
  -pix_fmt yuv420p \
  -preset veryfast \
  -t 40:00 \
  output.mp4
