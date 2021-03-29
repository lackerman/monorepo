"""
Extension to retrieve external jvm rules
https://github.com/bazelbuild/rules_jvm_external
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

RULES_JVM_EXTERNAL_VERSION = "3.3"
RULES_JVM_EXTERNAL_SHA = "d85951a92c0908c80bd8551002d66cb23c3434409c814179c0ff026b53544dab"

RULES_NODEJS_VERSION = "2.0.1"
RULES_NODEJS_SHA = "0f2de53628e848c1691e5729b515022f5a77369c76a09fbe55611e12731c90e3"

RULES_GO_VERSION = "0.27.0"
RULES_GO_SHA = "69de5c704a05ff37862f7e0f5534d4f479418afc21806c887db544a316f3cb6b"

RULES_GAZELLE_VERSION = "0.23.0"
RULES_GAZELLA_SHA = "62ca106be173579c0a167deb23358fdfe71ffa1e4cfdddf5582af26520f1c66f"

RULES_PROTOBUF_VERSION = "3.11.4"
RULES_PROTOBUF_SHA = "9748c0d90e54ea09e5e75fb7fac16edce15d2028d4356f32211cfa3c0e956564"

RULES_SASS_VERSION = "1.26.3"
RULES_SASS_SHA = "9dcfba04e4af896626f4760d866f895ea4291bc30bf7287887cefcf4707b6a62"

RULES_DOCKER_SHA = "4521794f0fba2e20f3bf15846ab5e01d5332e587e9ce81629c7f96c793bb7036"
RULES_DOCKER_VERSION = "0.14.4"

RULES_BUILD_TOOLS_VERSION = "3.4.0"
RULES_BUILD_TOOLS_SHA = "a5fca3f810588b441a647cf601a42ca98a75aa0681c2e9ade3ce9187d47b506e"

RULES_SKYLIB_VERSION = "1.0.2"
RULES_SKYLIB_TOOLS_SHA = "97e70364e9249702246c0e9444bccdc4b847bed1eb03c5a3ece4f83dfe6abc44"

def external_rules():
    http_archive(
        name = "rules_jvm_external",
        sha256 = RULES_JVM_EXTERNAL_SHA,
        strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_VERSION,
        url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_VERSION,
    )

    http_archive(
        name = "build_bazel_rules_nodejs",
        sha256 = RULES_NODEJS_SHA,
        url = "https://github.com/bazelbuild/rules_nodejs/releases/download/{version}/rules_nodejs-{version}.tar.gz".format(version = RULES_NODEJS_VERSION),
    )

    http_archive(
        name = "io_bazel_rules_go",
        sha256 = RULES_GO_SHA,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v{version}/rules_go-v{version}.tar.gz".format(
                version = RULES_GO_VERSION,
            ),
            "https://github.com/bazelbuild/rules_go/releases/download/v{version}/rules_go-v{version}.tar.gz".format(
                version = RULES_GO_VERSION,
            ),
        ],
    )

    http_archive(
        name = "bazel_gazelle",
        sha256 = RULES_GAZELLA_SHA,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v{version}/bazel-gazelle-v{version}.tar.gz".format(
                version = RULES_GAZELLE_VERSION,
            ),
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v{version}/bazel-gazelle-v{version}.tar.gz".format(
                version = RULES_GAZELLE_VERSION,
            ),
        ],
    )

    http_archive(
        name = "com_google_protobuf",
        sha256 = RULES_PROTOBUF_SHA,
        strip_prefix = "protobuf-%s" % RULES_PROTOBUF_VERSION,
        url = "https://github.com/protocolbuffers/protobuf/archive/v%s.zip" % RULES_PROTOBUF_VERSION,
    )

    http_archive(
        name = "io_bazel_rules_sass",
        sha256 = RULES_SASS_SHA,
        strip_prefix = "rules_sass-%s" % RULES_SASS_VERSION,
        url = "https://github.com/bazelbuild/rules_sass/archive/%s.zip" % RULES_SASS_VERSION,
    )

    http_archive(
        name = "io_bazel_rules_docker",
        sha256 = RULES_DOCKER_SHA,
        strip_prefix = "rules_docker-%s" % RULES_DOCKER_VERSION,
        urls = [
            "https://github.com/bazelbuild/rules_docker/releases/download/v{version}/rules_docker-v{version}.tar.gz".format(
                version = RULES_DOCKER_VERSION,
            ),
        ],
    )

    http_archive(
        name = "com_github_bazelbuild_buildtools",
        sha256 = RULES_BUILD_TOOLS_SHA,
        strip_prefix = "buildtools-%s" % RULES_BUILD_TOOLS_VERSION,
        url = "https://github.com/bazelbuild/buildtools/archive/%s.zip" % RULES_BUILD_TOOLS_VERSION,
    )

    # Used to perform multirun to execute multiple targets at the same time
    git_repository(
        name = "com_github_atlassian_bazel_tools",
        commit = "936325de16966d259eee3f309f8578b761cfc874",
        shallow_since = "1586491416 +1000",
        remote = "https://github.com/atlassian/bazel-tools.git",
    )

    # Skylib is a standard library that provides functions useful for manipulating collections,
    # file paths, and other features that are useful when writing custom build rules in Bazel.
    http_archive(
        name = "bazel_skylib",
        sha256 = RULES_SKYLIB_TOOLS_SHA,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/{version}/bazel-skylib-{version}.tar.gz".format(
                version = RULES_SKYLIB_VERSION,
            ),
            "https://github.com/bazelbuild/bazel-skylib/releases/download/{version}/bazel-skylib-{version}.tar.gz".format(
                version = RULES_SKYLIB_VERSION,
            ),
        ],
    )
