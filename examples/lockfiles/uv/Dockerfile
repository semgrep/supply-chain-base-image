FROM ghcr.io/semgrep/supply-chain-base-image:main AS builder

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

USER semgrep
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

FROM ghcr.io/semgrep/supply-chain-base-image:main

COPY --from=builder --chown=semgrep:semgrep /home/semgrep/.local /home/semgrep/.local

ENV PATH="/home/semgrep/.local/bin:${PATH}"

CMD ["sh", "-c", "cd \"$SEMGREP_WORKSPACE\" && uv lock && cp uv.lock \"$SEMGREP_OUTPUT/uv.lock\""]