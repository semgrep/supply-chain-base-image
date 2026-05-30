# Changelog

All notable changes to this project are documented here. The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Each release is also published with auto-generated notes on the
[GitHub Releases](https://github.com/semgrep/supply-chain-base-image/releases)
page.

## [Unreleased]

### Added

- Container vulnerability scanning (Trivy) gates every publish: the build fails
  on fixable HIGH/CRITICAL CVEs, and a full inventory is uploaded to GitHub code
  scanning.
- Runtime smoke tests for the examples in CI: each example is now executed
  against a fixture project and its generated lockfile/SBOM output is asserted.
- `CONTRIBUTING.md`, a pull request template, and `CODEOWNERS`.
- README guidance on choosing an image tag and pinning to an immutable digest.

### Changed

- The published image now carries a `latest` tag pointing at the newest
  release.
- The README and all example `Dockerfile`s now reference the stable `0.1` tag
  instead of the mutable `main` branch tag.

## [0.1.3] - 2026-05-30

### Added

- sbt support for both lockfile and SBOM generation.

### Changed

- Hardened the base image and example images.
- Bumped the `debian:bookworm-slim` base digest and several pinned GitHub
  Actions.

### Fixed

- cdxgen module resolution in the Bazel and sbt SBOM runners.

## [0.1.2] - and earlier

See the [GitHub Releases](https://github.com/semgrep/supply-chain-base-image/releases)
page for notes on `0.1.2` and earlier releases.

[Unreleased]: https://github.com/semgrep/supply-chain-base-image/compare/v0.1.3...HEAD
[0.1.3]: https://github.com/semgrep/supply-chain-base-image/releases/tag/v0.1.3
