FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install necessary packages
RUN apt update && apt install -y \
    locales \
    curl \
    git \
    build-essential \
    cmake \
    g++ \
    libjson-c-dev \
    libwebsockets-dev \
    pkg-config \
    libssl-dev \
    zlib1g-dev \
    bash && \
    locale-gen en_US.UTF-8

# Install latest ttyd from GitHub
RUN git clone https://github.com/tsl0922/ttyd.git && \
    cd ttyd && mkdir build && cd build && \
    cmake .. && make && make install && \
    cd ../.. && rm -rf ttyd

# Optional: create a user to run shell securely
RUN useradd -ms /bin/bash shelluser

# Set working directory
WORKDIR /home/shelluser

# Expose ttyd port
EXPOSE 7681

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Start ttyd
CMD ["/start.sh"]
