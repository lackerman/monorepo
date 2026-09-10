package(default_visibility = ["//visibility:public"])

load("@rules_java//java:defs.bzl", "java_library", "java_plugin")
load("@rules_java//toolchains:default_java_toolchain.bzl", "default_java_toolchain")

# rules_java's built-in default_java_toolchain always compiles with JDK 25
# (its java_runtime is hardcoded, independent of --java_runtime_version --
# see rules_java's own toolchains/default_java_toolchain.bzl), which Lombok
# doesn't support: annotation processing crashes with a
# NoSuchFieldException on internal javac types. Register our own copy of
# that toolchain with JDK 21 -- an LTS release Lombok fully supports -- for
# the same java_language_version=11 target level. See MODULE.bazel's
# register_toolchains() call.
default_java_toolchain(
    name = "toolchain",
    java_runtime = "@rules_java//toolchains:remotejdk_21",
)

java_plugin(
    name = "lombok_plugin",
    processor_class = "lombok.launch.AnnotationProcessorHider$AnnotationProcessor",
    deps = [
        "@maven//:org_projectlombok_lombok",
    ],
)

java_library(
    name = "lombok_lib",
    exported_plugins = ["lombok_plugin"],
    visibility = ["//visibility:public"],
    exports = [
        "@maven//:org_projectlombok_lombok",
    ],
)

java_plugin(
    name = "io_micronaut_type_element_visitor_processor",
    generates_api = True,
    processor_class = "io.micronaut.annotation.processing.TypeElementVisitorProcessor",
    deps = [
        "@maven//:io_micronaut_micronaut_aop",
        "@maven//:io_micronaut_micronaut_inject",
        "@maven//:io_micronaut_micronaut_inject_java",
        "@maven//:io_micronaut_micronaut_validation",
    ],
)

java_plugin(
    name = "io_micronaut_aggregating_type_element_visitor_processor",
    generates_api = True,
    processor_class = "io.micronaut.annotation.processing.AggregatingTypeElementVisitorProcessor",
    deps = [
        "@maven//:io_micronaut_micronaut_aop",
        "@maven//:io_micronaut_micronaut_inject",
        "@maven//:io_micronaut_micronaut_inject_java",
        "@maven//:io_micronaut_micronaut_validation",
    ],
)

java_plugin(
    name = "io_micronaut_package_configuration_inject_processor",
    generates_api = True,
    processor_class = "io.micronaut.annotation.processing.PackageConfigurationInjectProcessor",
    deps = [
        "@maven//:io_micronaut_micronaut_aop",
        "@maven//:io_micronaut_micronaut_inject",
        "@maven//:io_micronaut_micronaut_inject_java",
        "@maven//:io_micronaut_micronaut_validation",
    ],
)

java_plugin(
    name = "io_micronaut_bean_definition_inject_processor",
    generates_api = True,
    processor_class = "io.micronaut.annotation.processing.BeanDefinitionInjectProcessor",
    deps = [
        "@maven//:io_micronaut_micronaut_aop",
        "@maven//:io_micronaut_micronaut_inject",
        "@maven//:io_micronaut_micronaut_inject_java",
        "@maven//:io_micronaut_micronaut_validation",
    ],
)

java_plugin(
    name = "io_micronaut_service_description_processor",
    generates_api = True,
    processor_class = "io.micronaut.annotation.processing.ServiceDescriptionProcessor",
    deps = [
        "@maven//:io_micronaut_micronaut_aop",
        "@maven//:io_micronaut_micronaut_inject",
        "@maven//:io_micronaut_micronaut_inject_java",
        "@maven//:io_micronaut_micronaut_validation",
    ],
)

java_plugin(
    name = "io_micronaut_data_micronaut_data_processor",
    generates_api = True,
    deps = [
        "@maven//:io_micronaut_data_micronaut_data_processor",
        "@maven//:io_micronaut_micronaut_aop",
        "@maven//:io_micronaut_micronaut_inject",
        "@maven//:io_micronaut_micronaut_inject_java",
        "@maven//:io_micronaut_micronaut_validation",
    ],
)

java_library(
    name = "io_micronaut_annotation_lib",
    exported_plugins = [
        "io_micronaut_data_micronaut_data_processor",
        "io_micronaut_type_element_visitor_processor",
        "io_micronaut_aggregating_type_element_visitor_processor",
        "io_micronaut_package_configuration_inject_processor",
        "io_micronaut_bean_definition_inject_processor",
        "io_micronaut_service_description_processor",
    ],
    visibility = ["//visibility:public"],
    exports = [
        "@maven//:io_micronaut_data_micronaut_data_processor",
        "@maven//:io_micronaut_micronaut_aop",
        "@maven//:io_micronaut_micronaut_inject",
        "@maven//:io_micronaut_micronaut_inject_java",
        "@maven//:io_micronaut_micronaut_validation",
    ],
)
