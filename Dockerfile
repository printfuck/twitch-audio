FROM jrottenberg/ffmpeg:snapshot-alpine as ffmpeg

FROM nginx:alpine

# Building ffmpeg hard. Copying it from jrottenberg is easy and faster than installing with apk.
COPY --from=ffmpeg /usr/local /usr/local

RUN apk add --update --no-cache libxslt-dev libxml2-dev gcc libc-dev python3 python3-dev libgomp && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip  2>&1 | grep -v -E '^WARNING.*'
RUN pip3 install --no-cache --upgrade pip setuptools  2>&1 | grep -v -E '^WARNING.*'
RUN pip3 install --no-cache streamlink   2>&1 | grep -v -E '^WARNING.*'
RUN apk del gcc libc-dev python3-dev libxslt-dev libxml2-dev

WORKDIR /usr/share/nginx/html

ADD docker-entrypoint.sh /
ADD index.html /

CMD ["/docker-entrypoint.sh","&&", "bash"]

