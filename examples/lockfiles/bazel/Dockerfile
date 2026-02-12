FROM ghcr.io/semgrep/supply-chain-base-image:main

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    git \
    default-jdk-headless \
    python3 \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/* \
    && curl -L https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64 \
       -o /usr/local/bin/bazel \
    && chmod +x /usr/local/bin/bazel

CMD cd "${SEMGREP_WORKSPACE}" \
    && bazel mod deps --lockfile_mode=update \
    && cp MODULE.bazel.lock "${SEMGREP_OUTPUT}/MODULE.bazel.lock"
