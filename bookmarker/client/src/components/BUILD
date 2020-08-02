load("@npm//@bazel/typescript:index.bzl", "ts_library")

ts_library(
    name = "components",
    srcs = glob(["*.tsx"]),
    tsconfig = "//:tsconfig.json",
    visibility = [
        "//bookmarker/client/src:__subpackages__",
    ],
    deps = [
        "@npm//@types/react",
        "@npm//@types/react-dom",
        "@npm//react",
        "@npm//react-dom",
        "@npm//typescript",
    ],
)
