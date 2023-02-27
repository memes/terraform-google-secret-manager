# Test case for secrets that are wrapped as sensitive

As reported in [issue #51](https://github.com/memes/terraform-google-secret-manager/issues/51)
by @cassus, the module failed when the `secret` input
variable has been declared as
[sensitive](https://developer.hashicorp.com/terraform/language/values/variables#suppressing-values-in-cli-output).
This fixture is to verify the solution.
