load("@npm//@bazel/typescript:index.bzl", "ts_library")

ts_library(
    name = "lib",
    srcs = glob(["*.ts"]),
    tsconfig = "//:tsconfig.json",
    visibility = [
        "//bookmarker/client/src:__subpackages__",
    ],
)
