package(default_visibility = ["//visibility:public"])

load("@aspect_bazel_lib//lib:directory_path.bzl", "directory_path")
load("@aspect_rules_esbuild//esbuild:defs.bzl", "esbuild")
load("@aspect_rules_js//js:defs.bzl", "js_binary")
load("@aspect_rules_ts//ts:defs.bzl", "ts_project")

ts_project(
    name = "bookmarker_lib",
    srcs = [
        "App.tsx",
        "index.tsx",
    ],
    declaration = False,
    tsconfig = "//:tsconfig",
    deps = [
        "//bookmarker/client/src/components",
        "//bookmarker/client/src/lib",
        "//:node_modules/@types/lodash",
        "//:node_modules/@types/react",
        "//:node_modules/@types/react-dom",
        "//:node_modules/lodash",
        "//:node_modules/react",
        "//:node_modules/react-dom",
    ],
)

esbuild(
    name = "bundle",
    srcs = [":bookmarker_lib"],
    entry_point = "index.js",
    format = "iife",
    output = "bundle.js",
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

directory_path(
    name = "http_server_bin",
    directory = "//:node_modules/http-server",
    path = "bin/http-server",
)

# Serves the bundled client, either for local development (`bazel run`) or
# as a production smoke check of the built assets.
js_binary(
    name = "devserver",
    args = [
        "-p",
        "3000",
        "./bookmarker/client/src/",
    ],
    data = [
        ":bundle",
        ":static_files",
    ],
    entry_point = ":http_server_bin",
)
