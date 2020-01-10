### Certs
FROM alpine:latest as certs
RUN apk --update add ca-certificates

### Base
FROM golang:1.12.14-alpine3.10 as base

ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64


COPY . /go/src/ahm/
WORKDIR /go/src/ahm/

# it will take the flags from the environment
RUN go build cmd/main.go
RUN ls -la

### App
FROM scratch as app
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=base /go/src/ahm/main /
ENTRYPOINT ["/main"]