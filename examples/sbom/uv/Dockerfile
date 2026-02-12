FROM ghcr.io/semgrep/supply-chain-base-image:main

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && curl -LsSf https://astral.sh/uv/install.sh | sh

ENV PATH="/root/.local/bin:${PATH}"

CMD cd "${SEMGREP_WORKSPACE}" \
    && uv lock \
    && uv export --format cyclonedx1.5 --output-file "${SEMGREP_OUTPUT}/bom.json"
