"""
Sets up the default dependencies to be used in the monorepo
"""

load("@rules_jvm_external//:defs.bzl", "maven_install")

def setup_maven():
    maven_install(
        name = "maven",
        artifacts = [
            # Logging dependencies
            "ch.qos.logback:logback-classic:1.2.3",
            # Lombok dependencies
            "org.projectlombok:lombok:1.18.12",
            # @Inject dependency
            "javax.inject:javax.inject:1",
            # Google Findbugs - needed for Data resolution
            "com.google.code.findbugs:jsr305:3.0.2",
            # Github Findbugs - needed for micronaut core
            "com.github.spotbugs:spotbugs-annotations:4.0.6",
            # Micronaut dependencies
            "io.micronaut:micronaut-aop:2.0.1",
            "io.micronaut:micronaut-core:2.0.1",
            "io.micronaut:micronaut-http:2.0.1",
            "io.micronaut:micronaut-http-client-core:2.0.1",
            "io.micronaut:micronaut-http-client:2.0.1",
            "io.micronaut:micronaut-http-server-netty:2.0.1",
            "io.micronaut:micronaut-inject:2.0.1",
            "io.micronaut:micronaut-inject-java:2.0.1",
            "io.micronaut:micronaut-runtime:2.0.1",
            "io.micronaut:micronaut-validation:2.0.1",
            # Micronaut deps
            "io.reactivex.rxjava2:rxjava:2.2.10",
            # Database
            "jakarta.persistence:jakarta.persistence-api:2.2.2",
            "io.micronaut.data:micronaut-data-model:1.1.3",
            "io.micronaut.data:micronaut-data-jdbc:1.1.3",
            "io.micronaut.data:micronaut-data-tx:1.1.3",
            "io.micronaut.data:micronaut-data-processor:1.1.3",
            "io.micronaut.data:micronaut-data-hibernate-jpa:1.1.3",
            "io.micronaut.sql:micronaut-jdbc-hikari:2.3.9",
            "com.h2database:h2:1.4.200",
            # Micronaut Testing dependencies
            "io.micronaut.test:micronaut-test-junit5:1.2.0",
            "io.micronaut.test:micronaut-test-core:1.2.0",
            # JUnit 5 dependencies
            "org.junit.jupiter:junit-jupiter-api:5.6.2",
            "org.junit.jupiter:junit-jupiter-params:5.6.2",
            "org.junit.jupiter:junit-jupiter-engine:5.6.2",
            "org.junit.platform:junit-platform-console:1.4.2",
            # Parse HTML
            "org.jsoup:jsoup:1.13.1",
        ],
        repositories = [
            "https://jcenter.bintray.com/",
        ],
        maven_install_json = "@monorepo//tools/java:maven_install.json",
        fetch_sources = True,
        resolve_timeout = 3600,
        version_conflict_policy = "pinned",
        fail_on_missing_checksum = True,
    )
