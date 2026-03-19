# Aiko
Aiko adalah compiler sederhana yang dikembangkan dengan JavaScript untuk mengubah kode sumber menjadi bahasa assembly x86. Proyek ini mencakup pembuatan Lexer, Parser (AST), hingga Code Generator.

## Alur Kerja

<ul>
  <li>Lexer: Memecah string input menjadi token (kata kunci, operator, literal).</li>
  <li>Parser: Menyusun token menjadi Abstract Syntax Tree (AST) menggunakan teknik Recursive Descent.</li>
  <li>Compiler: Mentranslasi AST menjadi instruksi x86 Assembly (NASM syntax).</li>
</ul>

---

# Lexer

Lexer ini merupakan Lexical Analyzer untuk memecah input string menjadi token-token. Token-token ini digunakan oleh parser untuk analisis lebih lanjut. Kode ini dilengkapi dengan berbagai fungsi untuk memeriksa karakter dalam input dan mengidentifikasi berbagai elemen kode.

## Fitur
Lexer ini memiliki kemampuan untuk memeriksa dan mengenali:
    Angka: Integer dan float.
    String: Teks yang diapit oleh tanda kutip.
    Identifier: Variabel dan nama fungsi.
    Operator: Seperti +, -, *, /, dll.
    Pembanding dan Penugasan: Seperti =, ==, >=, !=, dll.
    Tanda baca: Seperti ;, ,, (), {}, dll.


## Contoh Penggunaan
Berikut adalah contoh cara menggunakan lexer untuk memeriksa kode input var a = 10; dan mengembalikan token yang sesuai.

```js
var x = 10;
```
Maka akan menghasilkan output: <br/>

```js
[
  { type: 'VAR', value: 'var' },
  { type: 'IDENTIFIER', value: 'a' },
  { type: 'ASSIGN', value: '=' },
  { type: 'INT', value: 10 },
  { type: 'SEMICOLON', value: ';' },
  { type: 'EOF', value: null }
]
```







---

# Parser

Parser ini digunakan untuk mengonversi sekumpulan token yang dihasilkan oleh lexer menjadi struktur yang lebih kompleks, yaitu pohon sintaksis abstrak (AST). Parser menggunakan teknik **recursive descent parsing**, yang memungkinkan untuk menangani berbagai ekspresi dan pernyataan dengan lebih mudah dan terstruktur.

## Fitur
Parser ini memiliki kemampuan untuk:<br/>
* Memproses pernyataan dasar seperti deklarasi variabel, print, dan kontrol alur (if-else, for).<br/>
* Menangani ekspresi matematika, perbandingan, dan pemanggilan fungsi.<br/>
* Membuat dan mengelola fungsi, termasuk pengembalian nilai dan parameter.<br/>
* Menghasilkan AST yang mewakili struktur kode secara hierarkis.<br/>

## Contoh Penggunaan
Berikut adalah contoh cara menggunakan parser untuk memproses kode input dan menghasilkan AST.<br/>

```js
var x = 10;
if x > 5 {
  print(x);
}
```

Hasil AST yang dihasilkan:

```js
ProgramStmt {
  type: 'Program',
  statements: [
    VarDeclStmt {
      type: 'VarDecl',
      name: 'x',
      initializer: LiteralStmt { type: 'Literal', value: 10 }
    },
    IfStmt {
      type: 'If',
      condition: BinaryOpStmt {
        type: 'BinaryOp',
        left: IdentifierStmt { type: 'Identifier', name: 'x' },
        op: '>',
        right: LiteralStmt { type: 'Literal', value: 5 }
      },
      then_block: [
        PrintStmt {
          type: 'Print',
          expression: IdentifierStmt { type: 'Identifier', name: 'x' }
        }
      ],
      elifs: [],
      else_block: null
    }
  ]
}
```

---
# Compiler
Compiler ini bertanggung jawab untuk mengonversi Abstract Syntax Tree (AST) dari kode sumber menjadi kode assembler, serta menangani berbagai jenis pernyataan dan ekspresi dalam kode tersebut. Kode ini mendemonstrasikan cara-cara menangani deklarasi variabel, kontrol alur (seperti `if` dan `for`), serta fungsi (seperti deklarasi fungsi dan pernyataan `return`).

## Fitur
Compiler ini memiliki kemampuan untuk menangani:<br/>
* Deklarasi variabel (termasuk literal dan array).<br/>
* Ekspresi aritmatika dan logika (seperti penambahan, pengurangan, perbandingan, dll.).<br/>
* Pernyataan kontrol seperti `if` dan `for`.<br/>
* Deklarasi dan pemanggilan fungsi.<br/>
* Pencetakan hasil ekspresi (seperti nilai variabel atau hasil perhitungan).<br/>

## Contoh Penggunaan
Berikut adalah contoh cara compiler ini menangani kode sumber yang menggunakan deklarasi variabel, operasi aritmatika, dan perintah `print`.
Misalnya, kode sumber berikut:

```js
var a = 10;
var b = 5;
var c = a + b;
print(c);
```

Compiler akan menghasilkan kode assembler yang mirip dengan ini:

```asm
                           ; ------------------------------ Start Literal ------------------------------
push 8                     ; ------------------------------ alokasi untuk 1 element ------------------------------
call arena_alloc
add esp, 4
mov dword [eax], 10        ; alamat dalam register eax = 10
mov dword [eax + 4], 0     ; tipe data = angka sebagai 0
                           ; ------------------------------ End Literal ------------------------------
                           ; ------------------------------ Start Deklarasi variabel a ------------------------------
sub esp, 4
mov dword [ebp - 4], eax   ; pindahkan alamat Box* ke dalam offset 4
                           ; ------------------------------ End Deklarasi variabel a ------------------------------
                           ; ------------------------------ Start Literal ------------------------------
push 8                     ; ------------------------------ alokasi untuk 1 element ------------------------------
call arena_alloc
add esp, 4
mov dword [eax], 5         ; alamat dalam register eax = 5
mov dword [eax + 4], 0     ; tipe data = angka sebagai 0
                           ; ------------------------------ End Literal ------------------------------
                           ; ------------------------------ Start Deklarasi variabel b ------------------------------
sub esp, 4
mov dword [ebp - 8], eax   ; pindahkan alamat Box* ke dalam offset 8
                           ; ------------------------------ End Deklarasi variabel b ------------------------------
                           ; ------------------------------ Start Binary Op (+) ------------------------------
                           ; ------------------------------ Start Ambil offset variabel a ------------------------------
mov eax, [ebp - 4]         ; eax = Box*
                           ; ------------------------------ End Ambil offset variabel a ------------------------------
mov eax, eax
mov edx, [eax]             ; Unbox left ke EDX
push edx                   ; simpan left value
                           ; ------------------------------ Start Ambil offset variabel b ------------------------------
mov eax, [ebp - 8]         ; eax = Box*
                           ; ------------------------------ End Ambil offset variabel b ------------------------------
mov eax, eax
mov ebx, [eax]             ; Unbox right ke EBX
pop edx                    ; restore left value ke edx
add edx, ebx
                           ; ------------------------------ End Binary Op + ------------------------------
                           ; simpan hasil di box
push edx
push 8                     ; ------------------------------ alokasi untuk 1 element ------------------------------
call arena_alloc
add esp, 4
pop edx
mov [eax], edx
mov dword [eax + 4], 0
                           ; ------------------------------ Start Deklarasi variabel c ------------------------------
sub esp, 4
mov dword [ebp - 12], eax  ; pindahkan alamat Box* ke dalam offset 12
                           ; ------------------------------ End Deklarasi variabel c ------------------------------
```

---

# Penutup
Aiko adalah proyek yang mengubah kode yang biasa kita tulis menjadi instruksi bahasa mesin (Assembly x86) yang sangat dasar. Melalui Aiko, kita bisa melihat bagaimana sebuah logika program diolah secara rapi di dalam memori komputer melalui sistem penyimpanan data yang cerdas.