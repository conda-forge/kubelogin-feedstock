#!/bin/bash
set -ex

BUILD_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
GO_VERSION=$(go version | cut -d " " -f 3)
GOBIN=$(go env GOBIN)
LDFLAGS="-X main.version=$PKG_VERSION -X main.goVersion=$GO_VERSION -X main.buildTime=$BUILD_TIME"

export GOBIN=$GOBIN

go build -v -o ${target_gobin}${PKG_NAME}${target_goexe} -ldflags "$LDFLAGS"

test -f "${PREFIX}/bin/kubelogin${target_goexe}"

go get -v github.com/google/go-licenses
go-licenses save --ignore="gopkg.in/dnaeon/go-vcr.v3/" --save_path="$RECIPE_DIR/thirdparty_licenses/" $SRC_DIR
