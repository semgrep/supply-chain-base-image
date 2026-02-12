# npm Lockfile Generator

Generates a `package-lock.json` from a project's `package.json` without installing `node_modules`.

## Build

```bash
docker build -t lockfile-npm .
```

## Run

Mount a directory containing a `package.json`:

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  lockfile-npm
```

The generated `package-lock.json` will be written to the outputs directory.
