# Changelog

<!-- markdownlint-disable MD024 -->

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.2.2](https://github.com/memes/terraform-google-secret-manager/compare/v2.2.1...v2.2.2) (2025-04-05)


### Bug Fixes

* Workload identity principals as accessors ([dbf2229](https://github.com/memes/terraform-google-secret-manager/commit/dbf22290ea37a07567d0bdb2454a12698193e7a0))
* Workload identity principals as accessors ([97cf873](https://github.com/memes/terraform-google-secret-manager/commit/97cf873b30dcbdf1ddcdd3a1fffde54864cd4d9b)), closes [#103](https://github.com/memes/terraform-google-secret-manager/issues/103)

## [2.2.1](https://github.com/memes/terraform-google-secret-manager/compare/v2.2.0...v2.2.1) (2024-06-24)


### Bug Fixes

* Limit characters in random example for BIG-IP ([1e5e8ec](https://github.com/memes/terraform-google-secret-manager/commit/1e5e8ecc7dd6200057e49f78c7d96f8d9b851b4d)), closes [#93](https://github.com/memes/terraform-google-secret-manager/issues/93)

## [2.2.0](https://github.com/memes/terraform-google-secret-manager/compare/v2.1.2...v2.2.0) (2023-10-31)


### Features

* Add Pub/Sub topic support ([1c4b2a4](https://github.com/memes/terraform-google-secret-manager/commit/1c4b2a41c844f6a518bd176a8a3b2c1f2e267a1e))
* Add support for Google provider v5 ([2880be2](https://github.com/memes/terraform-google-secret-manager/commit/2880be22236351558dc2c317dc86a8d96d474bb8)), closes [#76](https://github.com/memes/terraform-google-secret-manager/issues/76)
* Set TTL on secrets ([bd27278](https://github.com/memes/terraform-google-secret-manager/commit/bd272786755c3bd279cc5bdb7965bfee440dbc8b))


### Bug Fixes

* Ignore changes in `rotation` ([7d79ea5](https://github.com/memes/terraform-google-secret-manager/commit/7d79ea5da85c7c754a06f6c6b15b25a170146813))
* Make variables more robust ([27b9324](https://github.com/memes/terraform-google-secret-manager/commit/27b93241f592b5b414776f79d9424dae4355dd7a))
* Update random provider example ([b34bccf](https://github.com/memes/terraform-google-secret-manager/commit/b34bccffc41abeb820cb62b7eac485b72a52092f))

## [2.1.2](https://github.com/memes/terraform-google-secret-manager/compare/v2.1.1...v2.1.2) (2023-10-18)


### Bug Fixes

* Add &lt;5 constraint on Google provider ([fdea9c2](https://github.com/memes/terraform-google-secret-manager/commit/fdea9c25f9280674a10b5d71051b9a07f56f2f17))

## [2.1.1](https://github.com/memes/terraform-google-secret-manager/compare/v2.1.0...v2.1.1) (2023-02-27)


### Bug Fixes

* Mark secret variable as sensitive ([04d7ec7](https://github.com/memes/terraform-google-secret-manager/commit/04d7ec7ebe7af7847b7c5613f44604924f2570d9))
* Support secret variable marked sensitive ([c5a9976](https://github.com/memes/terraform-google-secret-manager/commit/c5a9976c15f97d6e235fe89d755ce6813ad93054))

## [2.1.0](https://github.com/memes/terraform-google-secret-manager/compare/v2.0.0...v2.1.0) (2023-02-12)


### Features

* Show the project is still under maintenance ([92ee45f](https://github.com/memes/terraform-google-secret-manager/commit/92ee45fff8b7936199570cfccdb83907518fd991))

## [2.0.1] - 2022-05-18

### Added

### Changed

- modified [with-random-provider](examples/with-random-provider) example to use
  `random_string` function as the output is not treated as sensitive.

### Removed

## [2.0.0] - 2022-05-05

### Added

- support for empty/null `secret` value to create a Secret Manager entry without
  a versioned value. Users must manage the secret version outside this module if
  used. Thanks @yoelmacia for reporting the issue [#18](https://github.com/memes/terraform-google-secret-manager/issues/18).
- `replication` object replaces the functionality of `replication_locations` and
  `replication_keys`.

### Changed

- minimum supported Terraform version is >= 0.14.5

### Removed

- dropped the `random` submodule; there are many alternative ways to generate a
  random password that can be used instead. See [with-random-provider](examples/with-random-provider)
  example that reproduces the actions of the removed module.
- removed `replication_locations` and `replication_keys` variables; use `replication`
  object instead.

## [1.1.1] - 2022-04-20

### Added

### Changed

- corrected version specifiers in examples

### Removed

## [1.1.0] - 2022-04-20

### Added

- Cloud KMS key examples for CMEK encryption of Secrets
- Testing framework

### Changed

- Fixed bug reported by @brno32 - can't specify replication locations without
  Cloud KMS keys (issue [#19](https://github.com/memes/terraform-google-secret-manager/issues/19))

### Removed

## [1.0.5] - 2022-02-03

### Added

### Changed

- Relaxed Google provider constraint to >= 3.44

### Removed

## [1.0.4] - 2022-01-20

### Added

- Support customer KMS keys for secret encryption - submitted by @elisiano
  see Google's
  [CMEK with user managed replication](https://cloud.google.com/secret-manager/docs/cmek#user-managed-replication)
  for more details.

### Changed

### Removed

## [1.0.3] - 2021-07-27

### Added

### Changed

- Support Terraform version >= 0.13 - submitted by @andrewmackett
  (issue [#7](https://github.com/memes/terraform-google-secret-manager/issues/7))

### Removed

- Terraform 0.12 branch is end-of-life; no new updates or fixes will be accepted.

## [1.0.2] and [0.12.2] - 2020-10-20

### Added

- Output `secret_id` which contains the project-local Secret Manager key; e.g. if
  fully-qualified output is `projects/PROJECT_ID/secrets/MY_SECRET_ID` the value of the
  `secret_id` output will be `MY_SECRET_ID`.

### Changed

- Output `id` now contains the fully-qualified Secret Manager key. E.g. `id` is
  composed as `projects/PROJECT_ID/secrets/MY_SECRET_ID`.

### Removed

- Output 'name' was removed from both modules

## [1.0.1] and [0.12.0] - 2020-10-20

### Added

- Add documentation for Terraform 0.13 and Terraform 0.12 supported versions
  - v1.x will track to supported Terraform version (0.13 currently)
  - v0.12.x will track Terraform 0.12 supported versions

## [1.0.0] - 2020-10-20

### Added

- First published version of Secret Manager modules, Terraform 0.13 only

### Changed

### Removed

[2.0.1]: https://github.com/memes/terraform-google-secret-manager/compare/v2.0.0...v2.0.1
[2.0.0]: https://github.com/memes/terraform-google-secret-manager/compare/v1.1.0...v2.0.0
[1.1.1]: https://github.com/memes/terraform-google-secret-manager/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/memes/terraform-google-secret-manager/compare/v1.0.5...v1.1.0
[1.0.5]: https://github.com/memes/terraform-google-secret-manager/compare/v1.0.4...v1.0.5
[1.0.4]: https://github.com/memes/terraform-google-secret-manager/compare/v1.0.3...v1.0.4
[1.0.3]: https://github.com/memes/terraform-google-secret-manager/compare/v1.0.2...v1.0.3
[1.0.2]: https://github.com/memes/terraform-google-secret-manager/compare/v1.0.1...v1.0.2
[0.12.2]: https://github.com/memes/terraform-google-secret-manager/compare/v0.12.0..v0.12.2
[1.0.1]: https://github.com/memes/terraform-google-secret-manager/compare/v1.0.0...v1.0.1
[0.12.0]: https://github.com/memes/terraform-google-secret-manager/releases/tag/v0.12.0
[1.0.0]: https://github.com/memes/terraform-google-secret-manager/releases/tag/v1.0.0
