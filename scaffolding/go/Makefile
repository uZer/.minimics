default: help
help: ## Display this message
	@grep -E '(^[a-zA-Z0-9_.-]+:.*?##.*$$)|(^##)' Makefile | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | \
		sed -e 's/\[32m##/[33m/'

all: qa build ## Build and test

build: ## Build program
	@echo "Building..."
	@go build -o main cmd/{{mod_name}}/main.go

run: ## Run program directly
	@echo "Running..."
	@go run cmd/{{mod_name}}/main.go

start: run ## Run program directly (alias)

qa: lint test ## Run all QA process

lint: ## Lint source code
	@echo "Linting..."
	golangci-lint run --verbose

test: ## Testing
	@echo "Testing..."
	@go test ./... -v

clean: ## Cleaning artefacts
	@echo "Cleaning..."
	@rm -f main

watch: ## Watching program with air
	@if command -v air > /dev/null; then \
		air; \
		echo "Watching...";\
	else \
		read -p "Go's 'air' is not installed on your machine. Do you want to install it? [Y/n] " choice; \
		if [ "$$choice" != "n" ] && [ "$$choice" != "N" ]; then \
			go install github.com/air-verse/air@latest; \
			air; \
			echo "Watching...";\
		else \
			echo "You chose not to install air. Exiting..."; \
			exit 1; \
		fi; \
	fi

.PHONY: default help run
