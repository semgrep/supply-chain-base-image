# uv Lockfile Generator

Generates a `uv.lock` from a project's `pyproject.toml` using `uv lock`.

## Build

```bash
docker build -t lockfile-uv .
```

## Run

Mount a directory containing a `pyproject.toml`:

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  lockfile-uv
```

The generated `uv.lock` will be written to the outputs directory.
