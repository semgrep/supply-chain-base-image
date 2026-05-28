FROM debian:bookworm-slim@sha256:74d56e3931e0d5a1dd51f8c8a2466d21de84a271cd3b5a733b803aa91abf4421

LABEL org.opencontainers.image.source="https://github.com/semgrep/supply-chain-base-image"
LABEL org.opencontainers.image.description="Base Docker image for generating lockfiles and SBOMs from source code"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.vendor="Semgrep"
LABEL org.opencontainers.image.title="Supply Chain Base Image"
LABEL org.opencontainers.image.url="https://github.com/semgrep/supply-chain-base-image"

ENV SEMGREP_WORKSPACE=/semgrep/workspace
ENV SEMGREP_OUTPUT=/semgrep/outputs

RUN groupadd --gid 1000 semgrep \
    && useradd --uid 1000 --gid semgrep --create-home --shell /bin/bash semgrep \
    && mkdir -p "${SEMGREP_WORKSPACE}" "${SEMGREP_OUTPUT}" \
    && chown -R semgrep:semgrep /semgrep

WORKDIR ${SEMGREP_WORKSPACE}

USER semgrep