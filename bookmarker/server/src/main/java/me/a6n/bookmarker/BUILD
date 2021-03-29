load("@rules_java//java:defs.bzl", "java_binary", "java_library")

java_library(
    name = "micronaut_lib",
    srcs = glob([
        "bookmarks/*.java",
        "micronaut/*.java",
    ]),
    visibility = [
        "//bookmarker/server/src/test/java/me/a6n/bookmarker:__subpackages__",
    ],
    deps = [
        # Annotation Processors
        "//tools/java:lombok_lib",
        "//tools/java:io_micronaut_annotation_lib",
        # Common javax annotations
        "@maven//:javax_inject_javax_inject",
        "@maven//:com_github_spotbugs_spotbugs_annotations",
        "@maven//:com_google_code_findbugs_jsr305",
        # Micronaut core
        "@maven//:io_micronaut_micronaut_core",
        "@maven//:io_micronaut_micronaut_runtime",
        # Micronaut server
        "@maven//:io_micronaut_micronaut_http",
        "@maven//:io_micronaut_micronaut_http_server_netty",
        # Micronaut Client
        "@maven//:io_micronaut_micronaut_http_client_core",
        "@maven//:io_micronaut_micronaut_http_client",
        "@maven//:io_reactivex_rxjava2_rxjava",
        # Micronaut Data & SQL requirements
        "@maven//:io_micronaut_data_micronaut_data_processor",
        "@maven//:io_micronaut_data_micronaut_data_model",
        "@maven//:io_micronaut_data_micronaut_data_jdbc",
        # JPA annotations
        "@maven//:jakarta_persistence_jakarta_persistence_api",
        # HTML parsing
        "@maven//:org_jsoup_jsoup",
    ],
)

java_binary(
    name = "app",
    jvm_flags = [
        "--add-opens java.base/jdk.internal.misc=ALL-UNNAMED",
        "-Dio.netty.tryReflectionSetAccessible=true",
    ],
    main_class = "me.a6n.bookmarker.micronaut.App",
    resource_strip_prefix = "bookmarker/server/src/main/resources",
    resources = [
        "//bookmarker/server/src/main/resources",
    ],
    visibility = [
        "//visibility:public",
    ],
    runtime_deps = [
        ":micronaut_lib",
        "@maven//:ch_qos_logback_logback_classic",
        "@maven//:com_h2database_h2",
        "@maven//:io_micronaut_sql_micronaut_jdbc_hikari",
    ],
)
