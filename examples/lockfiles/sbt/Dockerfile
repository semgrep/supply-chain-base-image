FROM ghcr.io/semgrep/supply-chain-base-image:main AS builder

ARG SBT_VERSION=1.10.7

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL "https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" \
    | tar -xz -C /opt

USER semgrep

FROM ghcr.io/semgrep/supply-chain-base-image:main

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    default-jdk-headless \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /opt/sbt /opt/sbt

ENV PATH="/opt/sbt/bin:${PATH}"

USER semgrep
RUN mkdir -p /home/semgrep/.sbt/1.0/plugins
COPY --chown=semgrep:semgrep plugins.sbt /home/semgrep/.sbt/1.0/plugins/plugins.sbt

CMD ["sh", "-c", "cd \"$SEMGREP_WORKSPACE\" && sbt dependencyLockWrite && cp build.sbt.lock \"$SEMGREP_OUTPUT/build.sbt.lock\""]