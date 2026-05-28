FROM ghcr.io/semgrep/supply-chain-base-image:main AS builder

ARG SBT_VERSION=1.10.7
ARG NODE_MAJOR=22

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    gnupg \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
    | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" \
        >/etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL "https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" \
    | tar -xz -C /opt \
    && npm install -g @cyclonedx/cdxgen@12.4.4

USER semgrep

FROM ghcr.io/semgrep/supply-chain-base-image:main

ARG NODE_MAJOR=22

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    default-jdk-headless \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
    | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" \
        >/etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y --no-install-recommends nodejs \
    && apt-get purge -y --auto-remove curl gnupg \
    && rm -rf /var/lib/apt/lists/* /etc/apt/keyrings /etc/apt/sources.list.d/nodesource.list

COPY --from=builder /opt/sbt /opt/sbt
COPY --from=builder /usr/lib/node_modules/@cyclonedx /usr/lib/node_modules/@cyclonedx
COPY --from=builder /usr/bin/cdxgen /usr/bin/cdxgen

ENV PATH="/opt/sbt/bin:${PATH}"

USER semgrep

CMD ["sh", "-c", "cd \"$SEMGREP_WORKSPACE\" && cdxgen -t sbt -o \"$SEMGREP_OUTPUT/bom.json\""]