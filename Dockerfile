FROM debian:bookworm-slim@sha256:98f4b71de414932439ac6ac690d7060df1f27161073c5036a7553723881bffbe

LABEL org.opencontainers.image.source="https://github.com/semgrep/supply-chain-base-image"
LABEL org.opencontainers.image.description="Base Docker image for generating lockfiles and SBOMs from source code"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.vendor="Semgrep"
LABEL org.opencontainers.image.title="Supply Chain Base Image"
LABEL org.opencontainers.image.url="https://github.com/semgrep/supply-chain-base-image"

ENV SEMGREP_WORKSPACE=/semgrep/workspace
ENV SEMGREP_OUTPUT=/semgrep/outputs

RUN mkdir -p "${SEMGREP_WORKSPACE}" "${SEMGREP_OUTPUT}"

WORKDIR ${SEMGREP_WORKSPACE}
