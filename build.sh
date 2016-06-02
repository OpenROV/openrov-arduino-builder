#!/bin/bash
set -e

mkdir -p output/usr/bin

apt-get update
apt-get install -y curl gcc git-core mercurial

rm -fr /usr/local/go
rm -rf go.tar.gz

if [[ $(arch) == *"x86"* ]]
then
	echo "Detected x86_64"
	wget https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz -O go.tar.gz
elif [[ $(arch) == *"x64"* ]]
then
	echo "Detected x86_64"
	wget https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz -O go.tar.gz
elif [[ $(arch) == *"arm"* ]]
then
	echo "Detected arm"
	wget https://storage.googleapis.com/golang/go1.6.2.linux-armv6l.tar.gz -O go.tar.gz
fi


tar xf go.tar.gz

mv ./go /usr/local/go

export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

rm -rf go.tar.gz

rm -rf arduino-builder

git clone https://github.com/arduino/arduino-builder.git
cd arduino-builder

source setup_go_env_vars

go get github.com/go-errors/errors
go get github.com/stretchr/testify
go get github.com/jstemmer/go-junit-report
go build arduino.cc/arduino-builder

# Copy bin file to output
cp arduino-builder ../output/usr/bin/



