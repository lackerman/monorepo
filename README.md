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

Dependencies come from `yarn.lock` via
[aspect_rules_js](https://github.com/aspect-build/rules_js). After editing
`package.json`, refresh the lock file the normal way:
```shell script
yarn install
```

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
