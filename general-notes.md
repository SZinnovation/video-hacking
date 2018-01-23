Linux support for UVC 1.5 is likely still spotty. While I get full support for
the brio on the NUC USB-A ports, the USB-C port gives me trouble with greatly
reduced bandwidth modes (despite actually higher bandwidth on the port!). For
example, only 5 fps on 1080p vs. 30 frames for raw video (can get 30 fps on
mjpeg, though). The best way to look at modes for now seems to be:

v4l2-ctl --list-formats-ext

Or actually, this is much more concise (but without framerate):

ffmpeg -f v4l2 -list_formats all -i /dev/video0

Writing this up helped me figure out that a USB-A to USB-C converter cable
actually fixes the issue!
