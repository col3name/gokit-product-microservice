FROM golang:1.14.2 as builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o ./bin/catalog ./cmd

FROM alpine:3.11.5
RUN adduser -D app
USER app

COPY --from=builder /app/bin/catalog /app/bin/

WORKDIR /app/

EXPOSE 8080
CMD ["./bin/catalog"]