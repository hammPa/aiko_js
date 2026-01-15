%include "/home/hamm/Documents/aiko_js_fullstack/aiko_js/helper/stdio.asm"
section .data
	str_0 db "hello world", 0    ; buat variabel string global bernama str_0 dengan tipe byte
	str_1 db "coba string", 0    ; buat variabel string global bernama str_1 dengan tipe byte
	str_2 db "hemm", 0    ; buat variabel string global bernama str_2 dengan tipe byte
	str_3 db "wello", 0    ; buat variabel string global bernama str_3 dengan tipe byte
	str_4 db "ganti assign1", 0    ; buat variabel string global bernama str_4 dengan tipe byte
	str_5 db "44444", 0    ; buat variabel string global bernama str_5 dengan tipe byte
	str_6 db "oi", 0    ; buat variabel string global bernama str_6 dengan tipe byte
	str_7 db "muehehehehe", 0    ; buat variabel string global bernama str_7 dengan tipe byte
	str_8 db "elif", 0    ; buat variabel string global bernama str_8 dengan tipe byte
	str_9 db "elif2", 0    ; buat variabel string global bernama str_9 dengan tipe byte
	str_10 db "elif3", 0    ; buat variabel string global bernama str_10 dengan tipe byte
	str_11 db "else", 0    ; buat variabel string global bernama str_11 dengan tipe byte
	str_12 db "ini 0", 0    ; buat variabel string global bernama str_12 dengan tipe byte
	str_13 db "hello inner", 0    ; buat variabel string global bernama str_13 dengan tipe byte
	str_14 db "hemm", 0    ; buat variabel string global bernama str_14 dengan tipe byte
	str_15 db "mellow", 0    ; buat variabel string global bernama str_15 dengan tipe byte
	str_16 db "hello", 0    ; buat variabel string global bernama str_16 dengan tipe byte
	str_17 db "apa ya", 0    ; buat variabel string global bernama str_17 dengan tipe byte
	str_18 db "apa ya", 0    ; buat variabel string global bernama str_18 dengan tipe byte
	str_19 db "gello", 0    ; buat variabel string global bernama str_19 dengan tipe byte
	str_20 db "woi", 0    ; buat variabel string global bernama str_20 dengan tipe byte
	str_21 db "Masukkan string: ", 0    ; buat variabel string global bernama str_21 dengan tipe byte
	str_22 db "Masukkan angka: ", 0    ; buat variabel string global bernama str_22 dengan tipe byte
	str_23 db "jadi str", 0    ; buat variabel string global bernama str_23 dengan tipe byte

section .bss

section .text
    global _start

_start:
    push ebp
    mov ebp, esp

    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (10)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 1    ; masukkan nilai true dengan angka berupa 1 ke alamat dalam register eax
    mov dword [eax + 4], 2    ; masukkan tipe data dari value, yaitu boolean
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (true)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], str_0    ; masukkan alamat label ke alamat dalam register eax
    mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (hello world)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Compare Literals ------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    push eax
    mov ecx, 10    ; masukkan nilai 10 ke register ecx
    mov edx, ecx
    mov ecx, 5    ; masukkan nilai 5 ke register ecx
    mov ebx, ecx
    pop eax
    add edx, ebx
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (0)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Compare Literals ------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    push eax
    mov ecx, 10    ; masukkan nilai 10 ke register ecx
    mov edx, ecx
    mov ecx, 2    ; masukkan nilai 2 ke register ecx
    mov ebx, ecx
    pop eax
    sub edx, ebx
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (0)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Compare Literals ------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    push eax
    mov ecx, 10    ; masukkan nilai 10 ke register ecx
    mov edx, ecx
    mov ecx, 4    ; masukkan nilai 4 ke register ecx
    mov ebx, ecx
    pop eax
    imul edx, ebx
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (0)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Compare Literals ------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    push eax
    mov ecx, 10    ; masukkan nilai 10 ke register ecx
    mov edx, ecx
    mov ecx, 2    ; masukkan nilai 2 ke register ecx
    mov ebx, ecx
    pop eax
    push eax    ; simpan alamat result
    mov eax, edx    ; eax = dibagi
    cdq
    idiv ebx    ; eax = eax / ebx
    mov edx, eax    ; pindahkan hasil bagi ke edx
    pop eax    ; kembalikan alamat result
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (0)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Binary Expression ------------------------------
    ; ------------------------------ Binary Expression ------------------------------
    ; ------------------------------ Compare Literals ------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    push eax
    mov ecx, 10    ; masukkan nilai 10 ke register ecx
    mov edx, ecx
    mov ecx, 4    ; masukkan nilai 4 ke register ecx
    mov ebx, ecx
    pop eax
    imul edx, ebx
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    push eax    ; simpan Box* left operand ke stack
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 2    ; masukkan nilai 2 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    mov esi, eax    ; esi = Box* right operand
    pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
    push edi
    push esi
    ; result disimpan di register eax
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop esi
    pop edi
    mov edx, [edi]      ; ambil left value dari edi
    mov ebx, [esi]      ; ambil right value dari esi
    push eax    ; simpan alamat result
    mov eax, edx    ; eax = dibagi
    cdq
    idiv ebx    ; eax = eax / ebx
    mov edx, eax    ; pindahkan hasil bagi ke edx
    pop eax    ; kembalikan alamat result
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    push eax    ; simpan Box* left operand ke stack
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 1    ; masukkan nilai 1 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    mov esi, eax    ; esi = Box* right operand
    pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
    push edi
    push esi
    ; result disimpan di register eax
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop esi
    pop edi
    mov edx, [edi]      ; ambil left value dari edi
    mov ebx, [esi]      ; ambil right value dari esi
    add edx, ebx
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (0)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Compare Literals ------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    push eax
    mov ecx, 10    ; masukkan nilai 10 ke register ecx
    mov edx, ecx
    mov ecx, 3    ; masukkan nilai 3 ke register ecx
    mov ebx, ecx
    pop eax
    push eax    ; simpan alamat result
    mov eax, edx
    cdq
    idiv ebx
    pop eax
    mov [eax], edx
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (0)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 0    ; masukkan nilai false dengan angka berupa 0 ke alamat dalam register eax
    mov dword [eax + 4], 2    ; masukkan tipe data dari value, yaitu boolean
    push eax    ; simpan Box* operand unary
    ; result disimpan di register eax
    ; Alokasikan 8 byte untuk Box (value + type)
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop ecx     ; ecx = Box* operand
    mov ebx, [ecx]  ; ebx = operand value
    cmp ebx, 0
    sete bl        ; bl = (ebx == 0)
    movzx ebx, bl ; ebx = zero-extended result
    mov [eax], ebx ; simpan hasil unary ke Box result
    mov edx, [ecx + 4]  ; ambil type operand
    mov [eax + 4], edx  ; type result = type operand
    push eax    ; simpan Box* operand unary
    ; result disimpan di register eax
    ; Alokasikan 8 byte untuk Box (value + type)
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop ecx     ; ecx = Box* operand
    mov ebx, [ecx]  ; ebx = operand value
    cmp ebx, 0
    sete bl        ; bl = (ebx == 0)
    movzx ebx, bl ; ebx = zero-extended result
    mov [eax], ebx ; simpan hasil unary ke Box result
    mov edx, [ecx + 4]  ; ambil type operand
    mov [eax + 4], edx  ; type result = type operand
    push eax    ; simpan Box* operand unary
    ; result disimpan di register eax
    ; Alokasikan 8 byte untuk Box (value + type)
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop ecx     ; ecx = Box* operand
    mov ebx, [ecx]  ; ebx = operand value
    cmp ebx, 0
    sete bl        ; bl = (ebx == 0)
    movzx ebx, bl ; ebx = zero-extended result
    mov [eax], ebx ; simpan hasil unary ke Box result
    mov edx, [ecx + 4]  ; ambil type operand
    mov [eax + 4], edx  ; type result = type operand
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (false)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Binary Expression ------------------------------
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], -8    ; masukkan nilai -8 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    push eax    ; simpan Box* operand unary
    ; result disimpan di register eax
    ; Alokasikan 8 byte untuk Box (value + type)
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop ecx     ; ecx = Box* operand
    mov ebx, [ecx]  ; ebx = operand value
    cmp ebx, 0
    sete bl        ; bl = (ebx == 0)
    movzx ebx, bl ; ebx = zero-extended result
    mov [eax], ebx ; simpan hasil unary ke Box result
    mov edx, [ecx + 4]  ; ambil type operand
    mov [eax + 4], edx  ; type result = type operand
    push eax    ; simpan Box* operand unary
    ; result disimpan di register eax
    ; Alokasikan 8 byte untuk Box (value + type)
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop ecx     ; ecx = Box* operand
    mov ebx, [ecx]  ; ebx = operand value
    cmp ebx, 0
    sete bl        ; bl = (ebx == 0)
    movzx ebx, bl ; ebx = zero-extended result
    mov [eax], ebx ; simpan hasil unary ke Box result
    mov edx, [ecx + 4]  ; ambil type operand
    mov [eax + 4], edx  ; type result = type operand
    push eax    ; simpan Box* left operand ke stack
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 3    ; masukkan nilai 3 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    mov esi, eax    ; esi = Box* right operand
    pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
    push edi
    push esi
    ; result disimpan di register eax
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop esi
    pop edi
    mov edx, [edi]      ; ambil left value dari edi
    mov ebx, [esi]      ; ambil right value dari esi
    imul edx, ebx
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (0)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 888    ; masukkan nilai 888 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------Deklarasi variabel x------------------------------
    sub esp, 4
    mov dword [ebp - 4], eax    ; pindahkan alamat Box* ke dalam offset 4


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 9987    ; masukkan nilai 9987 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------Deklarasi variabel y------------------------------
    sub esp, 4
    mov dword [ebp - 8], eax    ; pindahkan alamat Box* ke dalam offset 8


    ; ------------------------------Ambil offset variabel x------------------------------
    mov eax, [ebp - 4]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (4)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Ambil offset variabel y------------------------------
    mov eax, [ebp - 8]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (8)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Binary Expression ------------------------------
    ; ------------------------------Ambil offset variabel x------------------------------
    mov eax, [ebp - 4]    ; eax = Box*
    push eax    ; simpan Box* left operand ke stack
    ; ------------------------------Ambil offset variabel y------------------------------
    mov eax, [ebp - 8]    ; eax = Box*
    mov esi, eax    ; esi = Box* right operand
    pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
    push edi
    push esi
    ; result disimpan di register eax
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop esi
    pop edi
    mov edx, [edi]      ; ambil left value dari edi
    mov ebx, [esi]      ; ambil right value dari esi
    add edx, ebx
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    ; ------------------------------Deklarasi variabel sum------------------------------
    sub esp, 4
    mov dword [ebp - 12], eax    ; pindahkan alamat Box* ke dalam offset 12


    ; ------------------------------Ambil offset variabel sum------------------------------
    mov eax, [ebp - 12]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (12)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], str_1    ; masukkan alamat label ke alamat dalam register eax
    mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
    ; ------------------------------Deklarasi variabel z------------------------------
    sub esp, 4
    mov dword [ebp - 16], eax    ; pindahkan alamat Box* ke dalam offset 16


    ; ------------------------------Ambil offset variabel z------------------------------
    mov eax, [ebp - 16]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (16)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 0    ; masukkan nilai false dengan angka berupa 0 ke alamat dalam register eax
    mov dword [eax + 4], 2    ; masukkan tipe data dari value, yaitu boolean
    ; ------------------------------Deklarasi variabel contohBool------------------------------
    sub esp, 4
    mov dword [ebp - 20], eax    ; pindahkan alamat Box* ke dalam offset 20


    ; ------------------------------Ambil offset variabel contohBool------------------------------
    mov eax, [ebp - 20]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (20)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], str_2    ; masukkan alamat label ke alamat dalam register eax
    mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
    ; ------------------------------Deklarasi variabel assign1------------------------------
    sub esp, 4
    mov dword [ebp - 24], eax    ; pindahkan alamat Box* ke dalam offset 24


    ; ------------------------------Ambil offset variabel assign1------------------------------
    mov eax, [ebp - 24]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (24)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 0    ; masukkan nilai 0 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------Deklarasi variabel assign2------------------------------
    sub esp, 4
    mov dword [ebp - 28], eax    ; pindahkan alamat Box* ke dalam offset 28


    ; ------------------------------Ambil offset variabel assign2------------------------------
    mov eax, [ebp - 28]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (28)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 1    ; masukkan nilai true dengan angka berupa 1 ke alamat dalam register eax
    mov dword [eax + 4], 2    ; masukkan tipe data dari value, yaitu boolean
    ; ------------------------------ Assign ke variabel assign2 ------------------------------
    mov dword [ebp - 28], eax    ; assign2 = Box*
    ; ------------------------------Ambil offset variabel assign2------------------------------
    mov eax, [ebp - 28]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (28)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------ Assign ke variabel assign2 ------------------------------
    mov dword [ebp - 28], eax    ; assign2 = Box*
    ; ------------------------------Ambil offset variabel assign2------------------------------
    mov eax, [ebp - 28]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (28)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], str_3    ; masukkan alamat label ke alamat dalam register eax
    mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
    ; ------------------------------ Assign ke variabel assign2 ------------------------------
    mov dword [ebp - 28], eax    ; assign2 = Box*
    ; ------------------------------Ambil offset variabel assign2------------------------------
    mov eax, [ebp - 28]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (28)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Ambil offset variabel assign1------------------------------
    mov eax, [ebp - 24]    ; eax = Box*
    ; ------------------------------ Assign ke variabel assign2 ------------------------------
    mov dword [ebp - 28], eax    ; assign2 = Box*
    ; ------------------------------Ambil offset variabel assign2------------------------------
    mov eax, [ebp - 28]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (28)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Ambil offset variabel assign1------------------------------
    mov eax, [ebp - 24]    ; eax = Box*
    ; ------------------------------Deklarasi variabel assignDecl------------------------------
    sub esp, 4
    mov dword [ebp - 32], eax    ; pindahkan alamat Box* ke dalam offset 32


    ; ------------------------------Ambil offset variabel assignDecl------------------------------
    mov eax, [ebp - 32]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (32)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], str_4    ; masukkan alamat label ke alamat dalam register eax
    mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
    ; ------------------------------ Assign ke variabel assign1 ------------------------------
    mov dword [ebp - 24], eax    ; assign1 = Box*
    ; ------------------------------Ambil offset variabel assign1------------------------------
    mov eax, [ebp - 24]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (24)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Ambil offset variabel assignDecl------------------------------
    mov eax, [ebp - 32]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (32)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 90    ; masukkan nilai 90 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------Deklarasi variabel first------------------------------
    sub esp, 4
    mov dword [ebp - 36], eax    ; pindahkan alamat Box* ke dalam offset 36


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 90    ; masukkan nilai 90 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------Deklarasi variabel second------------------------------
    sub esp, 4
    mov dword [ebp - 40], eax    ; pindahkan alamat Box* ke dalam offset 40


    ; ------------------------------ Binary Expression ------------------------------
    ; ------------------------------Ambil offset variabel first------------------------------
    mov eax, [ebp - 36]    ; eax = Box*
    push eax    ; simpan Box* left operand ke stack
    ; ------------------------------Ambil offset variabel second------------------------------
    mov eax, [ebp - 40]    ; eax = Box*
    mov esi, eax    ; esi = Box* right operand
    pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
    push edi
    push esi
    ; result disimpan di register eax
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop esi
    pop edi
    mov edx, [edi]      ; ambil left value dari edi
    mov ebx, [esi]      ; ambil right value dari esi
    cmp edx, ebx
    setl bl
    movzx edx, bl
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    ; ------------------------------Deklarasi variabel isSmall------------------------------
    sub esp, 4
    mov dword [ebp - 44], eax    ; pindahkan alamat Box* ke dalam offset 44


    ; ------------------------------ Binary Expression ------------------------------
    ; ------------------------------Ambil offset variabel first------------------------------
    mov eax, [ebp - 36]    ; eax = Box*
    push eax    ; simpan Box* left operand ke stack
    ; ------------------------------Ambil offset variabel second------------------------------
    mov eax, [ebp - 40]    ; eax = Box*
    mov esi, eax    ; esi = Box* right operand
    pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
    push edi
    push esi
    ; result disimpan di register eax
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop esi
    pop edi
    mov edx, [edi]      ; ambil left value dari edi
    mov ebx, [esi]      ; ambil right value dari esi
    cmp edx, ebx
    setl bl
    movzx edx, bl
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (0)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Ambil offset variabel isSmall------------------------------
    mov eax, [ebp - 44]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (44)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Compare Literals ------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    push eax
    mov ecx, 10    ; masukkan nilai 10 ke register ecx
    mov edx, ecx
    mov ecx, 5    ; masukkan nilai 5 ke register ecx
    mov ebx, ecx
    pop eax
    cmp edx, ebx
    sete bl
    movzx edx, bl
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (0)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Binary Expression ------------------------------
    ; ------------------------------Ambil offset variabel first------------------------------
    mov eax, [ebp - 36]    ; eax = Box*
    push eax    ; simpan Box* left operand ke stack
    ; ------------------------------Ambil offset variabel second------------------------------
    mov eax, [ebp - 40]    ; eax = Box*
    mov esi, eax    ; esi = Box* right operand
    pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
    push edi
    push esi
    ; result disimpan di register eax
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop esi
    pop edi
    mov edx, [edi]      ; ambil left value dari edi
    mov ebx, [esi]      ; ambil right value dari esi
    cmp edx, ebx
    sete bl
    movzx edx, bl
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (0)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Binary Expression ------------------------------
    ; ------------------------------Ambil offset variabel first------------------------------
    mov eax, [ebp - 36]    ; eax = Box*
    push eax    ; simpan Box* left operand ke stack
    ; ------------------------------Ambil offset variabel second------------------------------
    mov eax, [ebp - 40]    ; eax = Box*
    mov esi, eax    ; esi = Box* right operand
    pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
    push edi
    push esi
    ; result disimpan di register eax
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop esi
    pop edi
    mov edx, [edi]      ; ambil left value dari edi
    mov ebx, [esi]      ; ambil right value dari esi
    cmp edx, ebx
    setne bl
    movzx edx, bl
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (0)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Binary Expression ------------------------------
    ; ------------------------------Ambil offset variabel first------------------------------
    mov eax, [ebp - 36]    ; eax = Box*
    push eax    ; simpan Box* left operand ke stack
    ; ------------------------------Ambil offset variabel second------------------------------
    mov eax, [ebp - 40]    ; eax = Box*
    mov esi, eax    ; esi = Box* right operand
    pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
    push edi
    push esi
    ; result disimpan di register eax
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop esi
    pop edi
    mov edx, [edi]      ; ambil left value dari edi
    mov ebx, [esi]      ; ambil right value dari esi
    cmp edx, ebx
    setge bl
    movzx edx, bl
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (0)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Binary Expression ------------------------------
    ; ------------------------------Ambil offset variabel first------------------------------
    mov eax, [ebp - 36]    ; eax = Box*
    push eax    ; simpan Box* left operand ke stack
    ; ------------------------------Ambil offset variabel second------------------------------
    mov eax, [ebp - 40]    ; eax = Box*
    mov esi, eax    ; esi = Box* right operand
    pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
    push edi
    push esi
    ; result disimpan di register eax
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop esi
    pop edi
    mov edx, [edi]      ; ambil left value dari edi
    mov ebx, [esi]      ; ambil right value dari esi
    cmp edx, ebx
    setle bl
    movzx edx, bl
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (0)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Kondisi if 0 ------------------------------
    ; ------------------------------ Compare Literals ------------------------------
    mov ecx, 10    ; masukkan nilai 10 ke register ecx
    mov edx, ecx
    mov ecx, 5    ; masukkan nilai 5 ke register ecx
    mov ebx, ecx
    cmp edx, ebx
    setg bl
    movzx edx, bl
    mov eax, edx
    ; jika false maka lanjut kondisi selanjutnya
    cmp eax, 0
    je if_0_end
    jmp if_0_then
    if_0_then:
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_5    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (44444)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


    push eax
    pop eax
    jmp if_0_end


    if_0_end:


    ; ------------------------------ Kondisi if 1 ------------------------------
    ; ------------------------------ Condition Comparison ------------------------------
    mov ecx, 10    ; masukkan nilai 10 ke register ecx
    mov edx, ecx      ; ambil value langsung dari ecx
    push edx          ; simpan left value sementara ke stack
    ; ------------------------------Ambil offset variabel first------------------------------
    mov eax, [ebp - 36]    ; eax = Box*
    mov ebx, [eax]    ; ambil value right dari Box
    pop edx           ; kembalikan left value ke EDX
    cmp edx, ebx
    setl bl
    movzx edx, bl
    mov eax, edx
    ; jika false maka lanjut kondisi selanjutnya
    cmp eax, 0
    je if_1_end
    jmp if_1_then
    if_1_then:
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_6    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (oi)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


    push eax
    pop eax
    jmp if_1_end


    if_1_end:


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 100    ; masukkan nilai 100 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------Deklarasi variabel nilai------------------------------
    sub esp, 4
    mov dword [ebp - 48], eax    ; pindahkan alamat Box* ke dalam offset 48


    ; ------------------------------ Kondisi if 2 ------------------------------
    ; ------------------------------ Condition Comparison ------------------------------
    ; ------------------------------Ambil offset variabel nilai------------------------------
    mov eax, [ebp - 48]    ; eax = Box*
    mov edx, [eax]    ; ambil value dari alamat Box di eax
    push edx          ; simpan left value sementara ke stack
    mov ecx, 10    ; masukkan nilai 10 ke register ecx
    mov ebx, ecx      ; ambil value right langsung
    pop edx           ; kembalikan left value ke EDX
    cmp edx, ebx
    setne bl
    movzx edx, bl
    mov eax, edx
    ; jika false maka lanjut kondisi selanjutnya
    cmp eax, 0
    je if_2_elif_0_cond
    jmp if_2_then
    if_2_then:
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_7    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (muehehehehe)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


    push eax
    pop eax
    jmp if_2_end


    if_2_elif_0_cond:
    ; ------------------------------ Condition Comparison ------------------------------
    ; ------------------------------Ambil offset variabel nilai------------------------------
    mov eax, [ebp - 48]    ; eax = Box*
    mov edx, [eax]    ; ambil value dari alamat Box di eax
    push edx          ; simpan left value sementara ke stack
    mov ecx, 9    ; masukkan nilai 9 ke register ecx
    mov ebx, ecx      ; ambil value right langsung
    pop edx           ; kembalikan left value ke EDX
    cmp edx, ebx
    sete al
    movzx eax, al
    cmp dword eax, 0
    je if_2_elif_1_cond
    jmp if_2_elif_0_then


    if_2_elif_0_then:
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_8    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (elif)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


    push eax
    pop eax
    jmp if_2_end


    if_2_elif_1_cond:
    ; ------------------------------ Condition Comparison ------------------------------
    ; ------------------------------Ambil offset variabel nilai------------------------------
    mov eax, [ebp - 48]    ; eax = Box*
    mov edx, [eax]    ; ambil value dari alamat Box di eax
    push edx          ; simpan left value sementara ke stack
    mov ecx, 7    ; masukkan nilai 7 ke register ecx
    mov ebx, ecx      ; ambil value right langsung
    pop edx           ; kembalikan left value ke EDX
    cmp edx, ebx
    sete al
    movzx eax, al
    cmp dword eax, 0
    je if_2_elif_2_cond
    jmp if_2_elif_1_then


    if_2_elif_1_then:
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_9    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (elif2)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


    push eax
    pop eax
    jmp if_2_end


    if_2_elif_2_cond:
    ; ------------------------------ Condition Comparison ------------------------------
    ; ------------------------------Ambil offset variabel nilai------------------------------
    mov eax, [ebp - 48]    ; eax = Box*
    mov edx, [eax]    ; ambil value dari alamat Box di eax
    push edx          ; simpan left value sementara ke stack
    mov ecx, 99    ; masukkan nilai 99 ke register ecx
    mov ebx, ecx      ; ambil value right langsung
    pop edx           ; kembalikan left value ke EDX
    cmp edx, ebx
    sete al
    movzx eax, al
    cmp dword eax, 0
    je if_2_else
    jmp if_2_elif_2_then


    if_2_elif_2_then:
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_10    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (elif3)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


    push eax
    pop eax
    jmp if_2_end


    if_2_else:
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_11    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (else)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 99    ; masukkan nilai 99 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        ; ------------------------------Deklarasi variabel m------------------------------
        sub esp, 4
        mov dword [ebp - 52], eax    ; pindahkan alamat Box* ke dalam offset 52


        ; ------------------------------Ambil offset variabel m------------------------------
        mov eax, [ebp - 52]    ; eax = Box*
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (52)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


    push eax
    ; free alamat heap variabel m
    mov eax, [ebp - 52]
    push 8
    push eax
    call dealloc
    add esp, 8
    pop eax
    add esp, 4
    if_2_end:


        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 0    ; masukkan nilai 0 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        ; ------------------------------Deklarasi variabel i------------------------------
        sub esp, 4
        mov dword [ebp - 52], eax    ; pindahkan alamat Box* ke dalam offset 52


        ; ------------------------------ Looping For 0 ------------------------------
        for_0_check:
        ; END
        mov ecx, 2    ; masukkan nilai 2 ke register ecx
        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 52]    ; eax = Box*
        cmp [eax], ecx
        jge for_0_end
        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 52]    ; eax = Box*
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (52)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 52]    ; eax = Box*
        add dword [eax], 1
        jmp for_0_check
        for_0_end:
    push eax
    ; free alamat heap variabel i
    mov eax, [ebp - 52]
    push 8
    push eax
    call dealloc
    add esp, 8
    pop eax
    add esp, 4
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 0    ; masukkan nilai 0 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        ; ------------------------------Deklarasi variabel i------------------------------
        sub esp, 4
        mov dword [ebp - 52], eax    ; pindahkan alamat Box* ke dalam offset 52


        ; ------------------------------ Looping For 1 ------------------------------
        for_1_check:
        ; END
        mov ecx, 6    ; masukkan nilai 6 ke register ecx
        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 52]    ; eax = Box*
        cmp [eax], ecx
        jge for_1_end
        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 52]    ; eax = Box*
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (52)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 52]    ; eax = Box*
        add dword [eax], 2
        jmp for_1_check
        for_1_end:
    push eax
    ; free alamat heap variabel i
    mov eax, [ebp - 52]
    push 8
    push eax
    call dealloc
    add esp, 8
    pop eax
    add esp, 4
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 5    ; masukkan nilai 5 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        ; ------------------------------Deklarasi variabel i------------------------------
        sub esp, 4
        mov dword [ebp - 52], eax    ; pindahkan alamat Box* ke dalam offset 52


        ; ------------------------------ Looping For 2 ------------------------------
        for_2_check:
        ; END
        mov ecx, -1    ; masukkan nilai -1 ke register ecx
        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 52]    ; eax = Box*
        cmp [eax], ecx
        jle for_2_end
        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 52]    ; eax = Box*
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (52)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 52]    ; eax = Box*
        add dword [eax], -2
        jmp for_2_check
        for_2_end:
    push eax
    ; free alamat heap variabel i
    mov eax, [ebp - 52]
    push 8
    push eax
    call dealloc
    add esp, 8
    pop eax
    add esp, 4
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        ; ------------------------------Deklarasi variabel i------------------------------
        sub esp, 4
        mov dword [ebp - 52], eax    ; pindahkan alamat Box* ke dalam offset 52


        ; ------------------------------ Looping For 3 ------------------------------
        for_3_check:
        ; END
        mov ecx, 12    ; masukkan nilai 12 ke register ecx
        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 52]    ; eax = Box*
        cmp [eax], ecx
        jge for_3_end
            ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
            ; ------------------------------ Alokasi untuk 1 element ------------------------------
            push 8
            call alloc
            add esp, 4
            mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
            mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
            ; ------------------------------Deklarasi variabel j------------------------------
            sub esp, 4
            mov dword [ebp - 56], eax    ; pindahkan alamat Box* ke dalam offset 56


            ; ------------------------------ Looping For 4 ------------------------------
            for_4_check:
            ; END
            mov ecx, 12    ; masukkan nilai 12 ke register ecx
            ; ------------------------------Ambil offset variabel j------------------------------
            mov eax, [ebp - 56]    ; eax = Box*
            cmp [eax], ecx
            jge for_4_end
            ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
            ; ------------------------------ Alokasi untuk 1 element ------------------------------
            push 8
            call alloc
            add esp, 4
            mov dword [eax], 99    ; masukkan nilai 99 ke alamat dalam register eax
            mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
            ; ------------------------------Deklarasi variabel z------------------------------
            sub esp, 4
            mov dword [ebp - 60], eax    ; pindahkan alamat Box* ke dalam offset 60


            ; ------------------------------Ambil offset variabel j------------------------------
            mov eax, [ebp - 56]    ; eax = Box*
            ; ------------------------------ Print ------------------------------
            push dword [eax + 4]    ; push tipe data value offset (56)
            push dword [eax]    ; eax = alamat, push nilainya sebagai argument
            call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
            add esp, 8    ; pop argument dari stack
            call newline    ; untuk memanggil enter


            ; ------------------------------Ambil offset variabel j------------------------------
            mov eax, [ebp - 56]    ; eax = Box*
            add dword [eax], 1
            jmp for_4_check
            for_4_end:
        push eax
        ; free alamat heap variabel j
        mov eax, [ebp - 56]
        push 8
        push eax
        call dealloc
        add esp, 8
        ; free alamat heap variabel z
        mov eax, [ebp - 60]
        push 8
        push eax
        call dealloc
        add esp, 8
        pop eax
        add esp, 8
        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 52]    ; eax = Box*
        add dword [eax], 1
        jmp for_3_check
        for_3_end:
    push eax
    ; free alamat heap variabel i
    mov eax, [ebp - 52]
    push 8
    push eax
    call dealloc
    add esp, 8
    pop eax
    add esp, 4
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 4    ; masukkan nilai 4 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------Deklarasi variabel coba------------------------------
    sub esp, 4
    mov dword [ebp - 52], eax    ; pindahkan alamat Box* ke dalam offset 52


        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 0    ; masukkan nilai 0 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        ; ------------------------------Deklarasi variabel i------------------------------
        sub esp, 4
        mov dword [ebp - 56], eax    ; pindahkan alamat Box* ke dalam offset 56


        ; ------------------------------ Looping For 5 ------------------------------
        for_5_check:
        ; END
        ; ------------------------------Ambil offset variabel coba------------------------------
        mov eax, [ebp - 52]    ; eax = Box*
        mov ecx, [eax]
        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 56]    ; eax = Box*
        cmp [eax], ecx
        jge for_5_end
        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 56]    ; eax = Box*
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (56)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 56]    ; eax = Box*
        add dword [eax], 1
        jmp for_5_check
        for_5_end:
    push eax
    ; free alamat heap variabel i
    mov eax, [ebp - 56]
    push 8
    push eax
    call dealloc
    add esp, 8
    pop eax
    add esp, 4
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 0    ; masukkan nilai 0 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        ; ------------------------------Deklarasi variabel i------------------------------
        sub esp, 4
        mov dword [ebp - 56], eax    ; pindahkan alamat Box* ke dalam offset 56


        ; ------------------------------ Looping For 6 ------------------------------
        for_6_check:
        ; END
        mov ecx, 2    ; masukkan nilai 2 ke register ecx
        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 56]    ; eax = Box*
        cmp [eax], ecx
        jge for_6_end
        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 56]    ; eax = Box*
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (56)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


        ; ------------------------------ Kondisi if 3 ------------------------------
        ; ------------------------------ Condition Comparison ------------------------------
        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 56]    ; eax = Box*
        mov edx, [eax]    ; ambil value dari alamat Box di eax
        push edx          ; simpan left value sementara ke stack
        mov ecx, 0    ; masukkan nilai 0 ke register ecx
        mov ebx, ecx      ; ambil value right langsung
        pop edx           ; kembalikan left value ke EDX
        cmp edx, ebx
        sete al
        movzx eax, al
        ; jika false maka lanjut kondisi selanjutnya
        cmp eax, 0
        je if_3_end
        jmp if_3_then
        if_3_then:
            ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
            ; ------------------------------ Alokasi untuk 1 element ------------------------------
            push 8
            call alloc
            add esp, 4
            mov dword [eax], str_12    ; masukkan alamat label ke alamat dalam register eax
            mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
            ; ------------------------------ Print ------------------------------
            push dword [eax + 4]    ; push tipe data value offset (ini 0)
            push dword [eax]    ; eax = alamat, push nilainya sebagai argument
            call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
            add esp, 8    ; pop argument dari stack
            call newline    ; untuk memanggil enter


        push eax
        pop eax
        jmp if_3_end


        if_3_end:


        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 56]    ; eax = Box*
        add dword [eax], 1
        jmp for_6_check
        for_6_end:
    push eax
    ; free alamat heap variabel i
    mov eax, [ebp - 56]
    push 8
    push eax
    call dealloc
    add esp, 8
    pop eax
    add esp, 4
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 0    ; masukkan nilai 0 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        ; ------------------------------Deklarasi variabel i------------------------------
        sub esp, 4
        mov dword [ebp - 56], eax    ; pindahkan alamat Box* ke dalam offset 56


        ; ------------------------------ Looping For 7 ------------------------------
        for_7_check:
        ; END
        mov ecx, 2    ; masukkan nilai 2 ke register ecx
        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 56]    ; eax = Box*
        cmp [eax], ecx
        jge for_7_end
            ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
            ; ------------------------------ Alokasi untuk 1 element ------------------------------
            push 8
            call alloc
            add esp, 4
            mov dword [eax], 0    ; masukkan nilai 0 ke alamat dalam register eax
            mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
            ; ------------------------------Deklarasi variabel j------------------------------
            sub esp, 4
            mov dword [ebp - 60], eax    ; pindahkan alamat Box* ke dalam offset 60


            ; ------------------------------ Looping For 8 ------------------------------
            for_8_check:
            ; END
            mov ecx, 2    ; masukkan nilai 2 ke register ecx
            ; ------------------------------Ambil offset variabel j------------------------------
            mov eax, [ebp - 60]    ; eax = Box*
            cmp [eax], ecx
            jge for_8_end
            ; ------------------------------ Kondisi if 4 ------------------------------
            ; ------------------------------ Condition Comparison ------------------------------
            ; ------------------------------Ambil offset variabel j------------------------------
            mov eax, [ebp - 60]    ; eax = Box*
            mov edx, [eax]    ; ambil value dari alamat Box di eax
            push edx          ; simpan left value sementara ke stack
            mov ecx, 1    ; masukkan nilai 1 ke register ecx
            mov ebx, ecx      ; ambil value right langsung
            pop edx           ; kembalikan left value ke EDX
            cmp edx, ebx
            sete al
            movzx eax, al
            ; jika false maka lanjut kondisi selanjutnya
            cmp eax, 0
            je if_4_else
            jmp if_4_then
            if_4_then:
                ; ------------------------------Ambil offset variabel j------------------------------
                mov eax, [ebp - 60]    ; eax = Box*
                ; ------------------------------ Print ------------------------------
                push dword [eax + 4]    ; push tipe data value offset (60)
                push dword [eax]    ; eax = alamat, push nilainya sebagai argument
                call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
                add esp, 8    ; pop argument dari stack
                call newline    ; untuk memanggil enter


                ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
                ; ------------------------------ Alokasi untuk 1 element ------------------------------
                push 8
                call alloc
                add esp, 4
                mov dword [eax], str_13    ; masukkan alamat label ke alamat dalam register eax
                mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
                ; ------------------------------Deklarasi variabel inner------------------------------
                sub esp, 4
                mov dword [ebp - 64], eax    ; pindahkan alamat Box* ke dalam offset 64


                ; ------------------------------Ambil offset variabel inner------------------------------
                mov eax, [ebp - 64]    ; eax = Box*
                ; ------------------------------ Print ------------------------------
                push dword [eax + 4]    ; push tipe data value offset (64)
                push dword [eax]    ; eax = alamat, push nilainya sebagai argument
                call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
                add esp, 8    ; pop argument dari stack
                call newline    ; untuk memanggil enter


            push eax
            ; free alamat heap variabel inner
            mov eax, [ebp - 64]
            push 8
            push eax
            call dealloc
            add esp, 8
            pop eax
            add esp, 4
            jmp if_4_end


            if_4_else:
                ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
                ; ------------------------------ Alokasi untuk 1 element ------------------------------
                push 8
                call alloc
                add esp, 4
                mov dword [eax], str_14    ; masukkan alamat label ke alamat dalam register eax
                mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
                ; ------------------------------ Print ------------------------------
                push dword [eax + 4]    ; push tipe data value offset (hemm)
                push dword [eax]    ; eax = alamat, push nilainya sebagai argument
                call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
                add esp, 8    ; pop argument dari stack
                call newline    ; untuk memanggil enter


            push eax
            pop eax
            if_4_end:


            ; ------------------------------Ambil offset variabel j------------------------------
            mov eax, [ebp - 60]    ; eax = Box*
            add dword [eax], 1
            jmp for_8_check
            for_8_end:
        push eax
        ; free alamat heap variabel j
        mov eax, [ebp - 60]
        push 8
        push eax
        call dealloc
        add esp, 8
        pop eax
        add esp, 4
        ; ------------------------------Ambil offset variabel i------------------------------
        mov eax, [ebp - 56]    ; eax = Box*
        add dword [eax], 1
        jmp for_7_check
        for_7_end:
    push eax
    ; free alamat heap variabel i
    mov eax, [ebp - 56]
    push 8
    push eax
    call dealloc
    add esp, 8
    pop eax
    add esp, 4
    call displayHello
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], str_16    ; masukkan alamat label ke alamat dalam register eax
    mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
    push eax    ; push arg 0
    call callWithParam
    add esp, 4
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    push eax    ; push arg 0
    call callWithParam
    add esp, 4
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 30    ; masukkan nilai 30 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    push eax    ; push arg 1
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    push eax    ; push arg 0
    call addParams
    add esp, 8
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], str_17    ; masukkan alamat label ke alamat dalam register eax
    mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
    push eax    ; push arg 1
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    push eax    ; push arg 0
    call diffTyParam
    add esp, 8
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    push eax    ; push arg 1
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], str_18    ; masukkan alamat label ke alamat dalam register eax
    mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
    push eax    ; push arg 0
    call diffTyParam
    add esp, 8
    call ret5
    ; ------------------------------Deklarasi variabel five------------------------------
    sub esp, 4
    mov dword [ebp - 56], eax    ; pindahkan alamat Box* ke dalam offset 56


    ; ------------------------------Ambil offset variabel five------------------------------
    mov eax, [ebp - 56]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (56)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    call ret5
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (null)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 2    ; masukkan nilai 2 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    push eax    ; push arg 1
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 6    ; masukkan nilai 6 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    push eax    ; push arg 0
    call resBinOp
    add esp, 8
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (null)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    call retStr
    ; ------------------------------Deklarasi variabel getGello------------------------------
    sub esp, 4
    mov dword [ebp - 60], eax    ; pindahkan alamat Box* ke dalam offset 60


    ; ------------------------------Ambil offset variabel getGello------------------------------
    mov eax, [ebp - 60]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (60)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    call retStr
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (null)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    call retParam1
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (null)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    call retParam1
    ; ------------------------------Deklarasi variabel retParam1Res------------------------------
    sub esp, 4
    mov dword [ebp - 64], eax    ; pindahkan alamat Box* ke dalam offset 64


    ; ------------------------------Ambil offset variabel retParam1Res------------------------------
    mov eax, [ebp - 64]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (64)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    push eax    ; push arg 0
    call retParam2
    add esp, 4
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (null)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    push eax    ; push arg 0
    call retParam2
    add esp, 4
    ; ------------------------------Deklarasi variabel retParam2Res------------------------------
    sub esp, 4
    mov dword [ebp - 68], eax    ; pindahkan alamat Box* ke dalam offset 68


    ; ------------------------------Ambil offset variabel retParam2Res------------------------------
    mov eax, [ebp - 68]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (68)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], str_20    ; masukkan alamat label ke alamat dalam register eax
    mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
    push eax    ; push arg 0
    call retParam2
    add esp, 4
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (null)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 99    ; masukkan nilai 99 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------Deklarasi variabel arg------------------------------
    sub esp, 4
    mov dword [ebp - 72], eax    ; pindahkan alamat Box* ke dalam offset 72


    ; ------------------------------Ambil offset variabel arg------------------------------
    mov eax, [ebp - 72]    ; eax = Box*
    push eax    ; push arg 0
    call retParam3
    add esp, 4
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (null)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Ambil offset variabel arg------------------------------
    mov eax, [ebp - 72]    ; eax = Box*
    push eax    ; push arg 0
    call retParam3
    add esp, 4
    ; ------------------------------Deklarasi variabel retParam3Res------------------------------
    sub esp, 4
    mov dword [ebp - 76], eax    ; pindahkan alamat Box* ke dalam offset 76


    ; ------------------------------Ambil offset variabel retParam3Res------------------------------
    mov eax, [ebp - 76]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (76)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Binary Expression ------------------------------
    ; ------------------------------Ambil offset variabel arg------------------------------
    mov eax, [ebp - 72]    ; eax = Box*
    push eax    ; simpan Box* left operand ke stack
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 1    ; masukkan nilai 1 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    mov esi, eax    ; esi = Box* right operand
    pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
    push edi
    push esi
    ; result disimpan di register eax
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop esi
    pop edi
    mov edx, [edi]      ; ambil left value dari edi
    mov ebx, [esi]      ; ambil right value dari esi
    add edx, ebx
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    push eax    ; push arg 0
    call retParam4
    add esp, 4
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (null)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Binary Expression ------------------------------
    ; ------------------------------Ambil offset variabel arg------------------------------
    mov eax, [ebp - 72]    ; eax = Box*
    push eax    ; simpan Box* left operand ke stack
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 1    ; masukkan nilai 1 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    mov esi, eax    ; esi = Box* right operand
    pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
    push edi
    push esi
    ; result disimpan di register eax
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    pop esi
    pop edi
    mov edx, [edi]      ; ambil left value dari edi
    mov ebx, [esi]      ; ambil right value dari esi
    add edx, ebx
    ; simpan hasil ke Box
    mov [eax], edx    ; Masukkan value
    mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


    push eax    ; push arg 0
    call retParam4
    add esp, 4
    ; ------------------------------Deklarasi variabel retParam4Res------------------------------
    sub esp, 4
    mov dword [ebp - 80], eax    ; pindahkan alamat Box* ke dalam offset 80


    ; ------------------------------Ambil offset variabel retParam4Res------------------------------
    mov eax, [ebp - 80]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (80)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Ambil offset variabel arg------------------------------
    mov eax, [ebp - 72]    ; eax = Box*
    push eax    ; push arg 0
    call retParam5
    add esp, 4
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (null)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Ambil offset variabel arg------------------------------
    mov eax, [ebp - 72]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (72)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Ambil offset variabel arg------------------------------
    mov eax, [ebp - 72]    ; eax = Box*
    push eax    ; push arg 0
    call retParam5
    add esp, 4
    ; ------------------------------Deklarasi variabel retParam5Res------------------------------
    sub esp, 4
    mov dword [ebp - 84], eax    ; pindahkan alamat Box* ke dalam offset 84


    ; ------------------------------Ambil offset variabel retParam5Res------------------------------
    mov eax, [ebp - 84]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (84)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Ambil offset variabel arg------------------------------
    mov eax, [ebp - 72]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (72)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 8    ; masukkan nilai 8 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    push eax    ; push arg 0
    call retLocal
    add esp, 4
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (null)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 1    ; masukkan nilai 1 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    push eax    ; push arg 0
    call retLocal
    add esp, 4
    ; ------------------------------Deklarasi variabel retLocalVar------------------------------
    sub esp, 4
    mov dword [ebp - 88], eax    ; pindahkan alamat Box* ke dalam offset 88


    ; ------------------------------Ambil offset variabel retLocalVar------------------------------
    mov eax, [ebp - 88]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (88)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 9    ; masukkan nilai 9 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------Deklarasi variabel arg2------------------------------
    sub esp, 4
    mov dword [ebp - 92], eax    ; pindahkan alamat Box* ke dalam offset 92


    ; ------------------------------Ambil offset variabel arg2------------------------------
    mov eax, [ebp - 92]    ; eax = Box*
    push eax    ; push arg 0
    call retLocal2
    add esp, 4
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (null)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 1    ; masukkan nilai 1 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    push eax    ; push arg 0
    call retLocal2
    add esp, 4
    ; ------------------------------Deklarasi variabel retLocalVar2------------------------------
    sub esp, 4
    mov dword [ebp - 96], eax    ; pindahkan alamat Box* ke dalam offset 96


    ; ------------------------------Ambil offset variabel retLocalVar2------------------------------
    mov eax, [ebp - 96]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (96)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    call tesFunInput
    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------Deklarasi variabel tipeInt------------------------------
    sub esp, 4
    mov dword [ebp - 100], eax    ; pindahkan alamat Box* ke dalam offset 100


    ; TYPEOF
    ; ------------------------------Ambil offset variabel tipeInt------------------------------
    mov eax, [ebp - 100]    ; eax = Box*
    mov ecx, [eax + 4]
    push ecx
    call typeof
    add esp, 4
    mov ecx, eax
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], ecx    ; masukkan tipe data ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (typee)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], str_23    ; masukkan alamat label ke alamat dalam register eax
    mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
    ; ------------------------------ Assign ke variabel tipeInt ------------------------------
    mov dword [ebp - 100], eax    ; tipeInt = Box*
    ; TYPEOF
    ; ------------------------------Ambil offset variabel tipeInt------------------------------
    mov eax, [ebp - 100]    ; eax = Box*
    mov ecx, [eax + 4]
    push ecx
    call typeof
    add esp, 4
    mov ecx, eax
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], ecx    ; masukkan tipe data ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (typee)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 1    ; masukkan nilai true dengan angka berupa 1 ke alamat dalam register eax
    mov dword [eax + 4], 2    ; masukkan tipe data dari value, yaitu boolean
    ; ------------------------------ Assign ke variabel tipeInt ------------------------------
    mov dword [ebp - 100], eax    ; tipeInt = Box*
    ; TYPEOF
    ; ------------------------------Ambil offset variabel tipeInt------------------------------
    mov eax, [ebp - 100]    ; eax = Box*
    mov ecx, [eax + 4]
    push ecx
    call typeof
    add esp, 4
    mov ecx, eax
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], ecx    ; masukkan tipe data ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (typee)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], -79    ; masukkan nilai -79 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    push eax    ; push arg 0
    call math_abs
    add esp, 4
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (null)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Alokasi untuk 11 element ------------------------------
    push 88
    call alloc
    add esp, 4
    mov ecx, 9    ; masukkan nilai 9 ke register ecx
    mov [eax], ecx
    mov ecx, 10    ; masukkan nilai 10 ke register ecx
    mov [eax + 8], ecx
    mov ecx, 11    ; masukkan nilai 11 ke register ecx
    mov [eax + 16], ecx
    mov ecx, 12    ; masukkan nilai 12 ke register ecx
    mov [eax + 24], ecx
    mov ecx, 13    ; masukkan nilai 13 ke register ecx
    mov [eax + 32], ecx
    mov ecx, 14    ; masukkan nilai 14 ke register ecx
    mov [eax + 40], ecx
    mov ecx, 97    ; masukkan nilai 97 ke register ecx
    mov [eax + 48], ecx
    mov ecx, 43    ; masukkan nilai 43 ke register ecx
    mov [eax + 56], ecx
    mov ecx, 35    ; masukkan nilai 35 ke register ecx
    mov [eax + 64], ecx
    mov ecx, 42    ; masukkan nilai 42 ke register ecx
    mov [eax + 72], ecx
    mov ecx, 75    ; masukkan nilai 75 ke register ecx
    mov [eax + 80], ecx
    ; ------------------------------Deklarasi variabel arr------------------------------
    sub esp, 4
    mov dword [ebp - 104], eax    ; pindahkan alamat Box* ke dalam offset 104


    ; ------------------------------Ambil offset variabel arr------------------------------
    mov eax, [ebp - 104]    ; eax = Box*
    add eax, 40
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (5)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 2    ; masukkan nilai 2 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------Deklarasi variabel idx------------------------------
    sub esp, 4
    mov dword [ebp - 108], eax    ; pindahkan alamat Box* ke dalam offset 108


    ; ------------------------------Ambil offset variabel idx------------------------------
    mov eax, [ebp - 108]    ; eax = Box*
    mov ecx, [eax]
    imul ecx, 8
    push ecx
    ; ------------------------------Ambil offset variabel arr------------------------------
    mov eax, [ebp - 104]    ; eax = Box*
    pop ecx
    add eax, ecx
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (undefined)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Ambil offset variabel arr------------------------------
    mov eax, [ebp - 104]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (0)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 777    ; masukkan nilai 777 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------ Assign ke variabel undefined ------------------------------
    mov dword [ebp - 104], eax    ; undefined = Box*
    ; ------------------------------Ambil offset variabel arr------------------------------
    mov eax, [ebp - 104]    ; eax = Box*
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (0)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter


    ; ------------------------------ Alokasi untuk 2 element ------------------------------
    push 16
    call alloc
    add esp, 4
    mov ecx, 10    ; masukkan nilai 10 ke register ecx
    mov [eax], ecx
    mov ecx, 11    ; masukkan nilai 11 ke register ecx
    mov [eax + 8], ecx
    ; ------------------------------Deklarasi variabel arr2------------------------------
    sub esp, 4
    mov dword [ebp - 112], eax    ; pindahkan alamat Box* ke dalam offset 112


    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
    ; ------------------------------ Alokasi untuk 1 element ------------------------------
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 5    ; masukkan nilai 5 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------ Assign ke variabel undefined ------------------------------
    mov dword [ebp - 112], eax    ; undefined = Box*
    ; ------------------------------Ambil offset variabel arr2------------------------------
    mov eax, [ebp - 112]    ; eax = Box*
    add eax, 16
    ; ------------------------------ Print ------------------------------
    push dword [eax + 4]    ; push tipe data value offset (2)
    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter



    mov esp, ebp
    pop ebp

    mov eax, 1
    xor ebx, ebx
    int 0x80

; ------------------------------ Deklarasi fungsi displayHello ------------------------------
displayHello:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_15    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (mellow)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


            ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
            ; ------------------------------ Alokasi untuk 1 element ------------------------------
            push 8
            call alloc
            add esp, 4
            mov dword [eax], 0    ; masukkan nilai 0 ke alamat dalam register eax
            mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
            ; ------------------------------Deklarasi variabel i------------------------------
            sub esp, 4
            mov dword [ebp - 56], eax    ; pindahkan alamat Box* ke dalam offset 56


            ; ------------------------------ Looping For 9 ------------------------------
            for_9_check:
            ; END
            mov ecx, 2    ; masukkan nilai 2 ke register ecx
            ; ------------------------------Ambil offset variabel i------------------------------
            mov eax, [ebp - 56]    ; eax = Box*
            cmp [eax], ecx
            jge for_9_end
                ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
                ; ------------------------------ Alokasi untuk 1 element ------------------------------
                push 8
                call alloc
                add esp, 4
                mov dword [eax], 3    ; masukkan nilai 3 ke alamat dalam register eax
                mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
                ; ------------------------------Deklarasi variabel j------------------------------
                sub esp, 4
                mov dword [ebp - 60], eax    ; pindahkan alamat Box* ke dalam offset 60


                ; ------------------------------ Looping For 10 ------------------------------
                for_10_check:
                ; END
                mov ecx, 5    ; masukkan nilai 5 ke register ecx
                ; ------------------------------Ambil offset variabel j------------------------------
                mov eax, [ebp - 60]    ; eax = Box*
                cmp [eax], ecx
                jge for_10_end
                ; ------------------------------ Kondisi if 5 ------------------------------
                ; ------------------------------ Condition Comparison ------------------------------
                ; ------------------------------Ambil offset variabel i------------------------------
                mov eax, [ebp - 56]    ; eax = Box*
                mov edx, [eax]    ; ambil value dari alamat Box di eax
                push edx          ; simpan left value sementara ke stack
                mov ecx, 1    ; masukkan nilai 1 ke register ecx
                mov ebx, ecx      ; ambil value right langsung
                pop edx           ; kembalikan left value ke EDX
                cmp edx, ebx
                sete al
                movzx eax, al
                ; jika false maka lanjut kondisi selanjutnya
                cmp eax, 0
                je if_5_end
                jmp if_5_then
                if_5_then:
                    ; ------------------------------Ambil offset variabel j------------------------------
                    mov eax, [ebp - 60]    ; eax = Box*
                    ; ------------------------------ Print ------------------------------
                    push dword [eax + 4]    ; push tipe data value offset (60)
                    push dword [eax]    ; eax = alamat, push nilainya sebagai argument
                    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
                    add esp, 8    ; pop argument dari stack
                    call newline    ; untuk memanggil enter


                push eax
                pop eax
                jmp if_5_end


                if_5_end:


                ; ------------------------------Ambil offset variabel j------------------------------
                mov eax, [ebp - 60]    ; eax = Box*
                add dword [eax], 1
                jmp for_10_check
                for_10_end:
            push eax
            ; free alamat heap variabel j
            mov eax, [ebp - 60]
            push 8
            push eax
            call dealloc
            add esp, 8
            pop eax
            add esp, 4
            ; ------------------------------Ambil offset variabel i------------------------------
            mov eax, [ebp - 56]    ; eax = Box*
            add dword [eax], 1
            jmp for_9_check
            for_9_end:
        push eax
        ; free alamat heap variabel i
        mov eax, [ebp - 56]
        push 8
        push eax
        call dealloc
        add esp, 8
        pop eax
        add esp, 4
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 99    ; masukkan nilai 99 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        ; ------------------------------Deklarasi variabel m------------------------------
        sub esp, 4
        mov dword [ebp - 56], eax    ; pindahkan alamat Box* ke dalam offset 56


        ; ------------------------------Ambil offset variabel m------------------------------
        mov eax, [ebp - 56]    ; eax = Box*
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (56)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter




    push eax
    ; free alamat heap variabel m
    mov eax, [ebp - 56]
    push 8
    push eax
    call dealloc
    add esp, 8
    pop eax
    add esp, 4




displayHello_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
; ------------------------------ Deklarasi fungsi callWithParam ------------------------------
callWithParam:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------Ambil offset variabel param1------------------------------
        mov eax, [ebp + 8]    ; eax = Box*
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (8)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter




    push eax
    ; free alamat heap variabel param1
    pop eax




callWithParam_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
; ------------------------------ Deklarasi fungsi addParams ------------------------------
addParams:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------ Binary Expression ------------------------------
        ; ------------------------------Ambil offset variabel a------------------------------
        mov eax, [ebp + 8]    ; eax = Box*
        push eax    ; simpan Box* left operand ke stack
        ; ------------------------------Ambil offset variabel b------------------------------
        mov eax, [ebp + 12]    ; eax = Box*
        mov esi, eax    ; esi = Box* right operand
        pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
        push edi
        push esi
        ; result disimpan di register eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop esi
        pop edi
        mov edx, [edi]      ; ambil left value dari edi
        mov ebx, [esi]      ; ambil right value dari esi
        add edx, ebx
        ; simpan hasil ke Box
        mov [eax], edx    ; Masukkan value
        mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (0)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter




    push eax
    ; free alamat heap variabel a
    ; free alamat heap variabel b
    pop eax




addParams_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
; ------------------------------ Deklarasi fungsi diffTyParam ------------------------------
diffTyParam:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------Ambil offset variabel first------------------------------
        mov eax, [ebp + 8]    ; eax = Box*
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (8)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


        ; ------------------------------Ambil offset variabel second------------------------------
        mov eax, [ebp + 12]    ; eax = Box*
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (12)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter




    push eax
    ; free alamat heap variabel first
    ; free alamat heap variabel second
    pop eax




diffTyParam_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
; ------------------------------ Deklarasi fungsi ret5 ------------------------------
ret5:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 5    ; masukkan nilai 5 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        push eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop edx
        mov ecx, [edx]      ; Ambil value dari Box Lama
        mov [eax], ecx      ; Masukkan ke Box Baru
        mov ecx, [edx+4]    ; Ambil type dari Box Lama
        mov [eax+4], ecx    ; Masukkan ke Box Baru
        jmp ret5_exit


    push eax
    pop eax




ret5_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
; ------------------------------ Deklarasi fungsi resBinOp ------------------------------
resBinOp:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------ Binary Expression ------------------------------
        ; ------------------------------ Binary Expression ------------------------------
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 5    ; masukkan nilai 5 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        push eax    ; simpan Box* left operand ke stack
        ; ------------------------------ Binary Expression ------------------------------
        ; ------------------------------ Binary Expression ------------------------------
        ; ------------------------------Ambil offset variabel a------------------------------
        mov eax, [ebp + 8]    ; eax = Box*
        push eax    ; simpan Box* left operand ke stack
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 7    ; masukkan nilai 7 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        mov esi, eax    ; esi = Box* right operand
        pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
        push edi
        push esi
        ; result disimpan di register eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop esi
        pop edi
        mov edx, [edi]      ; ambil left value dari edi
        mov ebx, [esi]      ; ambil right value dari esi
        imul edx, ebx
        ; simpan hasil ke Box
        mov [eax], edx    ; Masukkan value
        mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


        push eax    ; simpan Box* left operand ke stack
        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 2    ; masukkan nilai 2 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        mov esi, eax    ; esi = Box* right operand
        pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
        push edi
        push esi
        ; result disimpan di register eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop esi
        pop edi
        mov edx, [edi]      ; ambil left value dari edi
        mov ebx, [esi]      ; ambil right value dari esi
        push eax    ; simpan alamat result
        mov eax, edx    ; eax = dibagi
        cdq
        idiv ebx    ; eax = eax / ebx
        mov edx, eax    ; pindahkan hasil bagi ke edx
        pop eax    ; kembalikan alamat result
        ; simpan hasil ke Box
        mov [eax], edx    ; Masukkan value
        mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


        mov esi, eax    ; esi = Box* right operand
        pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
        push edi
        push esi
        ; result disimpan di register eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop esi
        pop edi
        mov edx, [edi]      ; ambil left value dari edi
        mov ebx, [esi]      ; ambil right value dari esi
        add edx, ebx
        ; simpan hasil ke Box
        mov [eax], edx    ; Masukkan value
        mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


        push eax    ; simpan Box* left operand ke stack
        ; ------------------------------Ambil offset variabel b------------------------------
        mov eax, [ebp + 12]    ; eax = Box*
        mov esi, eax    ; esi = Box* right operand
        pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
        push edi
        push esi
        ; result disimpan di register eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop esi
        pop edi
        mov edx, [edi]      ; ambil left value dari edi
        mov ebx, [esi]      ; ambil right value dari esi
        sub edx, ebx
        ; simpan hasil ke Box
        mov [eax], edx    ; Masukkan value
        mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


        push eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop edx
        mov ecx, [edx]      ; Ambil value dari Box Lama
        mov [eax], ecx      ; Masukkan ke Box Baru
        mov ecx, [edx+4]    ; Ambil type dari Box Lama
        mov [eax+4], ecx    ; Masukkan ke Box Baru
        jmp resBinOp_exit


    push eax
    ; free alamat heap variabel a
    ; free alamat heap variabel b
    pop eax




resBinOp_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
; ------------------------------ Deklarasi fungsi retStr ------------------------------
retStr:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_19    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
        push eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop edx
        mov ecx, [edx]      ; Ambil value dari Box Lama
        mov [eax], ecx      ; Masukkan ke Box Baru
        mov ecx, [edx+4]    ; Ambil type dari Box Lama
        mov [eax+4], ecx    ; Masukkan ke Box Baru
        jmp retStr_exit


    push eax
    pop eax




retStr_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
; ------------------------------ Deklarasi fungsi retParam1 ------------------------------
retParam1:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 9    ; masukkan nilai 9 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        ; ------------------------------Deklarasi variabel a------------------------------
        sub esp, 4
        mov dword [ebp - 64], eax    ; pindahkan alamat Box* ke dalam offset 64


        ; ------------------------------Ambil offset variabel a------------------------------
        mov eax, [ebp - 64]    ; eax = Box*
        push eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop edx
        mov ecx, [edx]      ; Ambil value dari Box Lama
        mov [eax], ecx      ; Masukkan ke Box Baru
        mov ecx, [edx+4]    ; Ambil type dari Box Lama
        mov [eax+4], ecx    ; Masukkan ke Box Baru
        jmp retParam1_exit


    push eax
    ; free alamat heap variabel a
    mov eax, [ebp - 64]
    push 8
    push eax
    call dealloc
    add esp, 8
    pop eax
    add esp, 4




retParam1_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
; ------------------------------ Deklarasi fungsi retParam2 ------------------------------
retParam2:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------Ambil offset variabel a------------------------------
        mov eax, [ebp + 8]    ; eax = Box*
        push eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop edx
        mov ecx, [edx]      ; Ambil value dari Box Lama
        mov [eax], ecx      ; Masukkan ke Box Baru
        mov ecx, [edx+4]    ; Ambil type dari Box Lama
        mov [eax+4], ecx    ; Masukkan ke Box Baru
        jmp retParam2_exit


    push eax
    ; free alamat heap variabel a
    pop eax




retParam2_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
; ------------------------------ Deklarasi fungsi retParam3 ------------------------------
retParam3:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------Ambil offset variabel a------------------------------
        mov eax, [ebp + 8]    ; eax = Box*
        push eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop edx
        mov ecx, [edx]      ; Ambil value dari Box Lama
        mov [eax], ecx      ; Masukkan ke Box Baru
        mov ecx, [edx+4]    ; Ambil type dari Box Lama
        mov [eax+4], ecx    ; Masukkan ke Box Baru
        jmp retParam3_exit


    push eax
    ; free alamat heap variabel a
    pop eax




retParam3_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
; ------------------------------ Deklarasi fungsi retParam4 ------------------------------
retParam4:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------Ambil offset variabel a------------------------------
        mov eax, [ebp + 8]    ; eax = Box*
        push eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop edx
        mov ecx, [edx]      ; Ambil value dari Box Lama
        mov [eax], ecx      ; Masukkan ke Box Baru
        mov ecx, [edx+4]    ; Ambil type dari Box Lama
        mov [eax+4], ecx    ; Masukkan ke Box Baru
        jmp retParam4_exit


    push eax
    ; free alamat heap variabel a
    pop eax




retParam4_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
; ------------------------------ Deklarasi fungsi retParam5 ------------------------------
retParam5:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------ Binary Expression ------------------------------
        ; ------------------------------Ambil offset variabel a------------------------------
        mov eax, [ebp + 8]    ; eax = Box*
        push eax    ; simpan Box* left operand ke stack
        ; ------------------------------ Compare Literals ------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        push eax
        mov ecx, 1    ; masukkan nilai 1 ke register ecx
        mov edx, ecx
        mov ecx, 9    ; masukkan nilai 9 ke register ecx
        mov ebx, ecx
        pop eax
        imul edx, ebx
        ; simpan hasil ke Box
        mov [eax], edx    ; Masukkan value
        mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


        mov esi, eax    ; esi = Box* right operand
        pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
        push edi
        push esi
        ; result disimpan di register eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop esi
        pop edi
        mov edx, [edi]      ; ambil left value dari edi
        mov ebx, [esi]      ; ambil right value dari esi
        add edx, ebx
        ; simpan hasil ke Box
        mov [eax], edx    ; Masukkan value
        mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


        push eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop edx
        mov ecx, [edx]      ; Ambil value dari Box Lama
        mov [eax], ecx      ; Masukkan ke Box Baru
        mov ecx, [edx+4]    ; Ambil type dari Box Lama
        mov [eax+4], ecx    ; Masukkan ke Box Baru
        jmp retParam5_exit


    push eax
    ; free alamat heap variabel a
    pop eax




retParam5_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
; ------------------------------ Deklarasi fungsi retLocal ------------------------------
retLocal:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 9    ; masukkan nilai 9 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        ; ------------------------------Deklarasi variabel b------------------------------
        sub esp, 4
        mov dword [ebp - 88], eax    ; pindahkan alamat Box* ke dalam offset 88


        ; ------------------------------ Binary Expression ------------------------------
        ; ------------------------------Ambil offset variabel a------------------------------
        mov eax, [ebp + 8]    ; eax = Box*
        push eax    ; simpan Box* left operand ke stack
        ; ------------------------------Ambil offset variabel b------------------------------
        mov eax, [ebp - 88]    ; eax = Box*
        mov esi, eax    ; esi = Box* right operand
        pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
        push edi
        push esi
        ; result disimpan di register eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop esi
        pop edi
        mov edx, [edi]      ; ambil left value dari edi
        mov ebx, [esi]      ; ambil right value dari esi
        add edx, ebx
        ; simpan hasil ke Box
        mov [eax], edx    ; Masukkan value
        mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


        push eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop edx
        mov ecx, [edx]      ; Ambil value dari Box Lama
        mov [eax], ecx      ; Masukkan ke Box Baru
        mov ecx, [edx+4]    ; Ambil type dari Box Lama
        mov [eax+4], ecx    ; Masukkan ke Box Baru
        jmp retLocal_exit


    push eax
    ; free alamat heap variabel a
    ; free alamat heap variabel b
    mov eax, [ebp - 88]
    push 8
    push eax
    call dealloc
    add esp, 8
    pop eax
    add esp, 4




retLocal_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
; ------------------------------ Deklarasi fungsi retLocal2 ------------------------------
retLocal2:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 9    ; masukkan nilai 9 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
        ; ------------------------------Deklarasi variabel b------------------------------
        sub esp, 4
        mov dword [ebp - 96], eax    ; pindahkan alamat Box* ke dalam offset 96


        ; ------------------------------ Binary Expression ------------------------------
        ; ------------------------------Ambil offset variabel a------------------------------
        mov eax, [ebp + 8]    ; eax = Box*
        push eax    ; simpan Box* left operand ke stack
        ; ------------------------------Ambil offset variabel b------------------------------
        mov eax, [ebp - 96]    ; eax = Box*
        mov esi, eax    ; esi = Box* right operand
        pop edi    ; edi = Box* left operand (Gunakan EDI karena ECX tidak aman kena alloc)
        push edi
        push esi
        ; result disimpan di register eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop esi
        pop edi
        mov edx, [edi]      ; ambil left value dari edi
        mov ebx, [esi]      ; ambil right value dari esi
        add edx, ebx
        ; simpan hasil ke Box
        mov [eax], edx    ; Masukkan value
        mov dword [eax+4], 0 ; Tipe data (anggap int/bool)


        push eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop edx
        mov ecx, [edx]      ; Ambil value dari Box Lama
        mov [eax], ecx      ; Masukkan ke Box Baru
        mov ecx, [edx+4]    ; Ambil type dari Box Lama
        mov [eax+4], ecx    ; Masukkan ke Box Baru
        jmp retLocal2_exit


    push eax
    ; free alamat heap variabel a
    ; free alamat heap variabel b
    mov eax, [ebp - 96]
    push 8
    push eax
    call dealloc
    add esp, 8
    pop eax
    add esp, 4




retLocal2_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
; ------------------------------ Deklarasi fungsi tesFunInput ------------------------------
tesFunInput:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_21    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (Masukkan string: )
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


        push 128
        call alloc
        add esp, 4
        push eax
        push eax
        push 128
        call scan_str
        add esp, 8
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop edx
        mov dword [eax], edx
        mov dword [eax + 4], 1
        ; ------------------------------Deklarasi variabel inputStr------------------------------
        sub esp, 4
        mov dword [ebp - 100], eax    ; pindahkan alamat Box* ke dalam offset 100


        ; ------------------------------Ambil offset variabel inputStr------------------------------
        mov eax, [ebp - 100]    ; eax = Box*
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (100)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


        ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_22    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (Masukkan angka: )
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter


        push eax
        call scan_int
        add esp, 4
        push eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop edx
        mov dword [eax], edx
        mov dword [eax + 4], 0
        ; ------------------------------Deklarasi variabel inputInt------------------------------
        sub esp, 4
        mov dword [ebp - 104], eax    ; pindahkan alamat Box* ke dalam offset 104


        ; ------------------------------Ambil offset variabel inputInt------------------------------
        mov eax, [ebp - 104]    ; eax = Box*
        ; ------------------------------ Print ------------------------------
        push dword [eax + 4]    ; push tipe data value offset (104)
        push dword [eax]    ; eax = alamat, push nilainya sebagai argument
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter




    push eax
    ; free alamat heap variabel inputStr
    mov eax, [ebp - 100]
    push 8
    push eax
    call dealloc
    add esp, 8
    ; free alamat heap variabel inputInt
    mov eax, [ebp - 104]
    push 8
    push eax
    call dealloc
    add esp, 8
    pop eax
    add esp, 8




tesFunInput_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
; ------------------------------ Deklarasi fungsi math_abs ------------------------------
math_abs:
        push ebp    ; buat stack frame baru
        mov ebp, esp


        ; ------------------------------ Kondisi if 6 ------------------------------
        ; ------------------------------ Condition Comparison ------------------------------
        ; ------------------------------Ambil offset variabel n------------------------------
        mov eax, [ebp + 8]    ; eax = Box*
        mov edx, [eax]    ; ambil value dari alamat Box di eax
        push edx          ; simpan left value sementara ke stack
        mov ecx, 0    ; masukkan nilai 0 ke register ecx
        mov ebx, ecx      ; ambil value right langsung
        pop edx           ; kembalikan left value ke EDX
        cmp edx, ebx
        setl bl
        movzx edx, bl
        mov eax, edx
        ; jika false maka lanjut kondisi selanjutnya
        cmp eax, 0
        je if_6_end
        jmp if_6_then
        if_6_then:
            ; ------------------------------Ambil offset variabel n------------------------------
            mov eax, [ebp + 8]    ; eax = Box*
            push eax    ; simpan Box* operand unary
            ; result disimpan di register eax
            ; Alokasikan 8 byte untuk Box (value + type)
            ; ------------------------------ Alokasi untuk 1 element ------------------------------
            push 8
            call alloc
            add esp, 4
            pop ecx     ; ecx = Box* operand
            mov ebx, [ecx]  ; ebx = operand value
            neg ebx        ; ebx = -ebx
            mov [eax], ebx ; simpan hasil unary ke Box result
            mov edx, [ecx + 4]  ; ambil type operand
            mov [eax + 4], edx  ; type result = type operand
            push eax
            ; ------------------------------ Alokasi untuk 1 element ------------------------------
            push 8
            call alloc
            add esp, 4
            pop edx
            mov ecx, [edx]      ; Ambil value dari Box Lama
            mov [eax], ecx      ; Masukkan ke Box Baru
            mov ecx, [edx+4]    ; Ambil type dari Box Lama
            mov [eax+4], ecx    ; Masukkan ke Box Baru
            jmp math_abs_exit
        push eax
        pop eax
        jmp if_6_end


        if_6_end:


        ; ------------------------------Ambil offset variabel n------------------------------
        mov eax, [ebp + 8]    ; eax = Box*
        push eax
        ; ------------------------------ Alokasi untuk 1 element ------------------------------
        push 8
        call alloc
        add esp, 4
        pop edx
        mov ecx, [edx]      ; Ambil value dari Box Lama
        mov [eax], ecx      ; Masukkan ke Box Baru
        mov ecx, [edx+4]    ; Ambil type dari Box Lama
        mov [eax+4], ecx    ; Masukkan ke Box Baru
        jmp math_abs_exit


    push eax
    ; free alamat heap variabel n
    pop eax




math_abs_exit:
    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret