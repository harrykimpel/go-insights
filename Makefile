#############################
# Global vars
#############################
PROJECT_NAME := $(shell basename $(shell pwd))
PROJECT_VER  := $(shell git describe --tags --always --dirty | sed -e '/^v/s/^v\(.*\)$$/\1/g') # Strip leading 'v' if found
SRCDIR       ?= .
GO            = go


#############################
# Targets
#############################
all: build

# Humans running make:
build: check-version clean test cover-report compile

# Build command for CI tooling
build-ci: check-version clean lint test compile-only

# All clean commands
clean: clean-cover clean-compile

# Import fragments
include build/compile.mk
include build/deps.mk
include build/document.mk
include build/lint.mk
include build/test.mk
include build/util.mk

.PHONY: all build build-ci clean
