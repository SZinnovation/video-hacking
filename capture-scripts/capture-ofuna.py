#!/usr/bin/env python3

from subprocess import run
from toolz import interpose

def capture_vl42(device='/dev/video0', resolution='4k', outname=None,
                 duration=None):
    if outname is None:
        _, device_name = device.rsplit('/', 1)
        outname = 'gstreamer-{}.mp4'.format(device_name)
    if duration is not None:
        print('WARNING: duration not implemented!')
    gst_pieces = list(interpose('!',
            ['v4l2src device={}'.format(device),
             'image/jpeg,width=3840,height=2160,framerate=30/1',
             'queue',
             # 'vaapijpegdec',
             'jpegdec', 'videoconvert',
             'queue',
             # 'vaapih264enc dct8x8=true',
             'avenc_h264_omx', 'h264parse',
             'queue',
             'qtmux', 'progressreport',
             'filesink location={}'.format(outname)]))

    # I'd like to just pass a list to run, but I'm getting an error for some
    # reason
    gst_command = ' '.join(['gst-launch-1.0', '-e'] + gst_pieces)
    print(gst_command)
    run(gst_command, shell=True)

    # XXX not sure why this isn't working
    # run(['gst-launch-1.0', '-e'] + gst_pieces)

if __name__ == '__main__':
    # XXX Change this to argparse!
    from sys import argv

    capture_vl42(argv[1])
