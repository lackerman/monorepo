# Run the monorepo

External dependencies are declared in `MODULE.bazel` using Bazel's Bzlmod
system (see `REPORT.md` for background on the Bazel upgrade).

## Java / Maven

Dependency resolution for the JVM projects is handled by
[rules_jvm_external](https://github.com/bazelbuild/rules_jvm_external#exporting-and-consuming-artifacts-for-use-in-other-workspaces).

Pin the Maven dependencies (creates/updates the `maven_install.json` lock file):
```shell script
bazel run @maven//:pin
```

To build a fat jar with Bazel, add the `_deploy.jar` suffix to a `java_binary`
target name. The final jar is named `<target_name>_deploy.jar`:
```shell script
bazel run //bookmarker/server/src/main/java/me/a6n/bookmarker:app_deploy.jar
```

## TypeScript / React client

Dependencies are declared in `package.json`, but Bazel resolves them from
`pnpm-lock.yaml` via [aspect_rules_js](https://github.com/aspect-build/rules_js)
(it needs a pnpm lock file). After editing `package.json`, regenerate it:
```shell script
corepack enable
corepack prepare pnpm@9 --activate
pnpm install --lockfile-only
```
CI also does this on every push (and commits the result back) so the
lockfile can't drift out of sync with `package.json` for long, but running
it locally keeps `bazel build`/`bazel test` working on your own branch in
the meantime.

Run the client dev server:
```shell script
bazel run //bookmarker/client/src:devserver
```

## Container image

Build the server's OCI image with
[rules_oci](https://github.com/bazel-contrib/rules_oci):
```shell script
bazel build //bookmarker:server_image
```

## Run everything at once

```shell script
bazel run //bookmarker:bookmarker
```

[bazel query cheatsheet](https://gist.github.com/natlownes/f34aef5dabc37e645f8b8dc8892e80b2)

## Troubleshooting

### [Error: `Failed to initialize sandbox: getconf failed`](https://github.com/bazelbuild/bazel/issues/7692)

Run `bazel shutdown`
