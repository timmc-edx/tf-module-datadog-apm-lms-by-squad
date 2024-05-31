Monitors for edxapp LMS, broken out by code-owner.

----

This comes equipt with DevOps Standards:
---
- Default files:
  - [main.tf](main.tf)
  - [locals.tf](locals.tf)
  - [variables.tf](variables.tf)
  - [outputs.tf](outputs.tf)

- Release Drafter [release github action](https://github.com/release-drafter/release-drafter).

- Documentation is automatically handled using [Terraform Doc's](https://github.com/terraform-docs/terraform-docs) [Github Action](https://github.com/terraform-docs/gh-actions)
  - It's configuration can be found [here](.terraform-docs.yml)
  - It's Github Action config is [here](.github/workflows/documentation.yml)
  - See the example below
  
- See [USAGE.md](docs/USAGE.md) for how to use this module
