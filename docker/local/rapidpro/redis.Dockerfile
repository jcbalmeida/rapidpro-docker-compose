ADD file:e7407f2294ad23634565820b9669b18ff2a2ca0212a7ec84b9c89d8550859954 in / 
CMD ["bash"]
RUN groupadd -r -g 999 redis && useradd -r -g redis -u 999 redis
ENV GOSU_VERSION=1.12
RUN set -eux;  savedAptMark="$(apt-mark showmanual)";  apt-get update;  apt-get install -y --no-install-recommends ca-certificates dirmngr gnupg wget;  rm -rf /var/lib/apt/lists/*;  dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')";  wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch";  wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc";  export GNUPGHOME="$(mktemp -d)";  gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4;  gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu;  gpgconf --kill all;  rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc;  apt-mark auto '.*' > /dev/null;  [ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null;  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false;  chmod +x /usr/local/bin/gosu;  gosu --version;  gosu nobody true
ENV REDIS_VERSION=6.0.8
ENV REDIS_DOWNLOAD_URL=http://download.redis.io/releases/redis-6.0.8.tar.gz
ENV REDIS_DOWNLOAD_SHA=04fa1fddc39bd1aecb6739dd5dd73858a3515b427acd1e2947a66dadce868d68
RUN set -eux;   savedAptMark="$(apt-mark showmanual)";  apt-get update;  apt-get install -y --no-install-recommends   ca-certificates   wget     gcc   libc6-dev   libssl-dev   make  ;  rm -rf /var/lib/apt/lists/*;   wget -O redis.tar.gz "$REDIS_DOWNLOAD_URL";  echo "$REDIS_DOWNLOAD_SHA *redis.tar.gz" | sha256sum -c -;  mkdir -p /usr/src/redis;  tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1;  rm redis.tar.gz;   grep -E '^ *createBoolConfig[(]"protected-mode",.*, *1 *,.*[)],$' /usr/src/redis/src/config.c;  sed -ri 's!^( *createBoolConfig[(]"protected-mode",.*, *)1( *,.*[)],)$!\10\2!' /usr/src/redis/src/config.c;  grep -E '^ *createBoolConfig[(]"protected-mode",.*, *0 *,.*[)],$' /usr/src/redis/src/config.c;   export BUILD_TLS=yes;  make -C /usr/src/redis -j "$(nproc)" all;  make -C /usr/src/redis install;   serverMd5="$(md5sum /usr/local/bin/redis-server | cut -d' ' -f1)"; export serverMd5;  find /usr/local/bin/redis* -maxdepth 0   -type f -not -name redis-server   -exec sh -eux -c '    md5="$(md5sum "$1" | cut -d" " -f1)";    test "$md5" = "$serverMd5";   ' -- '{}' ';'   -exec ln -svfT 'redis-server' '{}' ';'  ;   rm -r /usr/src/redis;   apt-mark auto '.*' > /dev/null;  [ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null;  find /usr/local -type f -executable -exec ldd '{}' ';'   | awk '/=>/ { print $(NF-1) }'   | sort -u   | xargs -r dpkg-query --search   | cut -d: -f1   | sort -u   | xargs -r apt-mark manual  ;  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false;   redis-cli --version;  redis-server --version
RUN mkdir /data && chown redis:redis /data
VOLUME [/data]
WORKDIR /data
COPY file:df205a0ef6e6df8947ce0a7ae9e37b6a5588035647f38a49b8b07321003a8a01 in /usr/local/bin/ 
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 6379
CMD ["redis-server"]
