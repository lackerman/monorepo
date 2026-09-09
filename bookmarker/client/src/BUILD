package(default_visibility = ["//visibility:public"])

load("@aspect_rules_esbuild//esbuild:defs.bzl", "esbuild")
load("@aspect_rules_js//js:defs.bzl", "js_binary")
load("@aspect_rules_ts//ts:defs.bzl", "ts_project")

# components/ and lib/ have no BUILD files of their own -- App.tsx imports
# from them by plain relative path, and ts_project resolving that across a
# Bazel package boundary (as separate ts_project deps) needs more than
# rules_ts's default cross-project wiring gives us. Compiling everything as
# one TypeScript project sidesteps that entirely.
ts_project(
    name = "bookmarker_lib",
    srcs = glob([
        "*.tsx",
        "components/*.tsx",
        "lib/*.ts",
    ]),
    transpiler = "tsc",
    tsconfig = "//:tsconfig",
    deps = [
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
js_binary(
    name = "devserver",
    args = [
        "3000",
        "bookmarker/client/src",
    ],
    data = [
        ":bundle",
        ":static_files",
    ],
    entry_point = "serve.js",
)
