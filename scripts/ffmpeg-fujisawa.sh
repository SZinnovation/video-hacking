ffmpeg -hwaccel cuvid \
  -f v4l2 -framerate 30 -video_size hd720 -pixel_format yuv420p \
  -thread_queue_size 1024 \
  -i /dev/video1 \
  -f alsa -thread_queue_size 1024 \
  -i hw:4 \
  -threads 4 \
  -pix_fmt yuv420p \
  -acodec mp3 \
  -t 10 \
  output.mp4
