Nice — here’s a complete, ready-to-run Go program that implements the Morse encoder/decoder described in your PDF (it reads a codes file like A:.-, encodes text → .mor or decodes .mor → text). I used the spec in your uploaded PDF as a reference. 

Trabajo especial 99

Features implemented

Reads the Morse code table from a text file with lines of the form: A:.- (case-insensitive keys). Blank lines and lines without a colon are ignored.

-c (encode): reads a plaintext input file and writes a .mor file. Letters are converted based on the code table; unknown characters are output as ?.

Output format: letters separated by single spaces, words separated by /, line breaks preserved.

-d (decode): reads a .mor file and writes a .txt file. / (slash) separates words, single spaces separate letters. Unknown codes become ?.

Output filename is derived from input filename by swapping .txt↔.mor when possible; otherwise .mor or .txt is appended.

Robust error handling and helpful usage instructions.

Save this as morse.go. Build with go build morse.go and run as shown below.

How to use

Build:

go build -o morse morse.go

Encode example:

./morse -c codigos.txt mensaje.txt → produces mensaje.mor

Decode example:

./morse -d codigos.txt mensaje.mor → produces mensaje.txt

Notes and choices I made

Morse text format: I use a common simple textual format: letters separated by single spaces, words separated by / (slash). This is explicit and easy to parse for the decoder. Example encoded line:

.... . .-.. .-.. --- / .-- --- .-. .-.. -..


which decodes to HELLO WORLD.

Unknown characters / codes: represented as ? so errors are visible in output instead of silently dropped.

Case-insensitive keys in the codes file: a:.- or A:.- both OK.

Extensible: The morse codes file can include digits or punctuation as keys (e.g., 1:.----). Multi-character keys like SOS:...---... will be treated as an entry "SOS" mapping to code—encoding will only match single characters (so include S O S separately unless your codes file uses explicit separate lines).

