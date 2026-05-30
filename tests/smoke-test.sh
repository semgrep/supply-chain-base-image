#!/usr/bin/env bash
#
# Smoke-test an example image: run it against a fixture project and assert that
# it produces the lockfile/SBOM output the example documents.
#
# Usage: tests/smoke-test.sh <example-dir> <image-ref>
#   e.g. tests/smoke-test.sh examples/lockfiles/npm example-under-test:smoke
#
# Examples whose ecosystem has no fixture (heavy JVM/Bazel/sbt toolchains) are
# reported as build-only and skipped — building them is still covered by CI.

set -euo pipefail

EXAMPLE_DIR="${1:?usage: smoke-test.sh <example-dir> <image-ref>}"
IMAGE_REF="${2:?usage: smoke-test.sh <example-dir> <image-ref>}"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FIXTURES="${REPO_ROOT}/tests/fixtures"

# examples/<category>/<ecosystem>
CATEGORY="$(basename "$(dirname "$EXAMPLE_DIR")")"
ECOSYSTEM="$(basename "$EXAMPLE_DIR")"

# Ecosystems we run at runtime, and the fixture directory each one uses.
case "$ECOSYSTEM" in
  npm)    FIXTURE="${FIXTURES}/npm" ;;
  pip)    FIXTURE="${FIXTURES}/pip" ;;
  uv)     FIXTURE="${FIXTURES}/uv" ;;
  poetry) FIXTURE="${FIXTURES}/poetry" ;;
  *)
    echo "↷ ${CATEGORY}/${ECOSYSTEM}: no fixture (build-only); skipping runtime smoke test."
    exit 0
    ;;
esac

# Expected output file per category.
if [ "$CATEGORY" = "sbom" ]; then
  EXPECTED="bom.json"
else
  case "$ECOSYSTEM" in
    npm)    EXPECTED="package-lock.json" ;;
    pip)    EXPECTED="requirements-locked.txt" ;;
    uv)     EXPECTED="uv.lock" ;;
    poetry) EXPECTED="poetry.lock" ;;
  esac
fi

echo "▶ smoke-testing ${CATEGORY}/${ECOSYSTEM} (image: ${IMAGE_REF}) → expects ${EXPECTED}"

# Work on a writable copy of the fixture: several examples write the generated
# lockfile back into the workspace. World-writable so the container's non-root
# semgrep user (uid 1000) can write to the bind mounts regardless of host owner.
WORKDIR="$(mktemp -d)"
OUTDIR="$(mktemp -d)"
cleanup() { rm -rf "$WORKDIR" "$OUTDIR"; }
trap cleanup EXIT

cp -R "${FIXTURE}/." "$WORKDIR/"
chmod -R 0777 "$WORKDIR" "$OUTDIR"

docker run --rm \
  -v "${WORKDIR}:/semgrep/workspace" \
  -v "${OUTDIR}:/semgrep/outputs" \
  "$IMAGE_REF"

OUT_FILE="${OUTDIR}/${EXPECTED}"
if [ ! -s "$OUT_FILE" ]; then
  echo "✗ expected non-empty output ${EXPECTED} was not produced" >&2
  echo "  outputs directory contained:" >&2
  ls -la "$OUTDIR" >&2 || true
  exit 1
fi

# bom.json must be valid JSON.
if [ "$EXPECTED" = "bom.json" ]; then
  if ! jq -e . "$OUT_FILE" >/dev/null 2>&1; then
    echo "✗ ${EXPECTED} is not valid JSON" >&2
    exit 1
  fi
fi

echo "✓ ${CATEGORY}/${ECOSYSTEM}: produced $(wc -c < "$OUT_FILE") bytes of ${EXPECTED}"
