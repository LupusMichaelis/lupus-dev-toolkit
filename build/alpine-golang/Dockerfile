FROM golang:alpine AS builder
#FROM golang:1.12.4-alpine3.9 AS builder

RUN apk add \
    --no-cache \
    --update \
    alpine-sdk

COPY . /go/src/lupusmic.org/my-project
WORKDIR /go/src/lupusmic.org/my-project
RUN go get -t ./...
RUN go build

FROM alpine
#FROM alpine:3.9

COPY --from=builder /go/bin/my-project /usr/local/bin/my-project

WORKDIR /go/src/lupusmic.org/my-project
CMD ["my-project"]
