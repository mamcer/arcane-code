# Gemini CLI 0.5.5

gemini-2.5-pro

I have created the main.go file with the complete implementation.

Now, to run this, you will need to have Go installed on your system. You can compile and run the program as follows:

## Build the executable
   
```bash
go build main.go
```

This will create an executable file named main (or main.exe on Windows).

## Run the program

Use the following format to run the program:

```bash
./main [-c|-d] <morse_code_file> <input_file>
```

For example, to encode a file named mensaje.txt using morse.txt as the code file:

```bash
./main -c morse.txt mensaje.txt
```

And to decode mensaje.mor:

```bash
./main -d morse.txt mensaje.mor
```

