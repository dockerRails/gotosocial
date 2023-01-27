FROM golang:1.19 as builder
RUN mkdir /app
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .	
RUN CGO_ENABLED=0 go build -o gotosocial ./cmd/gotosocial

FROM superseriousbusiness/gotosocial:latest

COPY --from=builder /app/gotosocial /gotosocial/gotosocial

ENTRYPOINT [ "/gotosocial/gotosocial", "server", "start" ]