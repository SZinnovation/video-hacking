# This seems to use vaapi for decoding giving us just a little edge that we
# need to nail full frame rate

# -hwaccel vaapi -vaapi_device /dev/dri/renderD128 \

ffmpeg \
  -f v4l2 -framerate 30 -video_size hd720 -pixel_format yuv420p -i /dev/video0 output.avi
