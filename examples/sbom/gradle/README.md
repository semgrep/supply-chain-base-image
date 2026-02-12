# Gradle SBOM Generator

Generates a CycloneDX SBOM in JSON format from a Gradle project using the `cyclonedx-gradle-plugin` via an init script (no changes to `build.gradle` required).

## Build

```bash
docker build -t sbom-gradle .
```

## Run

Mount a directory containing a `build.gradle` or `build.gradle.kts`:

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  sbom-gradle
```

The generated `bom.json` will be written to the outputs directory.
