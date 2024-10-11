# Use the latest Debian slim image as the base
FROM debian:stable-slim

# Set environment variables
ENV IDF_PATH=/esp/blackmagic-espidf/ESP8266_RTOS_SDK

# Set the working directory
WORKDIR /esp

# Update and install required packages
RUN apt update && \
    apt install -y git wget python3 python3-virtualenv build-essential libncurses5-dev flex bison gperf zlib1g-dev && \
	ln -s /usr/bin/python3 /usr/bin/python

# Clone the blackmagic-espidf repository
RUN git clone --recursive https://github.com/datxuantran/blackmagic-espidf.git

# Install ESP8266_RTOS_SDK requirements 
RUN /esp/blackmagic-espidf/ESP8266_RTOS_SDK/install.sh \
	&& echo 'source /esp/blackmagic-espidf/ESP8266_RTOS_SDK/export.sh' >> ~/.bashrc \
	&& cd blackmagic-espidf

# Set the working directory to the blackmagic-espidf folder
WORKDIR /esp/blackmagic-espidf

# Set the entrypoint to bash
ENTRYPOINT ["/bin/bash"]

