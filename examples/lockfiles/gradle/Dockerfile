FROM ghcr.io/semgrep/supply-chain-base-image:0.1

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    gradle \
    default-jdk-headless \
    && rm -rf /var/lib/apt/lists/*

USER semgrep

CMD ["sh", "-c", "cd \"$SEMGREP_WORKSPACE\" && gradle dependencies --write-locks && cp gradle.lockfile \"$SEMGREP_OUTPUT/gradle.lockfile\""]