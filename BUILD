load("@com_github_bazelbuild_buildtools//buildifier:def.bzl", "buildifier")

buildifier(
    name = "buildifier",
)

# Add rules here to build your software
# See https://docs.bazel.build/versions/master/build-ref.html#BUILD_files

# Allow any ts_library rules in this workspace to reference the config
# Note: if you move the tsconfig.json file to a subdirectory, you can add an alias() here instead
#   so that ts_library rules still use it by default.
#   See https://www.npmjs.com/package/@bazel/typescript#installation
exports_files(
    [
        "tsconfig.json",
    ],
    # https://docs.bazel.build/versions/master/skylark/build-style.html#visibility
    visibility = ["//:__subpackages__"],
)
