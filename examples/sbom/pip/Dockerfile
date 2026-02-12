FROM ghcr.io/semgrep/supply-chain-base-image:main

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    pipx \
    && rm -rf /var/lib/apt/lists/* \
    && pipx install cyclonedx-bom

ENV PATH="/root/.local/bin:${PATH}"

CMD cyclonedx-py requirements "${SEMGREP_WORKSPACE}/requirements.txt" \
    --of JSON -o "${SEMGREP_OUTPUT}/bom.json"
