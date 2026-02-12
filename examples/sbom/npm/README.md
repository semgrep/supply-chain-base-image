# npm SBOM Generator

Generates a CycloneDX SBOM in JSON format from a project's `package.json` using `@cyclonedx/cyclonedx-npm`.

## Build

```bash
docker build -t sbom-npm .
```

## Run

Mount a directory containing a `package.json`:

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  sbom-npm
```

The generated `bom.json` will be written to the outputs directory.
