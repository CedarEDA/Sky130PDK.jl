SRCDIR:=$(shell dirname $(abspath $(firstword $(MAKEFILE_LIST))))

docs:
	julia --project=${SRCDIR} ${SRCDIR}/make.jl

.PHONY: docs
