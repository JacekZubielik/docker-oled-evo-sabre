FROM python:3.9.18-slim
#3.9-slim

LABEL image.authors="JacekZubielik" \
      title="oled-evo-sabre" \
      description="Docker OLED Control Configuration for Audiophonics EvoSabre DAC & LMS" \
      licenses="MIT" \
      image.url="ghcr.io/jacekzubielik/docker-oled-evo-sabre:main" \
      image.source="https://github.com/jacekzubielik/docker-oled-evo-sabre" \
      maintainer="JacekZubielik"

WORKDIR /app
COPY ./app /app

RUN \
      apt-get update \
      && apt-get install -y \
            telnet \
            build-essential \
      --no-install-recommends

RUN rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/*

RUN pip install --upgrade pip
RUN pip3 install -r requirements.txt
CMD ["sh", "-c", "python3 -u oled4docker.py MAC=$MAC OLED=$OLED LOGFILE=$LOGFILE LOCATION=$LOCATION LMSIP=$LMSIP"]