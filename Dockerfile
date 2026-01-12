FROM golang:1.25-alpine AS builder

WORKDIR /cmd

COPY src/ .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app

FROM gcr.io/distroless/base-debian12

WORKDIR /cmd
COPY --from=builder /cmd/app .
EXPOSE 8080

ENTRYPOINT ["/cmd/app"]