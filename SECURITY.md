# Security Policy

## Supported Versions

This project follows semantic versioning. We support the latest released minor
series; fixes are shipped as new patch releases on top of it.

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |
| < 0.1   | :x:                |

Images are published to `ghcr.io/semgrep/supply-chain-base-image`. For the
strongest guarantees, pin to an immutable digest (`@sha256:...`) or a specific
patch tag (e.g. `0.1.3`) rather than a moving tag.

## Reporting a Vulnerability

Please email security@semgrep.com with any security issues in this project. We
take all reports seriously and will acknowledge your report as quickly as we
can. Please do not open a public issue for security vulnerabilities.

## Verifying releases

Every published image is signed and ships with SLSA Build L3 provenance and an
embedded SBOM. See the "Verifying the Image" section of the [README](README.md)
for instructions on verifying provenance before use.
