FROM ghcr.io/semgrep/supply-chain-base-image:main

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    git \
    default-jdk-headless \
    python3 \
    zip \
    unzip \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/* \
    && curl -L https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64 \
       -o /usr/local/bin/bazel \
    && chmod +x /usr/local/bin/bazel \
    && npm install -g @cyclonedx/cdxgen

CMD cd "${SEMGREP_WORKSPACE}" \
    && cdxgen -o "${SEMGREP_OUTPUT}/bom.json"
