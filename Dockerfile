FROM debian:trixie-slim

# Install dnsmasq and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends dnsmasq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create dnsmasq configuration directory
RUN mkdir -p /etc/dnsmasq.d

# Expose DNS port
# Note: Configuration files should be mounted as volumes at runtime
EXPOSE 53 53/udp

# Run dnsmasq in foreground mode
# Explicitly specify config file to ensure it's loaded
CMD ["dnsmasq", "--keep-in-foreground", "--conf-file=/etc/dnsmasq.conf"]

