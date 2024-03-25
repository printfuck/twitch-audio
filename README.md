# Streamlink-audio-stream
This project should enable everyone to get an audio stream via streamlink and its supported platforms as fast as possible.

## Setup
```
version: "3.6"

services:
  stream:
    image: pkill/twitch-audio
    ports:
      - "8000:80"
    volumes:
      - "./dump:/usr/share/nginx/html"
    environment:
      # LoFi Girl
      - "STREAM_URL=https://www.youtube.com/watch?v=jfKfPfyJRdk"
      - "QUALITY=480p"      
```
### dump folder
ffmpeg creates 10s segemnts, which are served via nginx on the exposed port. If you'd like to preserve them, you can make it a volume as seen above.

## Usage

On the exposed port a playlist link is served. **Copy** that link and paste it to your favourite media player like vlc. **Don't** try saving it with your browser and playing it afterwards - It won't work.

## Modification

Chosen codec is opus at 64kbps, which still produces excellent quality at low bandwith. You might also go with HE-AAC(v1/v2) (libfdkaac), which is available through using precompiled binaries by jrottenberg.
