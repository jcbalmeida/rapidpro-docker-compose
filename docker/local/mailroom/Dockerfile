FROM golang:1.14.6-alpine3.12

WORKDIR /app

RUN apk update \
  && apk add --virtual build-deps gcc git curl tar \
  && rm -rf /var/cache/apk/*

RUN addgroup -S golang \
  && adduser -S -G golang golang

COPY  src/mailroom .

RUN go install -v ./cmd/...

EXPOSE 8000
CMD ["mailroom"]
