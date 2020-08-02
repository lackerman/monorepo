# Declares that this directory is the root of a Bazel workspace.
# See https://docs.bazel.build/versions/master/build-ref.html#workspace
workspace(
    # How this workspace would be referenced with absolute labels from another workspace
    name = "monorepo",
    # Map the @npm bazel workspace to the node_modules directory.
    # This lets Bazel use the same node_modules as other local tooling.
    managed_directories = {"@npm": ["node_modules"]},
)

#######################################
# External bazel rules
#######################################

load("//tools:external_rules.bzl", "external_rules")

external_rules()

#######################################
# Java dependencies
#######################################

load("//tools/java:maven.bzl", "setup_maven")

setup_maven()

# Lock/pin the Maven dependencies for reproducible builds.
load("@maven//:defs.bzl", "pinned_maven_install")

pinned_maven_install()

#######################################
# TYPESCRIPT / NODEJS SUPPORT
#######################################

load("@build_bazel_rules_nodejs//:index.bzl", "node_repositories", "yarn_install")

# Setup Bazel managed npm dependencies with the `yarn_install` rule.
# The name of this rule should be set to `npm` so that `ts_library` and `ts_web_test_suite`
# can find your npm dependencies by default in the `@npm` workspace. You may
# also use the `npm_install` rule with a `package-lock.json` file if you prefer.
# See https://github.com/bazelbuild/rules_nodejs#dependencies for more info.
yarn_install(
    # Name this npm so that Bazel Label references look like @npm//package
    name = "npm",
    package_json = "//:package.json",
    symlink_node_modules = True,
    use_global_yarn_cache = False,
    yarn_lock = "//:yarn.lock",
)

#######################################
# GO SUPPORT
#######################################

# buildifier is written in Go and hence needs rules_go to be built.
# See https://github.com/bazelbuild/rules_go for the up to date setup instructions.

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

#######################################
# SASS SUPPORT
#######################################

# Fetch required transitive dependencies. This is an optional step because you
# can always fetch the required NodeJS transitive dependency on your own.
load("@io_bazel_rules_sass//:package.bzl", "rules_sass_dependencies")

rules_sass_dependencies()

# Setup repositories which are needed for the Sass rules.
load("@io_bazel_rules_sass//:defs.bzl", "sass_repositories")

sass_repositories()

#######################################
# DOCKER
#######################################

load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load("@io_bazel_rules_docker//repositories:pip_repositories.bzl", "pip_deps")

pip_deps()

load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

container_pull(
  name = "java11_arm",
  registry = "index.docker.io",
  repository = "library/openjdk",
  tag = "latest",
)

#######################################
# UTILITIES
#######################################

load("@com_github_bazelbuild_buildtools//buildifier:deps.bzl", "buildifier_dependencies")

buildifier_dependencies()

load("@com_github_atlassian_bazel_tools//multirun:deps.bzl", "multirun_dependencies")

multirun_dependencies()
