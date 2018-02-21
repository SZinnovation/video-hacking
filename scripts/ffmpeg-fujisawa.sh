# Note that older versions of ffmpeg needed -strict -2 for aac support. This is
# no longer the case
ffmpeg -hwaccel cuvid \
  -f v4l2 -framerate 30 -video_size hd720 -input_format yuv420p \
  -thread_queue_size 1024 \
  -i /dev/video1 \
  -f alsa -thread_queue_size 1024 \
  -i hw:1 \
  -threads 4 \
  -acodec aac \
  -vcodec libx264 \
  -pix_fmt yuv420p \
  -preset veryfast \
  -t 40:00 \
  output.mp4
