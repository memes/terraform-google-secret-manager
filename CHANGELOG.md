# Changelog

<!-- spell-checker: ignore markdownlint -->
<!-- markdownlint-disable MD024 -->

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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

[1.0.1]: https://github.com/memes/terraform-google-secret-manager/compare/v1.0.0...v1.0.1
[0.12.0]: https://github.com/memes/terraform-google-secret-manager/releases/tag/v0.12.0
[1.0.0]: https://github.com/memes/terraform-google-secret-manager/releases/tag/v1.0.0
