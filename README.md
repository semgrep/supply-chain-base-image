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

### Usage

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  ghcr.io/semgrep/supply-chain-base-image:main
```

## Building Locally

```bash
docker build -t supply-chain-base-image .
```
