FROM ubuntu:latest

# Enable add-apt-repository
RUN apt-get update \
    && apt-get install -y software-properties-common \ 
    && rm -rf /var/lib/apt/lists/*

# Install postgres
RUN apt-get update \
    && apt-get install -y wget \
    && sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && apt-get update \
    && apt-get -y install postgresql \
    && rm -rf /var/lib/apt/lists/*

# Install GIT
RUN add-apt-repository -y ppa:git-core/ppa \
    && apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

# Install Python 3
RUN add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y --no-install-recommends python3 python3-pip\
    && rm -rf /var/lib/apt/lists/*

# python aliases to python3
RUN cd /usr/bin \
    && ln -s python3 python \
    && ln -s pip3 pip

# Run postgresql-server
RUN pg_ctlcluster 13 main start