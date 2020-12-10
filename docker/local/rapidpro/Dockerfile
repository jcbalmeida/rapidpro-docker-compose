FROM python:3.6
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# apt dependencies
RUN apt-get update \
    && apt-get install -y --upgrade gdal-bin nodejs npm gettext \
    && rm -rf /var/lib/apt/lists/*

#install nodejs 15.x
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash - 
RUN apt-get install -y nodejs

# pip requirements
COPY src/rapidpro/pip-freeze.txt ./requirements.txt
RUN pip install -r requirements.txt && \
    # dev extensions
    pip install django-environ ipdb django-extensions  

# npm
COPY src/rapidpro/package.json src/rapidpro/package-lock.json ./
RUN npm install -g less coffeescript && npm ci

COPY docker/local/rapidpro/scripts/entrypoint /entrypoint
RUN sed -i 's/\r//' /entrypoint
RUN chmod +x /entrypoint

COPY docker/local/rapidpro/scripts/start /start
RUN sed -i 's/\r//' /start
RUN chmod +x /start

WORKDIR /app

ENTRYPOINT [ "/entrypoint" ]