# Streamlink-audio-stream
This project aims to simplify serving just an high quality and low bandwidth audio stream from live Twitch (or other streamlink supported platforms). Twitch might serve audio_only streams, but their bandwidth is too high for some rural areas of germany.

## Setup
```
version: "3.6"

services:
  stream:
    build: .
    ports:
      - "8005:80"
    volumes:
      - "./dump:/usr/share/nginx/html"
    environment:
      - "STREAM_URL=https://www.twitch.tv/redbull"
```
### dump folder
ffmpeg creates 10s segemnts, which are served via nginx on the exposed port. If you'd like to preserve them, you can make it a volume as seen above.

## Usage

On the exposed port a playlist link is served. **Copy** that link and paste it to your favourite media player like vlc. **Don't** try saving it with your browser and playing it afterwards - It won't work.

## Modification

Chosen codec is opus at 64kbps, which still produces excellent quality at low bandwith. You might also go with HEIC AAC (libfdkaac), which is available through using precompiled binaries by jrottenberg.
