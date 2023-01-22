import sys
import os
import subprocess

from openpype.pipeline import load


def open(filepath):
    """Open file with system default executable"""
    if sys.platform.startswith('darwin'):
        subprocess.call(('open', filepath))
    elif os.name == 'nt':
        os.startfile(filepath)
    elif os.name == 'posix':
        subprocess.call(('xdg-open', filepath))


class OpenFile(load.LoaderPlugin):
    """Open Image Sequence or Video with system default"""

    families = ["render2d"]
    representations = ["*"]

    label = "Open"
    order = -10
    icon = "play-circle"
    color = "orange"

    def load(self, context, name, namespace, data):

        path = self.fname
        if not os.path.exists(path):
            raise RuntimeError("File not found: {}".format(path))

        self.log.info("Opening : {}".format(path))
        open(path)


# Allow to open some review video files too. This is separate so we don't show
# "open" button for *all* review output files like thumbnails or images, etc.
class OpenVideoFile(OpenFile):
    """Open review video files"""

    label = "Open"
    families = ["review"]
    representations = ["h264_png", "h264_exr", "h264_tif", "h264_jpg"]
