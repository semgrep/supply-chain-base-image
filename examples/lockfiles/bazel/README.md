# Bazel Lockfile Generator

Generates a `MODULE.bazel.lock` from a project's `MODULE.bazel` using `bazel mod deps`.

Uses [Bazelisk](https://github.com/bazelbuild/bazelisk) to automatically download the correct Bazel version for your project (reads `.bazelversion` if present).

## Build

```bash
docker build -t lockfile-bazel .
```

## Run

Mount a directory containing a `MODULE.bazel`:

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  lockfile-bazel
```

The generated `MODULE.bazel.lock` will be written to the outputs directory.
