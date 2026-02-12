# pip SBOM Generator

Generates a CycloneDX SBOM in JSON format from a project's `requirements.txt` using `cyclonedx-py`.

## Build

```bash
docker build -t sbom-pip .
```

## Run

Mount a directory containing a `requirements.txt`:

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  sbom-pip
```

The generated `bom.json` will be written to the outputs directory.
