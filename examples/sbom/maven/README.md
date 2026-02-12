# Maven SBOM Generator

Generates a CycloneDX SBOM in JSON format from a project's `pom.xml` using `cyclonedx-maven-plugin`.

## Build

```bash
docker build -t sbom-maven .
```

## Run

Mount a directory containing a `pom.xml`:

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  sbom-maven
```

The generated `bom.json` will be written to the outputs directory.
