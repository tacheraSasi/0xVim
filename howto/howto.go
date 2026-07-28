package howto

import (
	"fmt"

	"github.com/charmbracelet/glamour"
)

// Render the HOW_TO.md to the terminal
func Render(mdSource string) error {
	out, err := glamour.Render(mdSource, "dark")
	if err != nil {
		return err
	}
	fmt.Print(out)
	return nil
}
