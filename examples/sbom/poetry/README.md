# Poetry SBOM Generator

Generates a CycloneDX SBOM in JSON format from a project's `pyproject.toml` and `poetry.lock` using `cyclonedx-py`.

## Build

```bash
docker build -t sbom-poetry .
```

## Run

Mount a directory containing a `pyproject.toml` with Poetry-style dependencies:

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  sbom-poetry
```

The generated `bom.json` will be written to the outputs directory.
