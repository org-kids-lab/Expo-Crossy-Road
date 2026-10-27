.DEFAULT_GOAL := help
.PHONY: help install start start-all fresh build serve prod typecheck lint clean

PORT ?= 8081

help: ## Show available commands
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  make %-10s %s\n", $$1, $$2}'

install: ## Install dependencies
	npm install

start: ## Start the web dev server (http://localhost:8081)
	npx expo start --web --port $(PORT)

start-all: ## Start the dev server for all platforms (Expo Go QR code)
	npx expo start --port $(PORT)

build: ## Production web build into dist/
	npx expo export -p web

serve: ## Serve the production build from dist/
	npx --yes serve dist

prod: build serve ## Build and serve the production web version

typecheck: ## Type-check (~550 pre-existing errors are the baseline)
	@echo "TypeScript errors: $$(npx tsc --noEmit -p . | grep -c 'error TS')"

lint: ## Run ESLint
	npx expo lint

fresh: ## Start the web dev server with a cleared Metro cache
	npx expo start --web --clear --port $(PORT)

clean: ## Remove the production build output (dist/)
	rm -rf dist
