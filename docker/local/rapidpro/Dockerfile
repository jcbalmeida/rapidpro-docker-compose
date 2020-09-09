FROM python:3
ENV PYTHONUNBUFFERED 1

# apt dependencies
RUN apt-get update \
    && apt-get install -y gdal-bin nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# pip requirements
COPY requirements.txt ./
RUN pip install -r requirements.txt && pip install django-environ

# npm
WORKDIR /app
RUN npm install -g less coffeescript

COPY scripts/entrypoint /entrypoint
RUN sed -i 's/\r//' /entrypoint
RUN chmod +x /entrypoint

COPY scripts/start /start
RUN sed -i 's/\r//' /start
RUN chmod +x /start

WORKDIR /app

ENTRYPOINT [ "/entrypoint" ]