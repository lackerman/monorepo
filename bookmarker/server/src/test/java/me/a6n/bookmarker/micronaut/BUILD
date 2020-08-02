load("//tools/java:junit5.bzl", "java_junit5_test")

java_junit5_test(
    name = "micronaut_tests",
    timeout = "short",
    srcs = glob([
        "*.java",
    ]),
    test_package = "me.a6n.bookmarker.micronaut",
    deps = [
        "//bookmarker/server/src/main/java/me/a6n/bookmarker:micronaut_lib",
    ],
)
