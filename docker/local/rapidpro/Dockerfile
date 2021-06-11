FROM python:3.6-slim as build-poetry

WORKDIR /app

COPY src/rapidpro/pyproject.toml .
COPY src/rapidpro/poetry.lock .

RUN python -m pip install -U poetry
RUN poetry export --without-hashes --output requirements.txt


FROM python:3.6-slim
ENV PYTHONUNBUFFERED 1

WORKDIR /build

# apt dependencies
RUN apt-get update \
    && apt-get install -y --upgrade gdal-bin nodejs npm gettext \
    && rm -rf /var/lib/apt/lists/*

#install nodejs 15.x
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash - 
RUN apt-get install -y nodejs

# pip requirements
COPY --from=build-poetry /app/requirements.txt ./requirements.txt
RUN pip install -r requirements.txt


# # grpc requirements (we don't install rapidpro-apps locally)
RUN pip install \
        grpcio \
        grpcio-tools \
        djangogrpcframework
# template macros (weni-rp-templates)
RUN pip install django-templates-macros
# dev dependencies
# jedi 0.18 has a bug with ipython
RUN pip install jedi==0.17.2 ipython \
        django-environ ipdb django-extensions
# Connect/OIDC
RUN pip install mozilla-django-oidc django-csp
# push dependencies (docker/pip-freeze.txt)
RUN pip install django-environ==0.4.5 \
                elastic-apm==5.1.0 \
                sentry-sdk==0.10.2


# npm
RUN npm install -g less

COPY docker/local/rapidpro/scripts/entrypoint /entrypoint
RUN sed -i 's/\r//' /entrypoint
RUN chmod +x /entrypoint

COPY docker/local/rapidpro/scripts/start /start
RUN sed -i 's/\r//' /start
RUN chmod +x /start

WORKDIR /app

ENTRYPOINT [ "/entrypoint" ]