## Motion

See in particular [Related Projects](https://github.com/Motion-Project/motion/wiki/Related-Projects).

## OSB Studio

https://obsproject.com/
https://github.com/jp9000/obs-studio/wiki/Install-Instructions#linux

I think we want resolution over color accuracy, which pushes us to either YU12
or YV12. I don't find YU12 ANYWHERE in my searching except here:

https://www.linuxtv.org/downloads/v4l-dvb-apis-old/re27.html

I think it just means the Y and U values are reversed in order in the way the
bytes are packed in (i.e., I think they are equivalent). **Since YV12 seems
more common, let's use that.**

### OBS uses ffmpeg

This setup doesn't seem to support VAAPI acceleration - so we may be stuck in software transcoding if we're using OBS. BUT, there are discussions of enabling VAAPI:

https://trac.ffmpeg.org/wiki/Hardware/VAAPI
https://gist.github.com/Brainiarc7/95c9338a737aa36d9bb2931bed379219

## QtCam

https://opensource.com/life/16/1/getting-started-qtcam-linux-webcam

## OpenMax is noted

It's another library

# Gnome stuff

## Cheese

https://wiki.gnome.org/Apps/Cheese/Tour

## Clutter

For making UIs in Gnome (may or may not make sense if we already depend on Gst):
https://blogs.gnome.org/clutter/

## Gstreamer

See extensive notes in other files
