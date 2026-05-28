# sbt Lockfile Generator

Generates a `build.sbt.lock` from an sbt project using the [`sbt-dependency-lock`](https://github.com/software-purpledragon/sbt-dependency-lock) plugin (added as a global plugin, no changes to `build.sbt` required).

## Build

```bash
docker build -t lockfile-sbt .
```

## Run

Mount a directory containing a `build.sbt`:

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  lockfile-sbt
```

The generated `build.sbt.lock` will be written to the outputs directory.
