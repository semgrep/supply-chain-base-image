FROM debian:bookworm-slim@sha256:0104b334637a5f19aa9c983a91b54c89887c0984081f2068983107a6f6c21eeb

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