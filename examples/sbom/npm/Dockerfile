FROM ghcr.io/semgrep/supply-chain-base-image:main

RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/* \
    && npm install --global @cyclonedx/cyclonedx-npm

CMD cd "${SEMGREP_WORKSPACE}" \
    && npm install --package-lock-only \
    && cyclonedx-npm --package-lock-only --output-format JSON --output-file "${SEMGREP_OUTPUT}/bom.json"
