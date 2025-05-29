#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: ./run.sh <source_file>.ak (from src/)"
    exit 1
fi

INPUT_FILE="src/$1"

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "File '$INPUT_FILE' not found in src/!"
    exit 1
fi

mkdir -p out

# Extract filename and output path
FILENAME="$(basename -- "$1")"
BASENAME="${FILENAME%.*}"
OUTPUT_BIN="out/$BASENAME"

# Compile using the JS compiler in test/
node test/test_compiler.js "$INPUT_FILE"

if [ -f out/main.asm ]; then
    # nasm -f elf32 out/main.asm -o out/main.o
    nasm -f elf32 out/main.asm -I out/ -o out/main.o
    ld -m elf_i386 out/main.o -o "$OUTPUT_BIN"

    # Run if build succeeded
    if [ -f "$OUTPUT_BIN" ]; then
        echo "Running: $OUTPUT_BIN"
        "./$OUTPUT_BIN"
    else
        echo "Linking failed!"
    fi
else
    echo "Compilation failed! main.asm not generated."
fi

