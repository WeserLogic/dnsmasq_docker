FROM debian:trixie-slim

# Install dnsmasq and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends dnsmasq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create dnsmasq configuration directory
RUN mkdir -p /etc/dnsmasq.d

# Expose DNS port
EXPOSE 53 53/udp

# Run dnsmasq in foreground mode
CMD ["dnsmasq", "--keep-in-foreground", "--conf-file=/etc/dnsmasq.conf"]

