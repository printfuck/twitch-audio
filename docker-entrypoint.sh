#!/bin/sh

if [ -z "$STREAM_URL" ]; then
	echo "No Twitch URL provided, exiting";
	exit 0;
fi

# Run nginx
nginx 

#delete old files
rm /usr/share/nginx/html/*;
cp /index.html /usr/share/nginx/html/

#upgrade streamlink because of volatile apis
pip install --upgrade streamlink 2>&1 | grep -v -E '^WARNING.*'

#run
streamlink -l debug --twitch-disable-ads -O $STREAM_URL audio_only | ffmpeg -y -i - -map 0 -codec:a libopus -vbr on -b:a 64000 -f ssegment -segment_list playlist.m3u8 -segment_list_flags +live -segment_time 10 out%04d.ts
