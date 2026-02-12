FROM ghcr.io/semgrep/supply-chain-base-image:main

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    pipx \
    && rm -rf /var/lib/apt/lists/* \
    && pipx install poetry \
    && pipx install cyclonedx-bom

ENV PATH="/root/.local/bin:${PATH}"

CMD cd "${SEMGREP_WORKSPACE}" \
    && poetry lock --no-update \
    && cyclonedx-py poetry "${SEMGREP_WORKSPACE}" --of JSON -o "${SEMGREP_OUTPUT}/bom.json"
