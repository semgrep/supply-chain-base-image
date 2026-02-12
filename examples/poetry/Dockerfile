FROM ghcr.io/semgrep/supply-chain-base-image:main

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    pipx \
    && rm -rf /var/lib/apt/lists/* \
    && pipx install poetry

ENV PATH="/root/.local/bin:${PATH}"

CMD cd "${SEMGREP_WORKSPACE}" \
    && poetry lock --no-update \
    && cp poetry.lock "${SEMGREP_OUTPUT}/poetry.lock"
