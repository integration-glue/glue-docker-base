FROM python:3.11-slim as python-runtime

RUN python --version && pip --version
RUN echo "deb http://archive.debian.org/debian buster-backports main " >> /etc/apt/sources.list.d/backports.list \
    && apt-get update && apt-get install -y ca-certificates curl gnupg apt-utils build-essential \
	  && apt-get install -y -t buster-backports openssl libssl-dev python3-dev libev-dev \
	  && apt-get install -y gcc gettext-base jq \
    && rm -rf /root/.cache/  \
	  && rm -rf /var/lib/apt/lists/*

WORKDIR '/app'
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt  && rm -rf /root/.cache/ && rm -rf requirements.txt
