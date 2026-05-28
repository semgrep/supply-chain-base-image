# sbt SBOM Generator

Generates a CycloneDX SBOM in JSON format from an sbt project using [`cdxgen`](https://github.com/CycloneDX/cdxgen).

## Build

```bash
docker build -t sbom-sbt .
```

## Run

Mount a directory containing a `build.sbt`:

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  sbom-sbt
```

The generated `bom.json` will be written to the outputs directory.
