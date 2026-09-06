load("@aspect_rules_ts//ts:defs.bzl", "ts_config")
load("@bazel_gazelle//:def.bzl", "gazelle")
load("@buildifier_prebuilt//:rules.bzl", "buildifier")
load("@npm//:defs.bzl", "npm_link_all_packages")

npm_link_all_packages(name = "node_modules")

buildifier(
    name = "buildifier",
)

# Add rules here to build your software
# See https://docs.bazel.build/versions/master/build-ref.html#BUILD_files

# Allow any ts_project rules in this workspace to reference the config by
# depending on `//:tsconfig`.
ts_config(
    name = "tsconfig",
    src = "tsconfig.json",
    visibility = ["//:__subpackages__"],
)

# gazelle:prefix github.com/lackerman
gazelle(
    name = "gazelle",
)
