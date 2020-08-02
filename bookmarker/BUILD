load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_push")
load("@com_github_atlassian_bazel_tools//multirun:def.bzl", "command", "multirun")

container_image(
    name = "server_image",
    base = "@java11_arm//image",
    entrypoint = ["java", "-jar", "/app/app_deploy.jar"],
    directory = "/app",
    files = [
        "//bookmarker/server/src/main/java/me/a6n/bookmarker:app_deploy.jar",
    ],
    workdir = "/app",
    ports = [
        "8080/tcp",
    ]
)

container_push(
  name = "server_image_push",
  format = "Docker",
  image = ":server_image",
  registry = "docker.pkg.github.com",
  repository = "lackerman/monorepo/bookmarker_server",
  tag = "0.0.1-alpha-1"
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
