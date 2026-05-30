# Contributing

Thanks for your interest in improving the Supply Chain Base Image! This repo
provides a hardened Debian base image plus example Dockerfiles for generating
lockfiles and SBOMs across many package managers.

## Ground rules

- All changes land via pull request with at least one approving review.
- CI must be green before merge.
- Keep changes minimal and focused; match the style of the surrounding files.

## Repository layout

| Path | Purpose |
|---|---|
| `Dockerfile` | The base image (non-root `semgrep` user, workspace/output dirs). |
| `examples/lockfiles/<eco>/` | Lockfile-generation example per ecosystem. |
| `examples/sbom/<eco>/` | SBOM-generation example per ecosystem. |
| `.github/workflows/` | CI: lint, scan, publish, release, example tests. |

## Local development

Build the base image:

```bash
docker build -t supply-chain-base-image .
```

Build and run an example against a project on disk:

```bash
docker build -t lockfile-npm examples/lockfiles/npm/
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "$(pwd)/outputs:/semgrep/outputs" \
  lockfile-npm
```

## Conventions

- **Pin all dependencies.** GitHub Actions must be pinned to a full commit SHA
  with a comment naming the version; `ratchet` enforces this in CI. The base
  image is pinned to a digest.
- **Lint Dockerfiles** with hadolint (`.hadolint.yaml`); CI runs it on every
  Dockerfile.
- **Keep examples non-root.** Switch back to `USER semgrep` after any
  `apt-get install` steps.
- **Add a smoke-test fixture** when you add a new example so CI can run it.
  See `.github/workflows/test-examples.yml` and `tests/fixtures/`.

## Releasing

Releases are tag-driven. Pushing a `vX.Y.Z` tag triggers:

1. The vulnerability scan + multi-arch build & push to GHCR (`publish.yml`).
2. A signed image with SLSA provenance and an embedded SBOM.
3. A GitHub Release with auto-generated notes (`release.yml`).

Update `CHANGELOG.md` in the release PR before tagging.

## Reporting security issues

Please do not file public issues for vulnerabilities. See
[SECURITY.md](SECURITY.md).
