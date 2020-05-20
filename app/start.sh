#!/bin/bash

# Enable Camera
modprobe bcm2835-v4l2 >/dev/null 2>&1 || true

# Start haproxy
service haproxy start >/dev/null 2>&1 || true

# Make sure mpjg-streamer can find the plugins
export LD_LIBRARY_PATH="/usr/src/app/mjpg-streamer/mjpg-streamer-experimental"

# picam
#input=${INPUT_PLUGIN:-"input_raspicam.so"}

# usb webcam
input=${INPUT_PLUGIN:-"input_uvc.so -n -f 10 -r 1280x720"}

output=${OUTPUT_PLUGIN:-"output_http.so -p 8085 -w /usr/local/share/mjpg-streamer/www"}

mjpg_streamer -i "$input" -o "$output" -b

# start Octoprint
octoprint serve --iknowwhatimdoing --port=5000 --basedir /data
