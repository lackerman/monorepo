# Run the monorepo

Help with Java and Maven dependency management using the rules_jvm_external

<https://github.com/bazelbuild/rules_jvm_external#pinning-artifacts-and-integration-with-bazels-downloader>

Pin the maven dependencies
```shell script
bazel run @maven//:pin
```

Whenever you make a change to the list of `artifacts` or `repositories` and want to update 
`maven_install.json`, run the following command to re-pin the unpinned @maven repository:

```shell script
bazel run @unpinned_maven//:pin
```

yarn install
```shell script
bazel run @nodejs//:yarn_node_repositories
```

add npm dev dependency
```shell script
bazel run @nodejs//:yarn -- add -D @bazel/ibazel
```

to build a fat jar with bazel, you need to add `_deploy.jar` suffix to the 
`java_binary` target name. The final jar will be named `target_name_deploy.jar`.
```shell script
bazel run //bookmarker/server/src/main/java/me/a6n/bookmarker:micronaut_deploy.jar
```

Load a `container_image` into docker
```shell script
bazel run //bookmarker:server_image
```

[Install bazelwatcher](https://github.com/bazelbuild/bazel-watcher#mac-homebrew)
```shell script
brew tap bazelbuild/tap
brew install bazelbuild/tap/ibazel
```

[bazel query cheatsheet](https://gist.github.com/natlownes/f34aef5dabc37e645f8b8dc8892e80b2)

## Troubleshooting

### [Error: `Failed to initialize sandbox: getconf failed`](https://github.com/bazelbuild/bazel/issues/7692)

Run `bazel shutdown`

### `.../bin/external/maven/pin: line 10: external/maven/jq: No such file or directory`

A workaround for this is to edit the file and set the full path of `jq`, delete the empty
`maven_install.json` file and run it again...EVERY TIME I add a new dependency