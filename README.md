# Streamlink-audio-stream
Twitch **doesn't serve** an **audio-only API** for developers at all. They are currently offering the audio-only feature only inside their app. This project should enable everyone to get an audio stream as fast as possible, without using the twitch-proprietary app environment.

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
      - "STREAM_URL=https://www.twitch.tv/maty"
```
### dump folder
ffmpeg creates 10s segemnts, which are served via nginx on the exposed port. If you'd like to preserve them, you can make it a volume as seen above.

## Usage

On the exposed port a playlist link is served. **Copy** that link and paste it to your favourite media player like vlc. **Don't** try saving it with your browser and playing it afterwards - It won't work.

## Modification

Chosen codec is opus at 64kbps, which still produces excellent quality at low bandwith. You might also go with HE-AAC(v1/v2) (libfdkaac), which is available through using precompiled binaries by jrottenberg.
