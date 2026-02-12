FROM ghcr.io/semgrep/supply-chain-base-image:main

RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

CMD npm install --package-lock-only --prefix "${SEMGREP_WORKSPACE}" \
    && cp "${SEMGREP_WORKSPACE}/package-lock.json" "${SEMGREP_OUTPUT}/package-lock.json"
