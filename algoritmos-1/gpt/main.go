// morse.go
package main

import (
	"bufio"
	"errors"
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

// ReadMorseTable reads morse code file with lines like "A:.-"
func ReadMorseTable(path string) (map[string]string, map[string]string, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, nil, err
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	enc := make(map[string]string) // char -> code
	dec := make(map[string]string) // code -> char

	lineNo := 0
	for scanner.Scan() {
		lineNo++
		line := strings.TrimSpace(scanner.Text())
		if line == "" {
			continue
		}
		// ignore comments starting with #
		if strings.HasPrefix(line, "#") {
			continue
		}
		parts := strings.SplitN(line, ":", 2)
		if len(parts) != 2 {
			// skip malformed lines
			continue
		}
		key := strings.TrimSpace(parts[0])
		val := strings.TrimSpace(parts[1])
		if key == "" || val == "" {
			continue
		}
		// normalize key to uppercase
		k := strings.ToUpper(key)
		enc[k] = val
		dec[val] = k
	}
	if err := scanner.Err(); err != nil {
		return nil, nil, err
	}
	if len(enc) == 0 {
		return nil, nil, errors.New("no codes found in morse file")
	}
	return enc, dec, nil
}

// encodeLine encodes a single line of plaintext to morse
// words separated by spaces; letters -> code, separated by single space; words separated by " / "
func encodeLine(line string, enc map[string]string) string {
	// split by whitespace to words
	words := strings.Fields(line)
	outWords := make([]string, 0, len(words))
	for _, w := range words {
		var codes []string
		// iterate runes to capture characters (letters, digits, punctuation if in table)
		for _, r := range w {
			ch := strings.ToUpper(string(r))
			if code, ok := enc[ch]; ok {
				codes = append(codes, code)
			} else {
				// unknown character -> put "?"
				codes = append(codes, "?")
			}
		}
		outWords = append(outWords, strings.Join(codes, " "))
	}
	// join words with " / "
	return strings.Join(outWords, " / ")
}

// decodeLine decodes a line of morse to plaintext
// assumes letters separated by spaces, words separated by " / "
func decodeLine(line string, dec map[string]string) string {
	// to be robust, normalize separators: allow " / " or "/" as word sep
	line = strings.TrimSpace(line)
	if line == "" {
		return ""
	}
	// split words by " / " or "/"
	words := splitWords(line)
	outWords := make([]string, 0, len(words))
	for _, w := range words {
		// letters are separated by spaces
		letterCodes := strings.Fields(w)
		var letters []string
		for _, code := range letterCodes {
			if code == "?" {
				letters = append(letters, "?")
				continue
			}
			if ch, ok := dec[code]; ok {
				letters = append(letters, ch)
			} else {
				letters = append(letters, "?") // unknown code
			}
		}
		outWords = append(outWords, strings.Join(letters, ""))
	}
	return strings.Join(outWords, " ")
}

// splitWords splits by " / " or "/" robustly
func splitWords(line string) []string {
	// first replace " / " with a unique token, then replace "/" with token, then split
	token := "<<<WORD>>>"
	s := strings.ReplaceAll(line, " / ", token)
	s = strings.ReplaceAll(s, "/", token)
	parts := strings.Split(s, token)
	for i := range parts {
		parts[i] = strings.TrimSpace(parts[i])
	}
	return parts
}

func deriveOutputName(input string, encoding bool) string {
	ext := strings.ToLower(filepath.Ext(input))
	base := strings.TrimSuffix(input, ext)
	if encoding {
		// want .mor
		if ext == ".txt" {
			return base + ".mor"
		}
		return input + ".mor"
	} else {
		// decoding -> want .txt
		if ext == ".mor" {
			return base + ".txt"
		}
		return input + ".txt"
	}
}

func encodeFile(morseFile, inFile, outFile string) error {
	enc, _, err := ReadMorseTable(morseFile)
	if err != nil {
		return err
	}
	in, err := os.Open(inFile)
	if err != nil {
		return err
	}
	defer in.Close()
	out, err := os.Create(outFile)
	if err != nil {
		return err
	}
	defer out.Close()

	scanner := bufio.NewScanner(in)
	writer := bufio.NewWriter(out)
	for scanner.Scan() {
		line := scanner.Text()
		encLine := encodeLine(line, enc)
		_, _ = writer.WriteString(encLine + "\n")
	}
	if err := scanner.Err(); err != nil {
		return err
	}
	return writer.Flush()
}

func decodeFile(morseFile, inFile, outFile string) error {
	_, dec, err := ReadMorseTable(morseFile)
	if err != nil {
		return err
	}
	in, err := os.Open(inFile)
	if err != nil {
		return err
	}
	defer in.Close()
	out, err := os.Create(outFile)
	if err != nil {
		return err
	}
	defer out.Close()

	scanner := bufio.NewScanner(in)
	writer := bufio.NewWriter(out)
	for scanner.Scan() {
		line := scanner.Text()
		decLine := decodeLine(line, dec)
		_, _ = writer.WriteString(decLine + "\n")
	}
	if err := scanner.Err(); err != nil {
		return err
	}
	return writer.Flush()
}

func usage() {
	fmt.Fprintf(os.Stderr, "Usage:\n")
	fmt.Fprintf(os.Stderr, "  Encode: morse -c codes.txt message.txt\n")
	fmt.Fprintf(os.Stderr, "  Decode: morse -d codes.txt message.mor\n\n")
	fmt.Fprintf(os.Stderr, "Output filenames: encoding produces message.mor; decoding produces message.txt (extension replacement when possible)\n")
}

func main() {
	encodeFlag := flag.Bool("c", false, "encode plaintext to morse")
	decodeFlag := flag.Bool("d", false, "decode morse to plaintext")
	flag.Usage = usage
	flag.Parse()

	if (*encodeFlag && *decodeFlag) || (!*encodeFlag && !*decodeFlag) {
		fmt.Fprintln(os.Stderr, "Must supply exactly one of -c (encode) or -d (decode).")
		usage()
		os.Exit(2)
	}
	args := flag.Args()
	if len(args) != 2 {
		fmt.Fprintln(os.Stderr, "Expect two arguments: <codes-file> <message-file>")
		usage()
		os.Exit(2)
	}
	codesFile := args[0]
	messageFile := args[1]

	if *encodeFlag {
		outName := deriveOutputName(messageFile, true)
		fmt.Printf("Encoding %s using codes %s -> %s\n", messageFile, codesFile, outName)
		if err := encodeFile(codesFile, messageFile, outName); err != nil {
			fmt.Fprintln(os.Stderr, "Error encoding:", err)
			os.Exit(1)
		}
		fmt.Println("Done.")
	} else {
		outName := deriveOutputName(messageFile, false)
		fmt.Printf("Decoding %s using codes %s -> %s\n", messageFile, codesFile, outName)
		if err := decodeFile(codesFile, messageFile, outName); err != nil {
			fmt.Fprintln(os.Stderr, "Error decoding:", err)
			os.Exit(1)
		}
		fmt.Println("Done.")
	}
}
