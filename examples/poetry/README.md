# Poetry Lockfile Generator

Generates a `poetry.lock` from a project's `pyproject.toml` using `poetry lock`.

## Build

```bash
docker build -t lockfile-poetry .
```

## Run

Mount a directory containing a `pyproject.toml` with Poetry-style dependencies:

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  lockfile-poetry
```

The generated `poetry.lock` will be written to the outputs directory.
