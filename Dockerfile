FROM golang:1.17.4-alpine AS builder

WORKDIR /var/www/app

COPY . .

RUN GOOS=linux GOARCH=amd64 go build -o /go/bin/codeeducation -ldflags="-w -s"

# builder multistage
# fonte: https://chemidy.medium.com/create-the-smallest-and-secured-golang-docker-image-based-on-scratch-4752223b7324
FROM scratch

COPY --from=builder /go/bin/codeeducation /go/bin/codeeducation
ENTRYPOINT ["/go/bin/codeeducation"]