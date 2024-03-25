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
pip3 install --upgrade streamlink 2>&1 | grep -v -E '^WARNING.*'

# Quality no set implies twitch
if [ -z "$QUALITY" ]; then
	QUALITY="audio_only"
fi
# For youtube stream links set to: "480p"

#run
streamlink -l debug -O $STREAM_URL $QUALITY | ffmpeg -y -i - -vn -map 0 -codec:a libopus -vbr on -b:a 64000 -f ssegment -segment_list playlist.m3u8 -segment_list_flags +live -segment_time 10 out%04d.ts
