ARG VARIANT="16"
FROM mcr.microsoft.com/devcontainers/javascript-node:1-${VARIANT}

RUN apt-get update && apt-get install -y wget tar

RUN wget https://github.com/protomaps/go-pmtiles/releases/download/v1.28.0/go-pmtiles_1.28.0_Linux_x86_64.tar.gz \
    && tar -xzf go-pmtiles_1.28.0_Linux_x86_64.tar.gz \
    && mv pmtiles /usr/local/bin/pmtiles \
    && chmod +x /usr/local/bin/pmtiles \
    && rm go-pmtiles_1.28.0_Linux_x86_64.tar.gz
