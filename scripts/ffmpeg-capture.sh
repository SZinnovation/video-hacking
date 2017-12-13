ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD128 \
  -f v4l2 -framerate 30 -video_size hd1080 -pixel_format yuv420p -i /dev/video0 output.mov
