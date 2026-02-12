# pip Lockfile Generator

Generates a `requirements-locked.txt` with pinned versions and a `pip-report.json` install report from a project's `requirements.txt`.

## Build

```bash
docker build -t lockfile-pip .
```

## Run

Mount a directory containing a `requirements.txt`:

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  lockfile-pip
```

The generated `requirements-locked.txt` and `pip-report.json` will be written to the outputs directory.
