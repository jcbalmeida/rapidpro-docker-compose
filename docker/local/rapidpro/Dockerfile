FROM python:3
ENV PYTHONUNBUFFERED 1

# apt dependencies
RUN apt-get update \
    && apt-get install -y gdal-bin nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# pip requirements
COPY requirements.txt ./
RUN pip install -r requirements.txt

# npm
WORKDIR /app
COPY package.json .
RUN npm install && \
    npm install -g less coffeescript

# COPY scripts/install_geolibs /install_geolibs
# RUN sed -i 's/\r//' /install_geolibs
# RUN chmod +x /install_geolibs && /install_geolibs

COPY scripts/entrypoint /entrypoint
RUN sed -i 's/\r//' /entrypoint
RUN chmod +x /entrypoint

COPY scripts/start /start
RUN sed -i 's/\r//' /start
RUN chmod +x /start

WORKDIR /app

ENTRYPOINT [ "/entrypoint" ]