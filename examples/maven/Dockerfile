FROM ghcr.io/semgrep/supply-chain-base-image:main

RUN apt-get update && apt-get install -y --no-install-recommends \
    maven \
    default-jdk-headless \
    && rm -rf /var/lib/apt/lists/*

CMD mvn dependency:tree \
    -f "${SEMGREP_WORKSPACE}/pom.xml" \
    -DoutputFile="${SEMGREP_OUTPUT}/dependency-tree.txt"
