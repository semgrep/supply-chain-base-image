# Gradle Lockfile Generator

Generates a `gradle.lockfile` from a project's `build.gradle` using `gradle dependencies --write-locks`.

## Build

```bash
docker build -t lockfile-gradle .
```

## Run

Mount a directory containing a `build.gradle` or `build.gradle.kts`:

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  lockfile-gradle
```

The generated `gradle.lockfile` will be written to the outputs directory.
