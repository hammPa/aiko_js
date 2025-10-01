#!/bin/bash

rm -r out

if [ -z "$1" ]; then
    echo "Usage: ./run.sh <source_file>.ak"
    exit 1
fi

INPUT_FILE="$1"

mkdir -p out

# Extract filename (tanpa ekstensi)
FILENAME="$(basename -- "$INPUT_FILE")"
BASENAME="${FILENAME%.*}"
OUTPUT_BIN="out/$BASENAME"
ASM_FILE="out/$BASENAME.asm"
OBJ_FILE="out/$BASENAME.o"

# Compile pakai transpiler JS (harus output ke $ASM_FILE)
node test/test_compiler.js "$INPUT_FILE" -o "$ASM_FILE"

if [ -f "$ASM_FILE" ]; then
    nasm -f elf32 "$ASM_FILE" -I out/ -o "$OBJ_FILE"
    ld -m elf_i386 "$OBJ_FILE" -o "$OUTPUT_BIN"

    # Run if build succeeded
    if [ -f "$OUTPUT_BIN" ]; then
        echo "Running: $OUTPUT_BIN"
        "./$OUTPUT_BIN"
    else
        echo "Linking failed!"
    fi
else
    echo "Compilation failed! $ASM_FILE not generated."
fi
