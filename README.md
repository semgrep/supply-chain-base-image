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
| `SEMGREP_WORKSPACE` | `/semgrep/workspace` | Mount point for source code to use to generate a lockfile/SBOM |
| `SEMGREP_OUTPUT` | `/semgrep/outputs` | Directory for lockfile/SBOM outputs |

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

The [`examples/lockfiles/`](examples/lockfiles/) directory contains ready-to-use Dockerfiles for generating lockfiles with common package managers.

| Example | Package Manager | Lockfile Generated |
|---|---|---|
| [`examples/lockfiles/npm/`](examples/lockfiles/npm/) | npm | `package-lock.json` |
| [`examples/lockfiles/maven/`](examples/lockfiles/maven/) | Maven | `dependency-tree.txt` |
| [`examples/lockfiles/poetry/`](examples/lockfiles/poetry/) | Poetry | `poetry.lock` |
| [`examples/lockfiles/uv/`](examples/lockfiles/uv/) | uv | `uv.lock` |
| [`examples/lockfiles/pip/`](examples/lockfiles/pip/) | pip | `requirements-locked.txt` |
| [`examples/lockfiles/gradle/`](examples/lockfiles/gradle/) | Gradle | `gradle.lockfile` |

Each example installs the package manager, generates a lockfile from code mounted at `$SEMGREP_WORKSPACE`, and writes the result to `$SEMGREP_OUTPUT`.

For instance, to generate a `package-lock.json` for an npm project:

```bash
docker build -t lockfile-npm examples/lockfiles/npm/
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  lockfile-npm
```

### SBOM Generation

The [`examples/sbom/`](examples/sbom/) directory contains ready-to-use Dockerfiles for generating CycloneDX SBOMs.

| Example | Tool | Output |
|---|---|---|
| [`examples/sbom/npm/`](examples/sbom/npm/) | `@cyclonedx/cyclonedx-npm` | `bom.json` |
| [`examples/sbom/maven/`](examples/sbom/maven/) | `cyclonedx-maven-plugin` | `bom.json` |
| [`examples/sbom/poetry/`](examples/sbom/poetry/) | `cyclonedx-py` | `bom.json` |
| [`examples/sbom/uv/`](examples/sbom/uv/) | `uv export` | `bom.json` |
| [`examples/sbom/pip/`](examples/sbom/pip/) | `cyclonedx-py` | `bom.json` |
| [`examples/sbom/gradle/`](examples/sbom/gradle/) | `cyclonedx-gradle-plugin` | `bom.json` |

Each example generates a CycloneDX JSON SBOM from code mounted at `$SEMGREP_WORKSPACE` and writes `bom.json` to `$SEMGREP_OUTPUT`.

For instance, to generate an SBOM for a uv project:

```bash
docker build -t sbom-uv examples/sbom/uv/
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  sbom-uv
```

## Building Locally

```bash
docker build -t supply-chain-base-image .
```
