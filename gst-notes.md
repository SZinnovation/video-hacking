# Somewhat from the following + StackOverflow + Mailing Lists
$ https://gstreamer.freedesktop.org/documentation/frequently-asked-questions/using.html

# Show a list of installed plugins
gst-inspect-1.0


# Play a stream to X11 window
gst-launch-1.0 v4l2src device=/dev/video0 ! 'video/x-raw, format=YUY2, width=1920, height=1080, framerate=30/1' ! videoconvert ! ximagesink

# Get the 4k stream
gst-launch-1.0 v4l2src device=/dev/video0 ! image/jpeg,width=3840,height=2160,framerate=30/1 ! \
  queue ! vaapijpegdec ! videoconvert ! queue ! autovideosink
