FROM golang:1.13.14-alpine3.12

WORKDIR /app

RUN apk update \
  && apk add --virtual build-deps gcc git \
  && rm -rf /var/cache/apk/*

RUN addgroup -S golang \
  && adduser -S -G golang golang

COPY microservices/rp-indexer .

RUN go install -v ./cmd/...
RUN chown -R golang /app

USER golang

EXPOSE 8080
CMD ["rp-indexer"]
