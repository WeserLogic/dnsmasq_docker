# dnsmasq_docker
Docker container serving dnsmasq service on Debian Trixie-slim

## Overview
This repository contains a Docker image that runs dnsmasq DNS server on Debian Trixie-slim.

## Building the Image

### Local Build
```bash
docker build -t dnsmasq:latest .
```

### Running the Container

**Using Docker Compose (recommended):**
```bash
docker-compose up -d
```

**Or using docker run with the example configuration files:**
```bash
docker run -d \
  --name dnsmasq \
  -p 53:53/udp \
  -p 53:53/tcp \
  -v $(pwd)/sample.dnsmasq.d/dnsmasq.conf:/etc/dnsmasq.conf \
  -v $(pwd)/sample.dnsmasq.d/hosts:/etc/dnsmasq.d/hosts \
  dnsmasq:latest
```

**With your own custom configuration:**
```bash
docker run -d \
  --name dnsmasq \
  -p 53:53/udp \
  -p 53:53/tcp \
  -v /path/to/your/dnsmasq.conf:/etc/dnsmasq.conf \
  -v /path/to/your/hosts:/etc/dnsmasq.d/hosts \
  dnsmasq:latest
```

**Note:** Configuration files must be mounted as volumes - they are not included in the image. The container runs as root by default, so no special capabilities are needed to bind to port 53. If you need advanced network features (like DHCP), you may need to add `--cap-add=NET_ADMIN`.

## GitHub Container Registry

The image is automatically built and pushed to GitHub Container Registry on:
- Push to `main` branch
- Creation of version tags (e.g., `v1.0.0`)
- Manual workflow dispatch

### Pulling the Image
```bash
docker pull ghcr.io/<your-username>/dnsmasq_docker:latest
```

Replace `<your-username>` with your GitHub username or organization name.

## Configuration

Configuration files are **not included in the Docker image** and must be mounted as volumes at runtime. The files in the `sample.dnsmasq.d/` directory serve as examples/templates.

The example configuration includes:
- Listens on all interfaces (0.0.0.0)
- Local domain: `weserlogic.internal`
- Host entry: `manager.weserlogic.internal` → `10.0.0.2` (via hosts file)
- Uses custom upstream DNS servers
- Query logging enabled
- Cache size: 1000 entries
- Local TTL: 300 seconds

You can customize the configuration by mounting your own `dnsmasq.conf` file to `/etc/dnsmasq.conf` and optionally a `hosts` file to `/etc/dnsmasq.d/hosts` when running the container.

## Ports

- **53/udp**: DNS queries
- **53/tcp**: DNS queries (TCP fallback)
