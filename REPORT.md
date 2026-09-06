# Bazel Upgrade: 4.0.0 → 9.2.0

## What changed

This repo was pinned to Bazel 4.0.0 (released 2021) with a `WORKSPACE` file
declaring all external dependencies by hand — hand-rolled `http_archive`
calls with pinned SHAs, version numbers scattered across `tools/external_rules.bzl`
and `tools/java/maven.bzl`, and a Maven repository (`jcenter.bintray.com`)
that has been shut down since 2022.

This change moves the repo to Bazel 9.2.0, the current LTS release, using
**Bzlmod** — the module system that replaced `WORKSPACE` and is now the
only way Bazel resolves external dependencies (Bazel 9 no longer reads
`WORKSPACE` at all). Concretely:

- `WORKSPACE`, `tools/external_rules.bzl`, and `tools/java/maven.bzl` are
  gone; a single `MODULE.bazel` at the root declares every dependency by
  name and version, resolved automatically (with transitive version
  resolution) from the Bazel Central Registry instead of by hand-copied
  archive URLs and SHA256s.
- Every ruleset was bumped to its current, actively maintained major
  version and, where the old one is no longer maintained, swapped for its
  accepted successor:
  - `rules_go` / `gazelle` → current releases, wired to the project's
    existing `go.mod`/`go.sum` instead of a manually pinned `go_repository`.
  - `rules_jvm_external` (Maven) → current release, repointed at Maven
    Central now that jcenter is gone.
  - `rules_scala` → current release (now itself Bzlmod-native).
  - The old, long-abandoned `rules_nodejs` 2.x + `@bazel/typescript` +
    `@bazel/rollup` stack → `aspect_rules_js` / `aspect_rules_ts` /
    `aspect_rules_esbuild`, the actively maintained successor project the
    Bazel JS community consolidated around.
  - `rules_docker` (deprecated, unmaintained) → `rules_oci`, its
    recommended replacement, for building the server's container image.
  - The old buildifier/multirun setup (a hand-pinned `buildtools` archive
    and an `atlassian/bazel-tools` git checkout) → `buildifier_prebuilt`
    and `rules_multirun`, both distributed as proper Bazel modules.
- `.bazelrc` no longer sets `--javabase`/`--host_javabase`/`--java_toolchain`
  flags — those were removed from Bazel years ago in favor of hermetic JDK
  toolchains that `rules_java` now registers automatically from a single
  `--java_language_version` flag. Likewise for two other flags
  (`--incompatible_strict_action_env`, `--nolegacy_external_runfiles`)
  that existed only to opt into behavior that's now Bazel's permanent
  default and no longer exists as a flag at all.
- `rules_sass`, which was loaded in the old `WORKSPACE` but never actually
  used by any `BUILD` file, was dropped rather than migrated.

## Why

- **The old setup no longer builds.** Bazel 9 doesn't read `WORKSPACE`, so
  this repo was already unbuildable on any current Bazel release; this
  wasn't optional maintenance.
- **The dependency it points at is dead.** The pinned Maven repository
  (jcenter) has been offline for years, so `bazel build` was already
  broken on the Java side regardless of Bazel version.
- **Security and bug fixes.** Bazel 4 and the pinned rulesets are years
  behind on fixes to the sandbox, remote execution, and the language
  rulesets themselves.
- **Less to hand-maintain.** Bzlmod resolves transitive versions and
  dependency conflicts for you; the old setup required manually tracking
  every ruleset's own transitive `http_archive` calls and keeping their
  SHA256s in sync by hand.
- **Lands on maintained rulesets.** `rules_docker` and the old
  `rules_nodejs` 2.x toolchain are no longer maintained upstream; staying
  on them was accumulating migration debt that only grows more painful
  over time. Doing it now, while the repo is small, is far cheaper than
  doing it later.

## Verification

Bazel 9.2.0 and the exact module/version graph used here were checked
directly against the real Bazel Central Registry and each ruleset's
published release artifacts. This sandbox's network policy blocks the
registry and package-manager endpoints a from-scratch `bazel build //...`
needs to fetch (`bcr.bazel.build`, `registry.npmjs.org`, JDK/Node
toolchain mirrors), so a full end-to-end build wasn't possible to run
here — that first build should be treated as the real validation step in
CI or a developer's machine, both of which have normal internet access.

## Follow-ups worth doing after merge

- Run `bazel run @maven//:pin` once merged to regenerate a pinned
  `maven_install.json` for reproducible Java builds (the stale one, built
  against the dead jcenter mirror, was removed rather than carried
  forward).
- Run `yarn install` to refresh `yarn.lock` now that the Bazel-specific
  `@bazel/*` npm packages have been dropped from `package.json`.
