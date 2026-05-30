FROM ghcr.io/semgrep/supply-chain-base-image:main AS builder

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    pipx \
    && rm -rf /var/lib/apt/lists/*

USER semgrep
RUN pipx install cyclonedx-bom==7.3.0

FROM ghcr.io/semgrep/supply-chain-base-image:main

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    && rm -rf /var/lib/apt/lists/*

USER semgrep
COPY --from=builder --chown=semgrep:semgrep /home/semgrep/.local /home/semgrep/.local

ENV PATH="/home/semgrep/.local/bin:${PATH}"

CMD ["sh", "-c", "cyclonedx-py requirements \"$SEMGREP_WORKSPACE/requirements.txt\" --of JSON -o \"$SEMGREP_OUTPUT/bom.json\""]