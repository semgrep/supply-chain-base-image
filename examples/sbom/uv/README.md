# uv SBOM Generator

Generates a CycloneDX 1.5 SBOM in JSON format from a project's `pyproject.toml` using `uv export`.

## Build

```bash
docker build -t sbom-uv .
```

## Run

Mount a directory containing a `pyproject.toml`:

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  sbom-uv
```

The generated `bom.json` will be written to the outputs directory.
