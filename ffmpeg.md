# Docs here:
# https://trac.ffmpeg.org/wiki/Capture/Webcam

Looks like maybe FFmpeg is the only thing that readily lets me capture via
command line without X and using hardware rendering...

# Enable hardware rendering

At least for Intel/AMD GPUs, this page has good info:

https://trac.ffmpeg.org/wiki/Hardware/VAAPI

We need to initialize a device like so:

  ffmpeg -init_hw_device vaapi=intel:/dev/dri/renderD128

Except that's not a recognized option in FFmpeg 3.3?

This works, docs had -hwaccel_device, but that doesn't use the VAAPI HW accel.
-vaapi_device seems to register, and is faster, but not significantly faster
like gstreamer (and intel_gpu_top remains flat):

  ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD128 \
    -f v4l2 -framerate 30 -video_size hd1080 -pixel_format yuv420p -i /dev/video0 \
    -c:v libx264 -pix_fmt yuv420p output.mp4

Or a similar command with VDPAU (also specifying an mjpeg stream), added the
superfast option and dropped a seemingly superfluous -pix_fmt argument.

 ffmpeg -hwaccel vdpau -f v4l2 -framerate 30 -video_size hd1080 -input_format mjpeg -i /dev/video0
    -c:v libx264 -preset superfast output.mp4

This is a full pipeline trying to do hwaccel'd transcoding, but it doesn't work
yet. We'll stick with the above for now.

  ffmpeg -hwaccel vaapi -hwaccel_output_format vaapi -hwaccel_device /dev/dri/renderD128 \
    # -i input.mp4 \
    -f v4l2 -framerate 30 -video_size hd1080 -pixel_format yuv420p -i /dev/video0 \
    -c:v h264_vaapi output.mov

Turns out maybe I just shouldn't do this..."In general, all the hardware h.264
encoders deliver lower quality than x264 (at a given bitrate). And x264 at the
"veryfast" preset is almost as fast as the hardware encoders and still delivers
better quality."

We need to convert existing mkv files to mp4 to play in browsers, e.g.:

ffmpeg -i my_video-10.mkv -c:v libx264 -c:a mp3 -movflags faststart my_video-10-conv.mp4
