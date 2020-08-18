FROM python:3.7.0-alpine

RUN apk add --update alpine-sdk postgresql-dev
COPY ./requirements.txt /opt/apps/api/requirements.txt
WORKDIR /opt/apps/api

RUN pip install -r requirements.txt

ENTRYPOINT [ "/bin/sh",  "-c" ]
