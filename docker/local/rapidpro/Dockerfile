FROM python:3
ENV PYTHONUNBUFFERED 1

WORKDIR /build

# apt dependencies
RUN apt-get update \
    && apt-get install -y --upgrade gdal-bin nodejs npm gettext \
    && rm -rf /var/lib/apt/lists/*

# pip requirements
COPY src/rapidpro/pip-freeze.txt ./requirements.txt
RUN pip install -r requirements.txt && pip install django-environ

# npm
RUN npm install -g less coffeescript

COPY docker/local/rapidpro/scripts/entrypoint /entrypoint
RUN sed -i 's/\r//' /entrypoint
RUN chmod +x /entrypoint

COPY docker/local/rapidpro/scripts/start /start
RUN sed -i 's/\r//' /start
RUN chmod +x /start

WORKDIR /app

ENTRYPOINT [ "/entrypoint" ]