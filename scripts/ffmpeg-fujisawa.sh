ffmpeg -hwaccel cuvid \
  -f v4l2 -framerate 30 -video_size hd720 -input_format yuv420p \
  -thread_queue_size 1024 \
  -i /dev/video1 \
  -f alsa -thread_queue_size 1024 \
  -i hw:4 \
  -threads 4 \
  -acodec aac -strict -2 \
  -vcodec libx264 \
  -pix_fmt yuv420p \
  -preset veryfast \
  -t 10 \
  output.mp4
