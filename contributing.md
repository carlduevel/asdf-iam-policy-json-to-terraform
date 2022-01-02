# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test iam-policy-json-to-terraform https://github.com/carlduevel/asdf-iam-policy-json-to-terraform.git "iam-policy-json-to-terraform --version"
```

Tests are automatically run in GitHub Actions on push and PR.
