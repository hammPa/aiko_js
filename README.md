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
1. `next_char()`
Fungsi ini memindahkan posisi ke karakter berikutnya dalam input string dan memperbarui currentChar dengan karakter baru di posisi tersebut.
2. `peek()`
Fungsi ini mengembalikan karakter saat ini tanpa mengubah posisi pembaca.
3. `skip_whitespace()`
Fungsi ini akan melewatkan karakter spasi, tab, dan baris baru, dan berpindah ke karakter berikutnya yang bukan spasi.
4. `isDigit(char)`
Fungsi ini memeriksa apakah karakter yang diberikan adalah angka (0-9).
6. `isAlphaNumeric(char)`
Fungsi ini memeriksa apakah karakter yang diberikan adalah huruf (alfabet), angka, atau titik (.). Ini digunakan untuk mendeteksi identifier yang dapat mengandung angka atau titik.
7. `readNumber()`
Fungsi ini membaca dan mengembalikan token untuk angka (baik integer maupun float). Jika menemukan titik (.), maka dianggap sebagai bilangan desimal.
8. `readString()`
Fungsi ini membaca dan mengembalikan token untuk string yang diawali dan diakhiri dengan tanda kutip (baik " atau ').
9. `readIdentifier()`
Fungsi ini membaca dan mengembalikan token untuk identifier (variabel atau fungsi). Fungsi ini juga memeriksa apakah identifier tersebut merupakan salah satu kata kunci (seperti var, print, if, dll.).
10. `get_next_token()`
Fungsi ini mengembalikan token berikutnya berdasarkan karakter input saat ini. Fungsi ini akan terus memindai karakter hingga menemukan token yang valid.
11. `tokenize()`
Fungsi ini akan memproses seluruh input dan mengembalikan array yang berisi semua token yang ditemukan hingga akhir input (EOF).

# Contoh Penggunaan
Berikut adalah contoh cara menggunakan lexer untuk memeriksa kode input var a = 10; dan mengembalikan token yang sesuai.
```js
var x = 10;
```
Maka akan menghasilkan output: <br/>
[<br/>
  { type: 'VAR', value: 'var' },<br/>
  { type: 'IDENTIFIER', value: 'a' },<br/>
  { type: 'ASSIGN', value: '=' },<br/>
  { type: 'INT', value: 10 },<br/>
  { type: 'SEMICOLON', value: ';' },<br/>
  { type: 'EOF', value: null }<br/>
]<br/>