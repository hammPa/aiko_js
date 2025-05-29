# Lexer - JavaScript

Lexer ini merupakan Lexical Analyzer untuk memecah input string menjadi token-token. Token-token ini digunakan oleh parser untuk analisis lebih lanjut. Kode ini dilengkapi dengan berbagai fungsi untuk memeriksa karakter dalam input dan mengidentifikasi berbagai elemen kode.

# Fitur
Lexer ini memiliki kemampuan untuk memeriksa dan mengenali:
    Angka: Integer dan float.
    String: Teks yang diapit oleh tanda kutip.
    Identifier: Variabel dan nama fungsi.
    Operator: Seperti +, -, *, /, dll.
    Pembanding dan Penugasan: Seperti =, ==, >=, !=, dll.
    Tanda baca: Seperti ;, ,, (), {}, dll.

# Fungsi-fungsi Utama
1. **`next_char()`**<br/>
Fungsi ini memindahkan posisi ke karakter berikutnya dalam input string dan memperbarui currentChar dengan karakter baru di posisi tersebut.
2. **`peek()`**<br/>
Fungsi ini mengembalikan karakter saat ini tanpa mengubah posisi pembaca.
3. **`skip_whitespace()`**<br/>
Fungsi ini akan melewatkan karakter spasi, tab, dan baris baru, dan berpindah ke karakter berikutnya yang bukan spasi.
4. **`isDigit(char)`**<br/>
Fungsi ini memeriksa apakah karakter yang diberikan adalah angka (0-9).
6. **`isAlphaNumeric(char)`**<br/>
Fungsi ini memeriksa apakah karakter yang diberikan adalah huruf (alfabet), angka, atau titik (.). Ini digunakan untuk mendeteksi identifier yang dapat mengandung angka atau titik.
7. **`readNumber()`**<br/>
Fungsi ini membaca dan mengembalikan token untuk angka (baik integer maupun float). Jika menemukan titik (.), maka dianggap sebagai bilangan desimal.
8. **`readString()`**<br/>
Fungsi ini membaca dan mengembalikan token untuk string yang diawali dan diakhiri dengan tanda kutip (baik " atau ').
9. **`readIdentifier()`**<br/>
Fungsi ini membaca dan mengembalikan token untuk identifier (variabel atau fungsi). Fungsi ini juga memeriksa apakah identifier tersebut merupakan salah satu kata kunci (seperti var, print, if, dll.).
10. **`get_next_token()`**<br/>
Fungsi ini mengembalikan token berikutnya berdasarkan karakter input saat ini. Fungsi ini akan terus memindai karakter hingga menemukan token yang valid.
11. **`tokenize()`**<br/>
Fungsi ini akan memproses seluruh input dan mengembalikan array yang berisi semua token yang ditemukan hingga akhir input (EOF).

# Contoh Penggunaan
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

# Parser - JavaScript

Parser ini digunakan untuk mengonversi sekumpulan token yang dihasilkan oleh lexer menjadi struktur yang lebih kompleks, yaitu pohon sintaksis abstrak (AST). Parser menggunakan teknik **recursive descent parsing**, yang memungkinkan untuk menangani berbagai ekspresi dan pernyataan dengan lebih mudah dan terstruktur.

# Fitur
Parser ini memiliki kemampuan untuk:<br/>
* Memproses pernyataan dasar seperti deklarasi variabel, print, dan kontrol alur (if-else, for).<br/>
* Menangani ekspresi matematika, perbandingan, dan pemanggilan fungsi.<br/>
* Membuat dan mengelola fungsi, termasuk pengembalian nilai dan parameter.<br/>
* Menghasilkan AST yang mewakili struktur kode secara hierarkis.<br/>

# Fungsi-fungsi Utama
1. **`next_token()`**<br/>
   Fungsi ini digunakan untuk menggeser posisi ke token berikutnya dalam daftar token dan memperbarui token yang sedang diproses.

2. **`match(type, value = null)`**<br/>
   Fungsi ini memeriksa apakah token berikutnya sesuai dengan tipe dan nilai yang diharapkan. Jika cocok, token berikutnya akan dibaca dan diproses.

3. **`expect(type)`**<br/>
   Fungsi ini memastikan bahwa token berikutnya sesuai dengan tipe yang diharapkan. Jika tidak, akan melemparkan error sintaks.

4. **`parse()`**<br/>
   Fungsi utama yang menginisiasi proses parsing dan memulai analisis sintaks pada seluruh input.

5. **`parseStatement()`**<br/>
   Fungsi ini mengidentifikasi dan memproses berbagai jenis pernyataan seperti deklarasi variabel, print, if-else, dan pernyataan lainnya.

6. **`parseVarDeclStmt()`**<br/>
   Fungsi ini menangani parsing pernyataan deklarasi variabel, yang melibatkan pengenalan tipe variabel dan nilai yang diberikan.

7. **`parsePrintStmt()`**<br/>
   Fungsi ini menangani parsing pernyataan print yang mencetak ekspresi atau nilai.

8. **`parseIfStmt()`**<br/>
   Fungsi ini menangani parsing pernyataan if-else, termasuk ekspresi kondisi dan blok pernyataan yang dijalankan berdasarkan kondisi tersebut.

9. **`parseForStmt()`**<br/>
   Fungsi ini menangani parsing pernyataan for loop, yang melibatkan inisialisasi, kondisi, dan langkah-langkah iterasi.

10. **`parseReturnStmt()`**<br/>
    Fungsi ini menangani parsing pernyataan return yang mengembalikan nilai dari sebuah fungsi.

11. **`parseFunctionDeclStmt()`**<br/>
    Fungsi ini menangani parsing deklarasi fungsi, termasuk nama fungsi, parameter, dan isi dari fungsi tersebut.

12. **`parseFunctionCall()`**<br/>
    Fungsi ini menangani parsing pemanggilan fungsi dengan mengidentifikasi nama fungsi dan argumen yang diberikan.

13. **`parseBlock()`**<br/>
    Fungsi ini menangani parsing blok kode, yaitu kumpulan pernyataan yang dikelilingi oleh tanda kurung kurawal `{}`.

14. **`parseExpressionUntil()`**<br/>
    Fungsi ini membaca ekspresi hingga menemukan token yang tidak dapat diterima dalam ekspresi, seperti tanda kurung tutup atau pernyataan akhir.

15. **`parseExpression()`**<br/>
    Fungsi ini mengonversi token ekspresi menjadi struktur pohon sintaksis yang sesuai dengan aturan bahasa.

16. **`parseEquality()`**<br/>
    Fungsi ini menangani ekspresi perbandingan seperti `==` dan `!=`.

17. **`parseComparison()`**<br/>
    Fungsi ini menangani ekspresi perbandingan seperti `>`, `<`, `>=`, `<=`.

18. **`parseTerm()`**<br/>
    Fungsi ini menangani ekspresi aritmatika untuk operasi penjumlahan dan pengurangan.

19. **`parseFactor()`**<br/>
    Fungsi ini menangani ekspresi aritmatika untuk operasi perkalian dan pembagian.

20. **`parsePrimary()`**<br/>
    Fungsi ini menangani ekspresi primer, seperti angka, string, atau identifier.

# Contoh Penggunaan
Berikut adalah contoh cara menggunakan parser untuk memproses kode input dan menghasilkan AST.<br/>

```js
var x = 10;
if (x > 5) {
  print(x);
}
```

Hasil AST yang dihasilkan:

```js
{
  type: 'Program',
  body: [
    {
      type: 'VariableDeclaration',
      id: { type: 'Identifier', name: 'x' },
      init: { type: 'Literal', value: 10 }
    },
    {
      type: 'IfStatement',
      test: {
        type: 'BinaryExpression',
        left: { type: 'Identifier', name: 'x' },
        operator: '>',
        right: { type: 'Literal', value: 5 }
      },
      consequent: {
        type: 'BlockStatement',
        body: [
          {
            type: 'ExpressionStatement',
            expression: {
              type: 'CallExpression',
              callee: { type: 'Identifier', name: 'print' },
              arguments: [{ type: 'Identifier', name: 'x' }]
            }
          }
        ]
      }
    }
  ]
}
```

---
