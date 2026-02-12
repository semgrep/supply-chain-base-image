# Maven Dependency Tree Generator

Generates a `dependency-tree.txt` from a project's `pom.xml` using `mvn dependency:tree`.

## Build

```bash
docker build -t lockfile-maven .
```

## Run

Mount a directory containing a `pom.xml`:

```bash
docker run --rm \
  -v "$(pwd):/semgrep/workspace" \
  -v "./outputs:/semgrep/outputs" \
  lockfile-maven
```

The generated `dependency-tree.txt` will be written to the outputs directory.
