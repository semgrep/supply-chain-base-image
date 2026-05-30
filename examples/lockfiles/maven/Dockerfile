FROM ghcr.io/semgrep/supply-chain-base-image:0.1

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    maven \
    default-jdk-headless \
    && rm -rf /var/lib/apt/lists/*

USER semgrep

CMD ["sh", "-c", "mvn dependency:tree -f \"$SEMGREP_WORKSPACE/pom.xml\" -DoutputFile=\"$SEMGREP_OUTPUT/dependency-tree.txt\""]