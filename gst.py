# Totally untested! Mostly cribbed from:
# https://speakerdeck.com/nzpug/douglas-bagnall-multimedia-programming-using-gstreamer-and-of-course-python

import os
import gi
gi.require_version('Gst', '1.0')
from gi.repository import Gst Gobject

Gobject.threads_init()
Gst.init(None)

loop = GObject.MainLoop()

pipe_desc = ("filesrc name=src !"
             "oggdemux ! theoradec ! "
             "videoconvert ! ximagesink")
pipeline = Gst.parse_launch(pipe_desc)
filesrc = pipeline.get_by_name('src')
# maybe
pipeline.set_state(Gst.State.PLAYING)

loop.run()
