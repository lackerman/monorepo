load("@rules_multirun//:defs.bzl", "command", "multirun")
load("@rules_oci//oci:defs.bzl", "oci_image", "oci_push")
load("@rules_pkg//pkg:tar.bzl", "pkg_tar")

pkg_tar(
    name = "server_layer",
    srcs = [
        "//bookmarker/server/src/main/java/me/a6n/bookmarker:app_deploy.jar",
    ],
    package_dir = "/app",
)

oci_image(
    name = "server_image",
    base = "@java11_arm",
    entrypoint = [
        "java",
        "-jar",
        "/app/app_deploy.jar",
    ],
    exposed_ports = ["8080/tcp"],
    tars = [":server_layer"],
    workdir = "/app",
)

oci_push(
    name = "server_image_push",
    image = ":server_image",
    remote_tags = ["0.0.1-alpha-1"],
    repository = "docker.pkg.github.com/lackerman/monorepo/bookmarker_server",
)

command(
    name = "client",
    command = "//bookmarker/client/src:devserver",
)

command(
    name = "server",
    command = "//bookmarker/server/src/main/java/me/a6n/bookmarker:app",
)

multirun(
    name = "bookmarker",
    commands = [
        ":client",
        ":server",
    ],
    parallel = True,
)
