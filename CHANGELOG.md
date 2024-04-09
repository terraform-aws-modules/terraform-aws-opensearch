# Changelog

All notable changes to this project will be documented in this file.

## [1.1.2](https://github.com/terraform-aws-modules/terraform-aws-opensearch/compare/v1.1.1...v1.1.2) (2024-04-09)


### Bug Fixes

* Do not create default zone_awareness_config if it not set ([#3](https://github.com/terraform-aws-modules/terraform-aws-opensearch/issues/3)) ([3a1f79f](https://github.com/terraform-aws-modules/terraform-aws-opensearch/commit/3a1f79f1fa06a660091af7fa1843303f47f54c0f))

## [1.1.1](https://github.com/terraform-aws-modules/terraform-aws-opensearch/compare/v1.1.0...v1.1.1) (2024-04-09)


### Bug Fixes

* Fix the condition of the logical operators of `master_user_name` and `master_user_password` ([#4](https://github.com/terraform-aws-modules/terraform-aws-opensearch/issues/4)) ([fa811d2](https://github.com/terraform-aws-modules/terraform-aws-opensearch/commit/fa811d29e80f1658b8af148c8d0697b29fbc6593))

## [1.1.0](https://github.com/terraform-aws-modules/terraform-aws-opensearch/compare/v1.0.0...v1.1.0) (2024-03-22)


### Features

* Add `standby_replicas` to serverless collection and `auto_tune_options.use_off_peak_window` to domain ([#2](https://github.com/terraform-aws-modules/terraform-aws-opensearch/issues/2)) ([dff3f63](https://github.com/terraform-aws-modules/terraform-aws-opensearch/commit/dff3f6357cbe92f582527267499f82cf90d6027e))
