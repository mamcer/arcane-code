package main

import (
	"bufio"
	"flag"
	"fmt"
	"os"
	"strings"
)

// MorseCode represents a mapping between letters and their Morse code
type MorseCode struct {
	letterToMorse map[string]string
	morseToLetter map[string]string
}

// NewMorseCode creates a new MorseCode instance
func NewMorseCode() *MorseCode {
	return &MorseCode{
		letterToMorse: make(map[string]string),
		morseToLetter: make(map[string]string),
	}
}

// LoadCodes loads Morse code mappings from a file
func (mc *MorseCode) LoadCodes(filename string) error {
	file, err := os.Open(filename)
	if err != nil {
		return fmt.Errorf("error opening code file: %v", err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		parts := strings.Split(line, ":")
		if len(parts) != 2 {
			continue // Skip invalid lines
		}
		letter := strings.ToUpper(strings.TrimSpace(parts[0]))
		code := strings.TrimSpace(parts[1])

		mc.letterToMorse[letter] = code
		mc.morseToLetter[code] = letter
	}

	return scanner.Err()
}

// Encode converts text to Morse code
func (mc *MorseCode) Encode(text string) string {
	var result strings.Builder
	words := strings.Split(strings.ToUpper(text), " ")

	for i, word := range words {
		if i > 0 {
			result.WriteString("   ") // 3 spaces between words
		}

		for j, char := range word {
			if j > 0 {
				result.WriteString(" ") // 1 space between letters
			}

			if code, ok := mc.letterToMorse[string(char)]; ok {
				result.WriteString(code)
			}
		}
	}

	return result.String()
}

// Decode converts Morse code to text
func (mc *MorseCode) Decode(morse string) string {
	var result strings.Builder
	words := strings.Split(morse, "   ") // 3 spaces between words

	for i, word := range words {
		if i > 0 {
			result.WriteString(" ")
		}

		letters := strings.Split(word, " ")
		for _, code := range letters {
			if letter, ok := mc.morseToLetter[code]; ok {
				result.WriteString(letter)
			}
		}
	}

	return result.String()
}

func main() {
	// Define command line flags
	encode := flag.Bool("c", false, "Encode mode")
	decode := flag.Bool("d", false, "Decode mode")
	flag.Parse()

	// Check if we have enough arguments
	args := flag.Args()
	if len(args) != 2 {
		fmt.Println("Usage: morse -c|-d codes.txt message.txt")
		os.Exit(1)
	}

	codesFile := args[0]
	messageFile := args[1]

	// Initialize Morse code
	morse := NewMorseCode()
	err := morse.LoadCodes(codesFile)
	if err != nil {
		fmt.Printf("Error loading Morse codes: %v\n", err)
		os.Exit(1)
	}

	// Read input file
	input, err := os.ReadFile(messageFile)
	if err != nil {
		fmt.Printf("Error reading message file: %v\n", err)
		os.Exit(1)
	}

	var outputFile string
	var result string

	// Process based on mode
	if *encode {
		result = morse.Encode(string(input))
		outputFile = strings.TrimSuffix(messageFile, ".txt") + ".mor"
	} else if *decode {
		result = morse.Decode(string(input))
		outputFile = strings.TrimSuffix(messageFile, ".mor") + ".txt"
	} else {
		fmt.Println("Must specify either -c (encode) or -d (decode)")
		os.Exit(1)
	}

	// Write output file
	err = os.WriteFile(outputFile, []byte(result), 0644)
	if err != nil {
		fmt.Printf("Error writing output file: %v\n", err)
		os.Exit(1)
	}
}
