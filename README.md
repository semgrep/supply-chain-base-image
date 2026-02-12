# Supply Chain Base Image

A ready-to-use Docker base image for generating lockfiles and Software Bills of Materials (SBOMs) from your source code. Built on `debian:bookworm-slim`, it provides a consistent foundation for supply chain analysis across multiple package managers.

## Getting Started

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed on your machine

### Quick Start

Pull the base image:

```bash
docker pull ghcr.io/semgrep/supply-chain-base-image:main
```

Then pick an example below that matches your project's package manager, build it, and run it against your code.

## How It Works

The base image sets up two standard directories:

| Directory | Environment Variable | Purpose |
|---|---|---|
| `/semgrep/workspace` | `SEMGREP_WORKSPACE` | Where your source code gets mounted |
| `/semgrep/outputs` | `SEMGREP_OUTPUT` | Where generated lockfiles or SBOMs are written for consumption by Semgrep |

You mount your project into the workspace, run a container, and collect the results from the outputs directory. No need to install package managers or tooling on your local machine.

## Examples

We provide ready-to-use Dockerfiles for the most common package managers. Each example can be used as-is or customized for your specific needs.

### Lockfile Generation

Don't have a lockfile in your repository? These examples generate one from your project's manifest file (e.g., `package.json`, `pom.xml`, `pyproject.toml`).

| Your Project Uses | Example | What Gets Generated |
|---|---|---|
| npm | [`examples/lockfiles/npm/`](examples/lockfiles/npm/) | `package-lock.json` |
| Maven | [`examples/lockfiles/maven/`](examples/lockfiles/maven/) | `dependency-tree.txt` |
| Poetry | [`examples/lockfiles/poetry/`](examples/lockfiles/poetry/) | `poetry.lock` |
| uv | [`examples/lockfiles/uv/`](examples/lockfiles/uv/) | `uv.lock` |
| pip | [`examples/lockfiles/pip/`](examples/lockfiles/pip/) | `requirements-locked.txt` |
| Gradle | [`examples/lockfiles/gradle/`](examples/lockfiles/gradle/) | `gradle.lockfile` |
| Bazel | [`examples/lockfiles/bazel/`](examples/lockfiles/bazel/) | `MODULE.bazel.lock` |

**Example: Generate a lockfile for an npm project**

```bash
# 1. Build the image (one-time step)
docker build -t lockfile-npm examples/lockfiles/npm/

# 2. Run it against your project
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  lockfile-npm

# 3. Check the result
cat outputs/package-lock.json
```

### SBOM Generation

Generate a [CycloneDX](https://cyclonedx.org/) Software Bill of Materials (SBOM) in JSON format. SBOMs provide a complete inventory of your project's dependencies, useful for vulnerability tracking and compliance.

| Your Project Uses | Example | Tool Used |
|---|---|---|
| npm | [`examples/sbom/npm/`](examples/sbom/npm/) | `@cyclonedx/cyclonedx-npm` |
| Maven | [`examples/sbom/maven/`](examples/sbom/maven/) | `cyclonedx-maven-plugin` |
| Poetry | [`examples/sbom/poetry/`](examples/sbom/poetry/) | `cyclonedx-py` |
| uv | [`examples/sbom/uv/`](examples/sbom/uv/) | `uv export` (built-in) |
| pip | [`examples/sbom/pip/`](examples/sbom/pip/) | `cyclonedx-py` |
| Gradle | [`examples/sbom/gradle/`](examples/sbom/gradle/) | `cyclonedx-gradle-plugin` |
| Bazel | [`examples/sbom/bazel/`](examples/sbom/bazel/) | `cdxgen` |

All SBOM examples output a `bom.json` file to the outputs directory.

**Example: Generate an SBOM for a Python (uv) project**

```bash
# 1. Build the image (one-time step)
docker build -t sbom-uv examples/sbom/uv/

# 2. Run it against your project
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  sbom-uv

# 3. Check the result
cat outputs/bom.json
```

## Creating Your Own Image

Use this base image as the starting point for your own Dockerfile. The workspace and output directories are already set up for you.

```dockerfile
FROM ghcr.io/semgrep/supply-chain-base-image:main

# Install whatever tooling you need
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    && rm -rf /var/lib/apt/lists/*

COPY my-script.sh /usr/local/bin/

# Your script reads from $SEMGREP_WORKSPACE and writes to $SEMGREP_OUTPUT
CMD ["my-script.sh"]
```

## Verifying the Image

Every image we publish is signed and includes [SLSA v1.0 Build L3](https://slsa.dev/) provenance and an embedded SBOM. You can verify that the image you pulled was built by our CI pipeline and hasn't been tampered with.

### Verify build provenance

Requires the [GitHub CLI](https://cli.github.com/):

```bash
gh attestation verify oci://ghcr.io/semgrep/supply-chain-base-image:main \
  -R semgrep/supply-chain-base-image
```

### Inspect the embedded SBOM and provenance

```bash
# View provenance
docker buildx imagetools inspect ghcr.io/semgrep/supply-chain-base-image:main \
  --format '{{ json .Provenance }}'

# View SBOM
docker buildx imagetools inspect ghcr.io/semgrep/supply-chain-base-image:main \
  --format '{{ json .SBOM }}'
```

## Building the Base Image Locally

If you want to build the base image yourself instead of pulling from the registry:

```bash
docker build -t supply-chain-base-image .
```

## License

This project is licensed under the [MIT License](LICENSE).
