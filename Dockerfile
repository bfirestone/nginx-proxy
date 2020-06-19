FROM nginx:1.19
LABEL maintainer="Ben Firestone ben.firestone@krypticlabs.com"

# Install wget and install/updates certificates
RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    ca-certificates \
    wget \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*


# Configure Nginx and apply fix for very long server names
RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
 && sed -i 's/worker_processes  1/worker_processes  auto/' /etc/nginx/nginx.conf

RUN mkdir -p /setup/scripts
COPY scripts/ /setup/scripts/

# Install Forego
RUN /setup/scripts/install_forego.sh

ENV DOCKER_GEN_VERSION 0.7.4

# copy docker-gen
RUN /setup/scripts/install_docker_gen.sh ${DOCKER_GEN_VERSION}

COPY network_internal.conf /etc/nginx/

COPY . /app/
WORKDIR /app/

ENV DOCKER_HOST unix:///tmp/docker.sock

VOLUME ["/etc/nginx/certs", "/etc/nginx/dhparam"]

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["forego", "start", "-r"]
