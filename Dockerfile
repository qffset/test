# Stage 1: Fetch dependencies
FROM golang:alpine AS deps
WORKDIR /app
COPY go.mod ./
#COPY go.sum ./
RUN go mod download

# Stage 2: Build the application binary
FROM deps AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app

# Stage 3: Run the application in a small image
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/app .
EXPOSE 8080
CMD ["./app"]
