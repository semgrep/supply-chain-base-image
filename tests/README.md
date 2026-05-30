# Tests

## Example smoke tests

`smoke-test.sh` runs an example image against a minimal fixture project and
asserts that it produces the lockfile/SBOM output the example documents. CI
(`.github/workflows/test-examples.yml`) runs it for every example after the
image builds.

```bash
# Build the base image and an example, then smoke-test it:
docker build -t ghcr.io/semgrep/supply-chain-base-image:0.1 .
docker build -t example-under-test:smoke examples/lockfiles/npm/
tests/smoke-test.sh examples/lockfiles/npm example-under-test:smoke
```

### Fixtures

`fixtures/<ecosystem>/` holds a minimal project per ecosystem, pinned to an old,
zero-dependency package (`six`, `is-number`) for fast, deterministic resolution.

Currently covered at runtime: **npm, pip, uv, poetry**. The JVM/Bazel/sbt
examples (maven, gradle, bazel, sbt) are build-only for now — their toolchains
download large dependency graphs that make runtime tests slow and flaky in CI.
The harness skips any ecosystem without a fixture, so adding one under
`fixtures/<ecosystem>/` is all that's needed to enable its smoke test.
