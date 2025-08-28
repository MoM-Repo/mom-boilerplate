OUTPUT:=./bin/app
GO_LINT_VERSION=1.64.8

GO_FILE:=./main.go


.PHONY: lint
lint:
	go run github.com/golangci/golangci-lint/cmd/golangci-lint@v${GO_LINT_VERSION} run

.PHONY: lint-fix
lint-fix:
	go run github.com/golangci/golangci-lint/cmd/golangci-lint@v${GO_LINT_VERSION} run --fix

.PHONY: build
build:
	go build -o ${OUTPUT} ${GO_FILE}

.PHONY: test
test:
	go test -count=1 -v ./...