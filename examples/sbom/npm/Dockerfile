FROM ghcr.io/semgrep/supply-chain-base-image:main

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/* \
    && npm install --global @cyclonedx/cyclonedx-npm@4.2.1

USER semgrep

CMD ["sh", "-c", "cd \"$SEMGREP_WORKSPACE\" && npm install --package-lock-only && cyclonedx-npm --package-lock-only --output-format JSON --output-file \"$SEMGREP_OUTPUT/bom.json\""]