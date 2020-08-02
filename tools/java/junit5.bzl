"""
Credit to @bmuschko see https://github.com/bmuschko/bazel-examples/tree/master/java/junit5-test
Creates a new rule, 'java_junit5_test', that allows you to use junit5 using based on teh default java_test rule
"""

load("@rules_java//java:defs.bzl", "java_test")

def java_junit5_test(name, srcs, test_package, deps = [], runtime_deps = [], **kwargs):
    """
    java_junit5_test

    Args:
        name:
        srcs:
        test_package:
        deps:
        runtime_deps:
        **kwargs:
    """
    FILTER_KWARGS = [
        "main_class",
        "use_testrunner",
        "args",
    ]

    for arg in FILTER_KWARGS:
        if arg in kwargs.keys():
            kwargs.pop(arg)

    junit_console_args = []
    if test_package:
        junit_console_args += ["--select-package", test_package]
    else:
        fail("must specify 'test_package'")

    native.java_test(
        name = name,
        srcs = srcs,
        use_testrunner = False,
        main_class = "org.junit.platform.console.ConsoleLauncher",
        args = junit_console_args,
        deps = deps + [
            "@maven//:org_junit_jupiter_junit_jupiter_api",
            "@maven//:org_junit_jupiter_junit_jupiter_params",
            "@maven//:org_junit_jupiter_junit_jupiter_engine",
        ],
        runtime_deps = runtime_deps + [
            "@maven//:org_junit_platform_junit_platform_console",
        ],
        **kwargs
    )
