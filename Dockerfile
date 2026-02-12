FROM debian:bookworm-slim

ENV SEMGREP_WORKSPACE=/semgrep/workspace
ENV SEMGREP_OUTPUT=/semgrep/outputs

RUN mkdir -p "${SEMGREP_WORKSPACE}" "${SEMGREP_OUTPUT}"

WORKDIR ${SEMGREP_WORKSPACE}
