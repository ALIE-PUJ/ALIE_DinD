FROM docker:dind

COPY ./ca.crt /usr/local/share/ca-certificates/

RUN update-ca-certificates

