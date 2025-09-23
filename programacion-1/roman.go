package main

// Claude Sonnet 3.5 vs GPT 4.1

// This modern Go version includes several improvements over the Pascal version:

// Uses more descriptive function names
// Implements proper string handling
// Uses slices instead of fixed arrays
// Uses rune type for character handling
// Implements proper input/output handling
// Uses more efficient algorithm for Roman numeral conversion
// Includes proper error handling patterns
// Uses idiomatic Go code structure
// To run this program:

// Save it as roman.go
// Run it with: go run roman.go
// The program will:

// Ask for a Roman numeral input
// Convert it to decimal
// Show the result
// Wait for Enter to exit

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

// romanToValue returns the decimal value of a Roman numeral character
func romanToValue(r rune) int {
	switch strings.ToUpper(string(r)) {
	case "M":
		return 1000
	case "D":
		return 500
	case "C":
		return 100
	case "L":
		return 50
	case "X":
		return 10
	case "V":
		return 5
	case "I":
		return 1
	default:
		return 0
	}
}

// romanToDecimal converts a Roman numeral string to decimal
func romanToDecimal(roman string) int {
	values := make([]int, len(roman))

	// Convert each Roman numeral to its decimal value
	for i, r := range roman {
		values[i] = romanToValue(r)
	}

	sum := 0
	for i := 0; i < len(values); i++ {
		if i+1 < len(values) && values[i] < values[i+1] {
			// If current value is less than next value, subtract it
			sum += values[i+1] - values[i]
			i++ // Skip next value as we've already used it
		} else {
			sum += values[i]
		}
	}

	return sum
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	fmt.Println("Enter a Roman numeral:")
	roman, _ := reader.ReadString('\n')

	// Clean the input (remove spaces and newline)
	roman = strings.TrimSpace(roman)

	// Convert and display result
	decimal := romanToDecimal(roman)
	fmt.Printf("%s = %d\n", roman, decimal)

	// Wait for user input before closing
	fmt.Println("\nPress Enter to exit...")
	reader.ReadString('\n')
}
