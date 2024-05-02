# Boilerplate main file
````python
#!/usr/bin/env python3
import logging

logging.basicConfig(level=logging.DEBUG,
                    style='{',
                    format='{asctime} [{levelname}] {message} ({name}:{module})',
                    handlers=[logging.StreamHandler()])

logger = logging.getLogger(__name__)

# Argparse http://kitakitsune.org/argparse_builder/

def main():
    print("hello world")


if __name__ == "__main__":
    main()

````

# Dates
````python
from datetime import datetime
current_date_local_tz = datetime.now().astimezone()
print(current_date_local_tz.strftime('%Y-%m-%dT%H:%M:%S.%f%z'))  # 2024-04-12T12:59:45.310264+0200
print(current_date_local_tz.strftime('%Y-%m-%d'))  # 2024-04-12
current_date_no_tz = datetime.now()  # please don't use
print(current_date_no_tz.strftime('%Y-%m-%dT%H:%M:%S.%f%z')) # 2024-04-12T12:59:45.310337
````
# JSON
````python
import json
with open('path_to_file/person.json', 'r') as f:
  data = json.load(f)
person = '{"name": "Bob", "languages": ["English", "French"]}'
person_dict = json.loads(person)
````
# Logging
````python
import logging
logger = logging.getLogger(__name__)

# if main file, basicConfig if lazy,
# https://docs.python.org/3/library/logging.config.html#configuration-dictionary-schema
logging.config.dictConfig(LOGGING_CONFIG)

#  or dictconfig
logging.basicConfig(level=logging.DEBUG,
                    style='{'
                    format='{asctime} [{levelname}] {message} ({name}:{module})',
                    handlers=[
                              # logging.FileHandler(f"{os.path.basename(__file__)}.log"),
                              logging.StreamHandler()
                              ])
logger.debug(f"Debug from {__name__})
````
* [https://gist.github.com/aldur/f356f245014523330a7070ab12bcfb1f](https://gist.github.com/aldur/f356f245014523330a7070ab12bcfb1f)

# HTTP server
Just serve cwd as webpage: `python3 -m http.server 9900`

Server for debugging incomming data:
````python
from http.server import BaseHTTPRequestHandler, HTTPServer
# pip install multipart  https://github.com/defnull/multipart
# NOT python3-multipart
import multipart as mp

class handler(BaseHTTPRequestHandler):
    def do_NOTHING(self):
        logger.debug(self.headers)
        self.send_response(201, 'No content')
        self.end_headers()

    def do_GET(self):
        self.do_NOTHING()

    def do_POST(self):
        self.do_NOTHING()
        if "Content-Type" in self.headers and  self.headers["Content-Type"].startswith("multipart/form-data; boundary="):
            boundary =  self.headers["Content-Type"].split("multipart/form-data; boundary=")[1]
            logger.debug("Boundary: %s", boundary)
            content_len = int(self.headers.get('Content-Length'))
            parsed = mp.MultipartParser(self.rfile, boundary, content_len)
            for part in parsed.parts():
                logger.debug(
                        "name:%s size:%s content_type:%s charset:%s %s:%s%s",
                        part.name,
                        part.size,
                        part.content_type,
                        part.charset,
                        "value" if not part.file else "file[:10]",
                        part.value if not part.file else (
                          ' '.join(
                                    ['0x' + format(byte, '02X')
                                    for byte in part.file.read(10)])),
                        '' if not part.file else f" filename:{part.filename}"
                )

with HTTPServer(('0.0.0.0', 8013), handler) as server:
    server.serve_forever()
````


# PIL fit text in image
````python
from PIL import Image, ImageDraw, ImageFont
import textwrap
import logging
import time
logging.basicConfig(level=logging.DEBUG,
                    style='{',
                    format='{asctime} [{levelname}] {message} ({name}:{module})',
                    handlers=[logging.StreamHandler()])

logger = logging.getLogger(__name__)
text_im = Image.new(
    "RGB",
    size=(630, 210), # w, h
    color="white",
)

draw = ImageDraw.Draw(text_im)
txt_oneline = "10/20/30pcs NdFeB Magnet Diametrically Magnetized Rod Diameter 6x2 mm Experiment Precision Instrumentation Magnets 6*2 mm"

def get_reaming_pixels(txt, text_im):
    fontsize = 1  # starting font size
    font = ImageFont.truetype("arial.ttf", fontsize)
    _, _, text_width, text_height = draw.textbbox((0, 0), txt, font=font)
    im_width, im_height = text_im.size
    while text_width < im_width and text_height < im_height*0.95:
        fontsize += 1
        font = ImageFont.truetype("arial.ttf", fontsize)
        _, _, text_width, text_height = draw.textbbox((0, 0), txt, font=font)

    fontsize -= 1
    font = ImageFont.truetype("arial.ttf", fontsize)
    _, _, text_width, text_height = draw.textbbox((0, 0), txt, font=font)
    return fontsize, text_width, text_height

im_width, im_height = text_im.size
best_font_size = -1
best_breaks = -1 
prev_remainder = -1

start_time = time.time()

# Loop over up to 15 text wrappings, find the image that has the least unuses pixels,
# and that textwrap can wrap the text for (no TypeError)
for breaks in range(1,15):
    try:
        txt = "\n".join(textwrap.wrap(txt_oneline, width=len(txt_oneline)/breaks))
    except TypeError:
        #logging.error("Gave up wrapping at %s breaks", breaks)
        break
    fontsize, w, h = get_reaming_pixels(txt, text_im)
    remainder = (im_width*im_height) - (w * h)
    if prev_remainder > -1:
        if remainder < prev_remainder:
            best_font_size = fontsize
            best_breaks = breaks
    else:
        best_font_size = fontsize
        best_breaks = breaks
    prev_remainder = remainder
    #logger.debug("Fontsize: %s (%s, %s), remainder: %s (lower is better)", fontsize, best_font_size, best_breaks, remainder)
print("--- %s seconds ---" % (time.time() - start_time))
font = ImageFont.truetype("arial.ttf", best_font_size)
txt = "\n".join(textwrap.wrap(txt_oneline, width=len(txt_oneline)/best_breaks))
_, _, text_width, text_height = draw.textbbox((0, 0), txt, font=font)
draw.text(((im_width-text_width)/2, (im_height-text_height)/2), txt, font=font, fill=(0, 0, 0)) # put the text on the image
text_im.show()
````
