FROM ghcr.io/semgrep/supply-chain-base-image:main AS builder

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && curl -L https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64 \
        -o /usr/local/bin/bazel \
    && chmod +x /usr/local/bin/bazel

USER semgrep

FROM ghcr.io/semgrep/supply-chain-base-image:main

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    default-jdk-headless \
    git \
    python3 \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bin/bazel /usr/local/bin/bazel

USER semgrep

CMD ["sh", "-c", "cd \"$SEMGREP_WORKSPACE\" && bazel mod deps --lockfile_mode=update && cp MODULE.bazel.lock \"$SEMGREP_OUTPUT/MODULE.bazel.lock\""]