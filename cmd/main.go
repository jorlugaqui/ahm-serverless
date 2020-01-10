package main

import (
	"ahm/callbacks"
	"log"
	"net/http"
)

func handleRequest() {
	http.HandleFunc("/", callbacks.HomePage)
	log.Fatal(http.ListenAndServe(":5000", nil))
}

func main() {
	handleRequest()
}
