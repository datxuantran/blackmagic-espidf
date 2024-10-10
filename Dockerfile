# Use the official Debian stable slim image as the base image
FROM debian:stable-slim

# Set the working directory
WORKDIR /esp

# Install required packages
RUN apt update && \
    apt install -y \
    git \
    wget \
    python3 \
    python3-venv \
    build-essential \
    libncurses5-dev \
    flex \
    bison \
    gperf \
    zlib1g-dev && \
    # Clean up unnecessary files
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Pull the blackmagic-espidf project
RUN git clone --recursive https://github.com/datxuantran/blackmagic-espidf.git

# Download and install the ESP8266_RTOS_SDK toolchain
RUN wget https://dl.espressif.com/dl/xtensa-lx106-elf-gcc8_4_0-esp-2020r3-linux-amd64.tar.gz && \
    tar -xzf xtensa-lx106-elf-gcc8_4_0-esp-2020r3-linux-amd64.tar.gz -C /opt && \
    mv /opt/xtensa-lx106-elf /opt/xtensa-lx106-elf-gcc && \
    echo 'export PATH=/opt/xtensa-lx106-elf-gcc/bin:$PATH' >> /etc/bash.bashrc

# Create a symbolic link for Python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Create and activate a Python virtual environment
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install virtualenv

# Set the default command to bash
CMD ["/bin/bash"]
