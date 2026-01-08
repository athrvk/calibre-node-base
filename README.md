# Calibre and Node.js Base Image

[![Docker Image Version](https://img.shields.io/docker/v/athrvk/calibre-node-base)](https://hub.docker.com/repository/docker/athrvk/calibre-node-base/general)

This repository contains a Dockerfile for creating a base image with Calibre and Node.js pre-installed. This image is built on top of Ubuntu 24.04 and includes all necessary dependencies for running Calibre for e-book management and conversion.

## Features

- **Ubuntu 24.04**: The base image is built on the latest LTS version of Ubuntu.
- **Multi-Architecture Support**: Built for both `linux/amd64` and `linux/arm64` platforms.
- **Calibre**: Pre-installed for e-book management and conversion.
- **Node.js 20**: Latest LTS version from NodeSource.

## Multi-Architecture Support

This image is built for multiple architectures:
- **linux/amd64** - For x86_64 systems
- **linux/arm64** - For ARM64 systems (e.g., Apple Silicon, AWS Graviton)

Docker will automatically pull the correct image for your platform. You can also explicitly specify the platform:

```sh
docker run --platform linux/amd64 athrvk/calibre-node-base
docker run --platform linux/arm64 athrvk/calibre-node-base
```

## Usage

### Pull the Pre-built Image

To pull the latest multi-arch image from Docker Hub:

```sh
docker pull athrvk/calibre-node-base:latest
```

### Build Locally

To build the Docker image locally for your platform:

```sh
docker build -t calibre-node-base .
```

To build for a specific platform or multiple platforms:

```sh
# Build for amd64
docker buildx build --platform linux/amd64 -t calibre-node-base:amd64 .

# Build for arm64
docker buildx build --platform linux/arm64 -t calibre-node-base:arm64 .

# Build for both platforms
docker buildx build --platform linux/amd64,linux/arm64 -t calibre-node-base:latest .
```

### Run a Container

To run a container using the built image:

```sh
docker run -it --rm athrvk/calibre-node-base
```

### Use as Base Image

To use the image as a base for another Dockerfile, include the following line at the top of the file:

```Dockerfile
FROM athrvk/calibre-node-base:latest
```

## Installed Packages

The Dockerfile installs the following packages and dependencies:

- **System utilities**: `wget`, `curl`, `xz-utils`, `gnupg`
- **Calibre**: E-book management and conversion tool (from Ubuntu repository)
- **Node.js 20**: Latest LTS version from NodeSource
- **npm**: Latest version of npm package manager

## Verifying Installations

Verify the installations of Calibre and Node.js:

```sh
# Calibre version
docker run --rm athrvk/calibre-node-base ebook-convert --version

# Node.js version
docker run --rm athrvk/calibre-node-base node -v

# npm version
docker run --rm athrvk/calibre-node-base npm -v
```

## CI/CD

This image is automatically built and pushed to Docker Hub via GitHub Actions whenever changes are pushed to the main/master branch. The workflow:

1. Sets up QEMU for multi-architecture emulation
2. Configures Docker Buildx for multi-platform builds
3. Builds images for both linux/amd64 and linux/arm64
4. Pushes the images to Docker Hub with version tags and `latest` tag
5. Auto-increments the version number on successful builds

### Setting up GitHub Actions

To enable auto-deployment, you need to set up the following secrets in your GitHub repository:

1. Go to your repository Settings → Secrets and variables → Actions
2. Add the following secrets:
   - `DOCKER_USERNAME`: Your Docker Hub username
   - `DOCKER_PASSWORD`: Your Docker Hub password or access token

The workflow will trigger automatically on pushes to the main/master branch or can be manually triggered via the Actions tab.

## Development

### Testing Node.js

A test script is included to verify Node.js installation:

```sh
docker run --rm athrvk/calibre-node-base node index.js
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Maintainer

This image is maintained by [athrvk](https://github.com/athrvk).
