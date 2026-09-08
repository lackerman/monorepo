package(default_visibility = ["//visibility:public"])

load("@aspect_rules_esbuild//esbuild:defs.bzl", "esbuild")
load("@aspect_rules_ts//ts:defs.bzl", "ts_project")
load("@npm//:node_modules/http-server/package_json.bzl", http_server_bin = "bin")

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

# Serves the bundled client, either for local development (`bazel run`) or
# as a production smoke check of the built assets.
http_server_bin.http_server_binary(
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
)
