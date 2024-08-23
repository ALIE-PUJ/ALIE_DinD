FROM docker:dind

RUN mkdir -p /etc/docker/certs.d/harbor.alie.javeriana.edu.co
COPY ./ca.crt /etc/docker/certs.d/harbor.alie.javeriana.edu.co/ca.crt

RUN update-ca-certificates

