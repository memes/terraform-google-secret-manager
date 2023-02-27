# This makefile implements wrappers around various kitchen test commands. The
# intent is to make it easy to execute a full test suite, or individual actions,
# with a safety net that ensures the test harness is present before executing
# kitchen commands. Specifically, Terraform in /test/setup/ has been applied, and
# the examples have been cloned to an emphemeral folder and source modified to
# use these local files.
#
# Every kitchen command has an equivalent target; kitchen action [pattern] becomes
# make action[.pattern]
#
# E.g.
#   kitchen test                 =>   make test
#   kitchen verify example-gsr   =>   make verify.example-gsr
#   kitchen converge pr          =>   make converge.pr
#
# Default target will create necessary test harness, then launch kitchen test.
.DEFAULT: test
.PHONY: test.%
test.%: test/setup/terraform.tfstate
	kitchen test $*

.PHONY: test
test: test/setup/terraform.tfstate
	kitchen test

.PHONY: destroy.%
destroy.%: test/setup/terraform.tfstate
	kitchen destroy $*

.PHONY: destroy
destroy: test/setup/terraform.tfstate
	kitchen destroy

.PHONY: verify.%
verify.%: test/setup/terraform.tfstate
	kitchen verify $*

.PHONY: verify
verify: test/setup/terraform.tfstate
	kitchen verify

.PHONY: converge.%
converge.%: test/setup/terraform.tfstate
	kitchen converge $*

.PHONY: converge
converge: test/setup/terraform.tfstate
	kitchen converge

EXAMPLES=accessors all-options simple with-random-provider user-managed-replication user-managed-replication-accessors user-managed-replication-with-keys empty-secret-value

test/setup/terraform.tfstate: $(wildcard test/setup/*.tf) $(wildcard test/setup/*.auto.tfvars) $(wildcard test/setup/terraform.tfvars) $(addprefix test/ephemeral/,$(addsuffix /main.tf,$(EXAMPLES)))
	terraform -chdir=test/setup init -input=false
	terraform -chdir=test/setup apply -input=false -auto-approve

# We want the examples to use the registry tagged versions of the module, but
# need to test against the local code. Make an ephemeral copy of each example
# with the source redirected to local module
test/ephemeral/%/main.tf: $(wildcard examples/%/*.tf)
	mkdir -p $(@D)
	rsync -avP --exclude .terraform \
		--exclude .terraform.lock.hcl \
		--exclude 'terraform.tfstate' \
		examples/$*/ $(@D)/
	sed -i '' -E -e '1h;2,$$H;$$!d;g' -e 's@module "secret"[ \t]*{[ \t]*\n[ \t]*source[ \t]*=[ \t]*"memes/secret-manager/google"\n[ \t]*version[ \t]*=[ \t]*"[^"]+"@module "secret" {\n  source = "../../../"@' $@
	sed -i '' -E -e '1h;2,$$H;$$!d;g' -e 's@module "secret"[ \t]*{[ \t]*\n[ \t]*source[ \t]*=[ \t]*"memes/secret-manager/google//modules/([^"]+)"\n[ \t]*version[ \t]*=[ \t]*"[^"]+"@module "secret" {\n  source = "../../../modules/\1/"@' $@

.PHONY: clean
clean: $(wildcard test/setup/terraform.tfstate)
	if test -n "$<" && test -f "$<"; then kitchen destroy; fi
	if test -n "$<" && test -f "$<"; then terraform -chdir=$(<D) destroy -auto-approve; fi
	if test -n "$<" && test -f "$<"; then rm "$<"; fi

.PHONY: realclean
realclean: clean
	-find test/reports -depth 1 -type d -exec rm -rf {} +
	-find test/ephemeral -depth 1 -type d -exec rm -rf {} +
	find . -type d -name .terraform -exec rm -rf {} +
	find . -type d -name terraform.tfstate.d -exec rm -rf {} +
	find . -type f -name .terraform.lock.hcl -exec rm -f {} +
	find . -type f -name terraform.tfstate -exec rm -f {} +
	find . -type f -name terraform.tfstate.backup -exec rm -f {} +
	rm -rf .kitchen

# Helper to ensure code is ready to merge release-please PR:
# 1. Git tree is clean
# 2. Each example is using a valid Terraform registry source and the version
#    matches the version to be released
# 3. Inspec controls have version matching the tag
.PHONY: release-ready.%
release-ready.%:
	@echo '$*' | grep -Eq '^v(?:[0-9]+\.){2}[0-9]+$$' || \
		(echo "Version doesn't meet requirements"; exit 1)
	@test "$(shell git status --porcelain | wc -l | grep -Eo '[0-9]+')" == "0" || \
		(echo "Git tree is unclean"; exit 1)
	@find examples -type f -name main.tf -print0 | \
		xargs -0 awk 'BEGIN{m=0;s=0;v=0}; /module "secret"/ {m=1}; m==1 && /source[ \t]*=[ \t]*"memes\/secret-manager\/google(\/\/modules\/random)?/ {s++}; m==1 && /version[ \t]*=[ \t]*"$(subst .,\.,$(*:v%=%))"/ {v++}; END{if (s==0) { printf "%s has incorrect source\n", FILENAME}; if (v==0) { printf "%s has incorrect version\n", FILENAME}; if (s==0 || v==0) { exit 1}}'
	# CHANGELOG is managed by release-please - testing is unnecessary
	# @(grep -Eq '^## \[$(subst .,\.,$(*:v%=%))\] - [0-9]{4}(?:-[0-9]{2}){2}' CHANGELOG.md && \
	# 	grep -Eq '^\[$(subst .,\.,$(*:v%=%))\]: https://github.com/' CHANGELOG.md) || \
	# 	(echo "CHANGELOG is missing tag entry"; exit 1)
	@grep -Eq '^version:[ \t]*$(subst .,\.,$(*:v%=%))[ \t]*$$' test/profiles/secrets/inspec.yml || \
		(echo "test/profiles/secrets/inspec.yml has incorrect version"; exit 1)
	@echo "Source is ready to be released as $1"
