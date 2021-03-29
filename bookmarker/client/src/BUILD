package(default_visibility = ["//visibility:public"])

load("@npm//@bazel/rollup:index.bzl", "rollup_bundle")
load("@npm//@bazel/typescript:index.bzl", "ts_devserver", "ts_library")
load("@npm//http-server:index.bzl", "http_server")

exports_files(
    ["rollup.config.js"],
    visibility = ["//visibility:public"],
)

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
        "@npm//lodash",
        "@npm//react",
        "@npm//react-dom",
        "@npm//typescript",
    ],
)

ts_devserver(
    name = "devserver",
    entry_module = "monorepo/bookmarker/client/src/index",
    port = 3000,
    serving_path = "/bundle.js",
    static_files = [
        ":static_files",
    ],
    deps = [
        ":bookmarker_lib",
        "@npm//lodash:lodash__umd",
        "@npm//react:react__umd",
        "@npm//react-dom:react-dom__umd",
    ],
)

rollup_bundle(
    name = "bundle",
    srcs = [
        ":bookmarker_lib",
    ],
    entry_point = "index.tsx",
    format = "iife",
    deps = [
        ":bookmarker_lib",
    ],
)

filegroup(
    name = "static_files",
    srcs = [
        "index.html",
        "public/favicon.ico",
        "public/index.css",
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
    templated_args = [
        "-p",
        "3000",
        "./bookmarker/client/src/",
    ],
)
