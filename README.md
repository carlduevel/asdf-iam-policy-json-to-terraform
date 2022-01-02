<div align="center">

# asdf-iam-policy-json-to-terraform [![Build](https://github.com/carlduevel/asdf-iam-policy-json-to-terraform/actions/workflows/build.yml/badge.svg)](https://github.com/carlduevel/asdf-iam-policy-json-to-terraform/actions/workflows/build.yml) [![Lint](https://github.com/carlduevel/asdf-iam-policy-json-to-terraform/actions/workflows/lint.yml/badge.svg)](https://github.com/carlduevel/asdf-iam-policy-json-to-terraform/actions/workflows/lint.yml)


[iam-policy-json-to-terraform](https://github.com/flosell/iam-policy-json-to-terraform/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add iam-policy-json-to-terraform
# or
asdf plugin add iam-policy-json-to-terraform https://github.com/carlduevel/asdf-iam-policy-json-to-terraform.git
```

iam-policy-json-to-terraform:

```shell
# Show all installable versions
asdf list-all iam-policy-json-to-terraform

# Install specific version
asdf install iam-policy-json-to-terraform latest

# Set a version globally (on your ~/.tool-versions file)
asdf global iam-policy-json-to-terraform latest

# Now iam-policy-json-to-terraform commands are available
iam-policy-json-to-terraform_amd64 --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/carlduevel/asdf-iam-policy-json-to-terraform/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Carl Düvel](https://github.com/carlduevel/)
