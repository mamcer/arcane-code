package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {
	if len(os.Args) != 4 {
		fmt.Println("Uso: morse [-c|-d] <archivo_morse> <archivo_entrada>")
		os.Exit(1)
	}

	operation := os.Args[1]
	morseFile := os.Args[2]
	inputFile := os.Args[3]

	morseMap, reverseMorseMap := loadMorseCodes(morseFile)

	switch operation {
	case "-c":
		encode(inputFile, morseMap)
	case "-d":
		decode(inputFile, reverseMorseMap)
	default:
		fmt.Println("Operación no válida. Use -c para codificar o -d para decodificar.")
		os.Exit(1)
	}
}

func loadMorseCodes(filename string) (map[string]string, map[string]string) {
	file, err := os.Open(filename)
	if err != nil {
		fmt.Printf("Error al abrir el archivo de códigos Morse: %v\n", err)
		os.Exit(1)
	}
	defer file.Close()

	morseMap := make(map[string]string)
	reverseMorseMap := make(map[string]string)
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		parts := strings.Split(line, ":")
		if len(parts) == 2 {
			char := strings.TrimSpace(parts[0])
			code := strings.TrimSpace(parts[1])
			morseMap[char] = code
			reverseMorseMap[code] = char
		}
	}
	return morseMap, reverseMorseMap
}

func encode(inputFile string, morseMap map[string]string) {
	file, err := os.Open(inputFile)
	if err != nil {
		fmt.Printf("Error al abrir el archivo de entrada: %v\n", err)
		os.Exit(1)
	}
	defer file.Close()

	outputFile := strings.TrimSuffix(inputFile, ".txt") + ".mor"
	outFile, err := os.Create(outputFile)
	if err != nil {
		fmt.Printf("Error al crear el archivo de salida: %v\n", err)
		os.Exit(1)
	}
	defer outFile.Close()

	writer := bufio.NewWriter(outFile)
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		for _, char := range line {
			if code, ok := morseMap[string(char)]; ok {
				fmt.Fprintf(writer, "%s ", code)
			}
		}
		fmt.Fprintln(writer)
	}
	writer.Flush()
	fmt.Printf("Archivo codificado guardado en: %s\n", outputFile)
}

func decode(inputFile string, reverseMorseMap map[string]string) {
	file, err := os.Open(inputFile)
	if err != nil {
		fmt.Printf("Error al abrir el archivo de entrada: %v\n", err)
		os.Exit(1)
	}
	defer file.Close()

	outputFile := strings.TrimSuffix(inputFile, ".mor") + ".txt"
	outFile, err := os.Create(outputFile)
	if err != nil {
		fmt.Printf("Error al crear el archivo de salida: %v\n", err)
		os.Exit(1)
	}
	defer outFile.Close()

	writer := bufio.NewWriter(outFile)
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		words := strings.Split(line, " ")
		for _, word := range words {
			if char, ok := reverseMorseMap[word]; ok {
				fmt.Fprintf(writer, "%s", char)
			}
		}
		fmt.Fprintln(writer)
	}
	writer.Flush()
	fmt.Printf("Archivo decodificado guardado en: %s\n", outputFile)
}
