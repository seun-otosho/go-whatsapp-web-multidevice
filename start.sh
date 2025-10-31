#!/bin/sh

# Build the Go application
cd src
go build -o whatsapp

# Run the application in REST mode
./whatsapp rest
