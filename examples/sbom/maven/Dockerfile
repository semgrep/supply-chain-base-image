FROM ghcr.io/semgrep/supply-chain-base-image:main

RUN apt-get update && apt-get install -y --no-install-recommends \
    maven \
    default-jdk-headless \
    && rm -rf /var/lib/apt/lists/*

CMD mvn org.cyclonedx:cyclonedx-maven-plugin:makeAggregateBom \
    -DoutputFormat=json \
    -DoutputName=bom \
    -f "${SEMGREP_WORKSPACE}/pom.xml" \
    && cp "${SEMGREP_WORKSPACE}/target/bom.json" "${SEMGREP_OUTPUT}/bom.json"
