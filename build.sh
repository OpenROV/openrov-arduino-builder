#!/bin/bash
set -e

mkdir -p output/usr/bin

apt-get update
apt-get install -y curl gcc git-core mercurial

rm -fr /usr/local/go
curl -sSL https://storage.googleapis.com/golang/go1.4.3.src.tar.gz | sudo tar -xz -C /usr/local

cd /usr/local/go/src
./make.bash

export PATH=/usr/local/go/bin:$PATH

cd -

git clone https://github.com/arduino/arduino-builder.git
cd arduino-builder

source setup_go_env_vars

go get github.com/go-errors/errors
go get github.com/stretchr/testify
go get github.com/jstemmer/go-junit-report
go get golang.org/x/codereview/patch
go get golang.org/x/tools/cmd/vet
go build

# Copy bin file to output
cp arduino-builder ../output/usr/bin/

# Run tests - currently broken
#go test -v ./src/arduino.cc/builder/test/... | bin/go-junit-report > report.xml



