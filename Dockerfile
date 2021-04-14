FROM debian:stable-slim
RUN sed -i 's/main/main contrib non-free/' /etc/apt/sources.list
WORKDIR /home/Osmedeus
ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US" \
    LC_ALL="en_US.UTF-8"
RUN apt-get update && apt-get -yq install locales && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install --no-install-recommends \
        procps pkg-config console npm git sudo wget python3-pip python-pip \
        curl libcurl4-openssl-dev bsdmainutils && \
    apt-get -yq dist-upgrade && \
    git clone --depth 1 https://github.com/Phyliares/Osmedeus . && \
    ./install.sh && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/{apt,dpkg,cache,log}
EXPOSE 8000
ENTRYPOINT ["python3","server/manage.py"]
CMD ["runserver","0.0.0.0:8000"]
