# Multi-stage build for Railway deployment
# Stage 1: Build the Go application
FROM golang:1.23-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git ca-certificates tzdata

WORKDIR /build

# Copy go mod files
COPY src/go.mod src/go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY src/ .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o whatsapp

# Stage 2: Create runtime image
FROM alpine:latest

# Install runtime dependencies
RUN apk --no-cache add ca-certificates ffmpeg

WORKDIR /root/

# Copy binary from builder
COPY --from=builder /build/whatsapp .

# Expose port
EXPOSE 3000

# Run the application
CMD ["sh", "-c", "./whatsapp rest"]
