package main

import (
	"fmt"
	"net/http"
)

const (
	version = "0.0.1"
)

func main() {
	// Read configuration file

	// Run server on port 8080 with default handler
	RunServer(8080)
}

func handlerPing(w http.ResponseWriter, _ *http.Request) {
	fmt.Fprintf(w, "LUKS Service v%s\n", version)
}

// Handler: Create LUKS2 encrypted volume by calling cryptsetup
func createVolume(w http.ResponseWriter, r *http.Request) {

}

func RunServer(port int) {
	// Start the server
	http.HandleFunc("/ping", handlerPing)
	http.ListenAndServe(fmt.Sprintf(":%d", port), nil)
}
