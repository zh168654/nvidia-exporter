FROM golang:1.9.2-alpine3.6 as builder

RUN apk add --no-cache make gcc git musl-dev
RUN go get -u github.com/golang/dep/cmd/dep

WORKDIR /go/src/github.com/bugroger/nvidia-exporter
COPY . .

#RUN dep ensure -vendor-only

ARG VERSION
RUN make all

FROM alpine 

COPY --from=builder /go/src/github.com/bugroger/nvidia-exporter/bin/linux/* /

ENTRYPOINT ["/nvidia-exporter"]
