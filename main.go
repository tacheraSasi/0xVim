package main

import (
	"log"
	"os"

	"github.com/tacheraSasi/0xVim.git/howto"
)

const howToPath = "/Users/mac/.config/nvim/HOW_TO.md"

func main() {
	data, err := os.ReadFile(howToPath)
	if err != nil {
		log.Fatal(err)
	}
	content := string(data)

	err = howto.Render(content)
	if err != nil {
		log.Fatal(err)
	}
}
