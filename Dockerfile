FROM golang:1.15 as builder
RUN git clone https://github.com/box/kube-iptables-tailer/ /upstream
RUN mkdir -p $GOPATH/src/github.com/box && cp -a /upstream $GOPATH/src/github.com/box/kube-iptables-tailer
WORKDIR $GOPATH/src/github.com/box/kube-iptables-tailer
RUN make build

FROM alpine
LABEL maintainer="Saifuding Diliyaer <sdiliyaer@box.com>"
WORKDIR /root/
RUN apk --update add iptables
COPY --from=builder /go/src/github.com/box/kube-iptables-tailer/kube-iptables-tailer /kube-iptables-tailer
