package(default_visibility = ["//visibility:public"])

load("@npm//@bazel/rollup:index.bzl", "rollup_bundle")
load("@npm//@bazel/typescript:index.bzl", "ts_devserver", "ts_library")
load("@npm//http-server:index.bzl", "http_server")

exports_files(["rollup.config.js"], visibility = ["//visibility:public"])

ts_library(
    name = "bookmarker_lib",
    srcs = [
        "App.tsx",
        "index.tsx",
    ],
    tsconfig = "//:tsconfig.json",
    deps = [
        "//bookmarker/client/src/components",
        "//bookmarker/client/src/lib",
        "@npm//@types/lodash",
        "@npm//@types/react",
        "@npm//@types/react-dom",
        "@npm//react",
        "@npm//react-dom",
        "@npm//typescript",
        "@npm//lodash",
    ],
)

ts_devserver(
    name = "devserver",
    port = 3000,
    entry_module = "monorepo/bookmarker/client/src/index",
    serving_path = "/bundle.js",
    static_files = [
        ":static_files"
    ],
    deps = [
        ":bookmarker_lib",
        "@npm//lodash:lodash__umd",
        "@npm//react:react__umd",
        "@npm//react-dom:react-dom__umd"
    ],
)

rollup_bundle(
    name = "bundle",
    entry_point = "index.tsx",
    format = "iife",
    srcs = [
        ":bookmarker_lib"
    ],
    deps = [
        ":bookmarker_lib",
    ],
)

filegroup(
    name = "static_files",
    srcs = [
        "index.html",
        "public/index.css",
        "public/favicon.ico",
        "public/manifest.json",
    ],
)

# Production resources validation
http_server(
    name = "server",
    data = [
        "bundle.js",
        ":static_files",
    ],
    templated_args = ["-p", "3000", "./bookmarker/client/src/"],
)
