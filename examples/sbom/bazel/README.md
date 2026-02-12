# Bazel SBOM Generator

Generates a CycloneDX SBOM in JSON format from a Bazel project using [cdxgen](https://github.com/CycloneDX/cdxgen).

Uses [Bazelisk](https://github.com/bazelbuild/bazelisk) to automatically download the correct Bazel version for your project (reads `.bazelversion` if present).

## Build

```bash
docker build -t sbom-bazel .
```

## Run

Mount a directory containing a Bazel project (`MODULE.bazel`, `BUILD.bazel`, etc.):

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  sbom-bazel
```

The generated `bom.json` will be written to the outputs directory.

## Targeting a Specific Bazel Target

For monorepos, you can generate an SBOM for a specific target by setting environment variables:

```bash
docker run --rm \
  -e BAZEL_TARGET="//services/my-service:all" \
  -e BAZEL_USE_ACTION_GRAPH=true \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  sbom-bazel
```
