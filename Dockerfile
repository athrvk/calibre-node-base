FROM ubuntu:24.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Declare build arguments for multi-arch support
# These are automatically provided by Docker buildx and can be used for platform-specific logic
ARG TARGETARCH
ARG TARGETPLATFORM

# Install system dependencies
RUN apt-get update && apt-get -qq install -y \
    # Basic utilities
    wget \
    curl \
    xz-utils \
    gnupg \
    xdg-utils \
    python3 \
    # Calibre dependencies
    libglx0 \
    libgl1 \
    libglx-mesa0 \
    libgl1-mesa-dri \
    libegl1 \
    libopengl0 \
    libxcb-cursor0 \
    libxkbcommon0 \
    # Additional utilities
    poppler-utils \
    speech-dispatcher \
    # Node.js requirements
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN wget -qO- https://deb.nodesource.com/setup_24.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest

# Install Calibre via the official installer, which always pulls the latest
# upstream release (Ubuntu's apt package lags behind and is discouraged by
# the Calibre project)
RUN wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin \
    && dbus-uuidgen > /etc/machine-id



# Usage instructions in label
LABEL maintainer="atharvakusumbia@gmail.com" \
      description="Base image with Calibre and Node.js pre-installed" \
      version="1.0"
