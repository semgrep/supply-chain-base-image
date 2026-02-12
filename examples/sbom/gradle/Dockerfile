FROM ghcr.io/semgrep/supply-chain-base-image:main

RUN apt-get update && apt-get install -y --no-install-recommends \
    gradle \
    default-jdk-headless \
    && rm -rf /var/lib/apt/lists/*

COPY init.gradle /tmp/init.gradle

CMD cd "${SEMGREP_WORKSPACE}" \
    && gradle cyclonedxBom --init-script /tmp/init.gradle \
    && cp build/reports/cyclonedx/bom.json "${SEMGREP_OUTPUT}/bom.json"
