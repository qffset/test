FROM scratch AS build
COPY <<EOF ./scratch.hello
hello world
EOF

FROM golang:1.24
WORKDIR /usr/src/app

COPY <<EOF ./go.mod
module golang
go 1.24.1
EOF

RUN go mod download

COPY <<EOF /usr/src/app/main.go
package main
import (
    "fmt"
    "net/http"
)
func helloHandler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintln(w, "Hello, World!")
}
func main() {
    http.HandleFunc("/", helloHandler)
    fmt.Println("Server started at http://192.168.88.26:8888 ")
    http.ListenAndServe(":8888", nil)
}
EOF

COPY --from=build /scratch.hello /usr/src/app/

RUN go build -v -o /usr/local/bin/app ./...

EXPOSE 8888
CMD ["app"]```
