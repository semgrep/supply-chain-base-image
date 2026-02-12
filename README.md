# supply-chain-base-image

Base Docker image for supply chain analysis tooling. Built from `debian:bookworm-slim`.

## Image

```
ghcr.io/semgrep/supply-chain-base-image
```

### Pulling

```bash
docker pull ghcr.io/semgrep/supply-chain-base-image:main
```

### Environment Variables

| Variable | Default | Description |
|---|---|---|
| `SEMGREP_WORKSPACE` | `/semgrep/workspace` | Mount point for source code to analyze |
| `SEMGREP_OUTPUT` | `/semgrep/outputs` | Directory for analysis outputs |

### As a Base Image

Use this image as the `FROM` in your own Dockerfile. The `SEMGREP_WORKSPACE` and `SEMGREP_OUTPUT` directories are already created and available as environment variables.

```dockerfile
FROM ghcr.io/semgrep/supply-chain-base-image:main

# Install your dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Add your tooling
COPY my-script.sh /usr/local/bin/

# Code is mounted at $SEMGREP_WORKSPACE, outputs go to $SEMGREP_OUTPUT
CMD ["my-script.sh"]
```

### Running Directly

```bash
docker run --rm \
  -v "$(pwd):${SEMGREP_WORKSPACE:-/semgrep/workspace}" \
  -v "./outputs:${SEMGREP_OUTPUT:-/semgrep/outputs}" \
  ghcr.io/semgrep/supply-chain-base-image:main
```

## Examples

The [`examples/`](examples/) directory contains ready-to-use Dockerfiles for generating lockfiles with common package managers.

| Example | Package Manager | Lockfile Generated |
|---|---|---|
| [`examples/npm/`](examples/npm/) | npm | `package-lock.json` |
| [`examples/maven/`](examples/maven/) | Maven | `dependency-tree.txt` |
| [`examples/poetry/`](examples/poetry/) | Poetry | `poetry.lock` |
| [`examples/uv/`](examples/uv/) | uv | `uv.lock` |

Each example installs the package manager, generates a lockfile from code mounted at `$SEMGREP_WORKSPACE`, and writes the result to `$SEMGREP_OUTPUT`.

For instance, to generate a `package-lock.json` for an npm project:

```bash
docker build -t lockfile-npm examples/npm/
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  lockfile-npm
```

## Building Locally

```bash
docker build -t supply-chain-base-image .
```
