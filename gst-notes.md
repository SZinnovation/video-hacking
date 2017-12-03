# Somewhat from the following + StackOverflow + Mailing Lists
$ https://gstreamer.freedesktop.org/documentation/frequently-asked-questions/using.html

# Show a list of installed plugins
gst-inspect-1.0

# Play a stream to X11 window
gst-launch-1.0 v4l2src device=/dev/video0 ! 'video/x-raw, format=YUY2, width=1920, height=1080, framerate=30/1' ! videoconvert ! ximagesink

# Get the 4k stream
gst-launch-1.0 v4l2src device=/dev/video0 ! image/jpeg,width=3840,height=2160,framerate=30/1 ! \
  queue ! vaapijpegdec ! videoconvert ! queue ! autovideosink

# Write 4k stream to disk
gst-launch-1.0 -e v4l2src device=/dev/video0 ! \
  image/jpeg,width=3840,height=2160,framerate=30/1 ! queue ! \
  vaapijpegdec ! videoconvert ! queue ! \
  vaapih264enc dct8x8=true ! h264parse ! queue ! \
  qtmux name=muxer muxer. ! progressreport name=Rec_time ! \
  filesink location=gstreamer-test-video.mp4

# Write a stream - maxbitrate is 0 by default!
.\gst-launch-1.0.exe -e autovideosrc ! videoconvert ! openh264enc max-bitrate=256000 ! h264parse ! \
  mp4mux ! filesink location=somefile.mp4


# On windows at least, can use
gst-launch-1.0 autovideosrc ! autovideosink

# Encode the screen to x.264
gst-launch-1.0 -e ximagesrc display-name=:0 use-damage=0 startx=1920 starty=0 endx=$((1920+2560-1)) endy=1439 !\
    multiqueue ! video/x-raw,format=BGRx,framerate=60/1 ! videoconvert ! video/x-raw,format=I420,framerate=60/1 !\
    multiqueue ! vaapih264enc dct8x8=true ! h264parse ! multiqueue ! matroskamux name=muxer muxer. ! progressreport name=Rec_time !\
    filesink location=/tmp/gstreamer-video.mkv

# See also gst.py!

# Other python examples:
# https://blogs.gnome.org/uraeus/2012/11/08/gstreamer-python-and-videomixing/
# https://brettviren.github.io/pygst-tutorial-org/pygst-tutorial.html

# Random notes:
# OpenMax is something Gstreamer can use (maybe also other approaches)

# YouTube recommended bitrates, etc:
# https://support.google.com/youtube/answer/1722171?hl=en
