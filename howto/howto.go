package howto

import "github.com/charmbracelet/glamour"

// Render the HOW_TO.md to the terminal
func Render() {
	out, err := glamour.Render("", "dark")
}
