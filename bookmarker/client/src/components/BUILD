load("@aspect_rules_ts//ts:defs.bzl", "ts_project")

ts_project(
    name = "components",
    srcs = glob(["*.tsx"]),
    declaration = False,
    tsconfig = "//:tsconfig",
    visibility = [
        "//bookmarker/client/src:__subpackages__",
    ],
    deps = [
        "//:node_modules/@types/react",
        "//:node_modules/@types/react-dom",
        "//:node_modules/react",
        "//:node_modules/react-dom",
    ],
)
