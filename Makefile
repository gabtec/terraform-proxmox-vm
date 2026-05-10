.PHONY: docs

# Generate module docs
docs:
	@terraform-docs markdown table . > docs/module-vm.md