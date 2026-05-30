FROM ghcr.io/semgrep/supply-chain-base-image:0.1 AS builder

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    pipx \
    && rm -rf /var/lib/apt/lists/*

USER semgrep
RUN pipx install poetry==2.4.1 \
    && pipx install cyclonedx-bom==7.3.0

FROM ghcr.io/semgrep/supply-chain-base-image:0.1

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    && rm -rf /var/lib/apt/lists/*

USER semgrep
COPY --from=builder --chown=semgrep:semgrep /home/semgrep/.local /home/semgrep/.local

ENV PATH="/home/semgrep/.local/bin:${PATH}"

CMD ["sh", "-c", "cd \"$SEMGREP_WORKSPACE\" && poetry lock && cyclonedx-py poetry \"$SEMGREP_WORKSPACE\" --of JSON -o \"$SEMGREP_OUTPUT/bom.json\""]