#!/usr/bin/env make
.DELETE_ON_ERROR:

.DEFAULT_GOAL := default

.PHONY: default
default: init validate

.PHONY: init
init:
	terraform init
	cd examples/basic && terraform init
	cd test && make init

.PHONY: init-upgrade
init-upgrade:
	terraform init -upgrade
	cd examples/basic && terraform init -upgrade
	cd test/ && make upgrade

.PHONY: fmt
fmt:
	terraform fmt
	cd examples/basic && terraform fmt
	cd test && make fmt

.PHONY: plan
plan:
	terraform plan
	cd examples/basic && terraform plan
	cd test && make plan

.PHONY: validate
validate:
	terraform validate
	cd examples/basic && terraform validate
	cd test && make validate

.PHONY: update
update:
	pre-commit autoupdate
	cd test && make upgrade

.PHONY: local
local:
	cd test && ./local.sh

.PHONY: plan
plan: export TF_COMMAND = plan
plan:
	cd test && go mod tidy && go test -v -timeout 60m $(wildcard *.go)
