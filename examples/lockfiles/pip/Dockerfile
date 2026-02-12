FROM ghcr.io/semgrep/supply-chain-base-image:main

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

CMD python3 -m venv /tmp/venv \
    && /tmp/venv/bin/pip install --dry-run --report "${SEMGREP_OUTPUT}/pip-report.json" \
       -r "${SEMGREP_WORKSPACE}/requirements.txt" \
    && /tmp/venv/bin/pip freeze --requirement "${SEMGREP_WORKSPACE}/requirements.txt" \
       > "${SEMGREP_OUTPUT}/requirements-locked.txt"
