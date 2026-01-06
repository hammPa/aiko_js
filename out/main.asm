%include "/home/hamm/Documents/aiko_js_fullstack/aiko_js/helper/stdio.asm"
section .data
	str_0 db "hello world", 0    ; buat variabel string global bernama str_0 dengan tipe byte
	str_1 db "coba string", 0    ; buat variabel string global bernama str_1 dengan tipe byte
	str_2 db "hemm", 0    ; buat variabel string global bernama str_2 dengan tipe byte
	str_3 db "wello", 0    ; buat variabel string global bernama str_3 dengan tipe byte
	str_4 db "ganti assign1", 0    ; buat variabel string global bernama str_4 dengan tipe byte
	str_5 db "muehehehehe", 0    ; buat variabel string global bernama str_5 dengan tipe byte
	str_6 db "elif", 0    ; buat variabel string global bernama str_6 dengan tipe byte
	str_7 db "elif2", 0    ; buat variabel string global bernama str_7 dengan tipe byte
	str_8 db "elif3", 0    ; buat variabel string global bernama str_8 dengan tipe byte
	str_9 db "else", 0    ; buat variabel string global bernama str_9 dengan tipe byte
	str_10 db "ini 0", 0    ; buat variabel string global bernama str_10 dengan tipe byte
	str_11 db "hello inner", 0    ; buat variabel string global bernama str_11 dengan tipe byte
	str_12 db "hemm", 0    ; buat variabel string global bernama str_12 dengan tipe byte

section .bss

section .text
	global _start

_start:
	push ebp
	mov ebp, esp

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    ; print
    push dword [eax + 4]    ; push tipe data value (number)
    push dword [eax]    ; push nilai 10 dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 1    ; masukkan nilai true dengan angka berupa 1 ke alamat dalam register eax
    mov dword [eax + 4], 2    ; masukkan tipe data dari value, yaitu boolean


    ; print
    push dword [eax + 4]    ; push tipe data value (boolean)
    push dword [eax]    ; push nilai true dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], str_0    ; masukkan alamat label ke alamat dalam register eax
    mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string


    ; print
    push dword [eax + 4]    ; push tipe data value (string)
    push dword [eax]    ; push nilai hello world dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    push eax    ; simpan Box* left operand ke stack
    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 5    ; masukkan nilai 5 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    add edx, ebx    ; 10 + 5
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 15
    mov dword [eax+4], 0


    ; print
    push dword [eax + 4]    ; push tipe data value (number)
    push dword [eax]    ; push nilai 15 dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    push eax    ; simpan Box* left operand ke stack
    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 2    ; masukkan nilai 2 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    sub edx, ebx    ; 10 - 2
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 8
    mov dword [eax+4], 0


    ; print
    push dword [eax + 4]    ; push tipe data value (number)
    push dword [eax]    ; push nilai 8 dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    push eax    ; simpan Box* left operand ke stack
    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 4    ; masukkan nilai 4 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    imul edx, ebx    ; 10 * 4
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 40
    mov dword [eax+4], 0


    ; print
    push dword [eax + 4]    ; push tipe data value (number)
    push dword [eax]    ; push nilai 40 dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    push eax    ; simpan Box* left operand ke stack
    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 2    ; masukkan nilai 2 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    push eax    ; simpan alamat result
    mov eax, edx    ; eax = dibagi
    cdq
    idiv ebx    ; eax = eax / ebx, sisa bagi di edx
    mov edx, eax    ; pindahkan hasil bagi ke edx
    pop eax    ; kembalikan alamat result
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 5
    mov dword [eax+4], 0


    ; print
    push dword [eax + 4]    ; push tipe data value (number)
    push dword [eax]    ; push nilai 5 dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    push eax    ; simpan Box* left operand ke stack
    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 4    ; masukkan nilai 4 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    imul edx, ebx    ; 10 * 4
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 40
    mov dword [eax+4], 0


    push eax    ; simpan Box* left operand ke stack
    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 2    ; masukkan nilai 2 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    push eax    ; simpan alamat result
    mov eax, edx    ; eax = dibagi
    cdq
    idiv ebx    ; eax = eax / ebx, sisa bagi di edx
    mov edx, eax    ; pindahkan hasil bagi ke edx
    pop eax    ; kembalikan alamat result
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 20
    mov dword [eax+4], 0


    push eax    ; simpan Box* left operand ke stack
    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 1    ; masukkan nilai 1 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    add edx, ebx    ; 20 + 1
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 21
    mov dword [eax+4], 0


    ; print
    push dword [eax + 4]    ; push tipe data value (number)
    push dword [eax]    ; push nilai 21 dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    push eax    ; simpan Box* left operand ke stack
    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 3    ; masukkan nilai 3 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    push eax    ; simpan alamat result
    mov eax, edx    ; eax = dibagi
    cdq
    idiv ebx    ; eax = eax / ebx, sisa bagi di edx
    pop eax    ; kembalikan alamat result
    mov [eax], edx    ; pindahkan hasil sisa bagi ke eax
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 1
    mov dword [eax+4], 0


    ; print
    push dword [eax + 4]    ; push tipe data value (number)
    push dword [eax]    ; push nilai 1 dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 0    ; masukkan nilai false dengan angka berupa 0 ke alamat dalam register eax
    mov dword [eax + 4], 2    ; masukkan tipe data dari value, yaitu boolean


    push eax    ; simpan Box* operand unary
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
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
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
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
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
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
    ; print
    push dword [eax + 4]    ; push tipe data value (boolean)
    push dword [eax]    ; push nilai false dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], -8    ; masukkan nilai -8 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    push eax    ; simpan Box* operand unary
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
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
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
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
    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 3    ; masukkan nilai 3 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    imul edx, ebx    ; false * 3
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 0
    mov dword [eax+4], 0


    ; print
    push dword [eax + 4]    ; push tipe data value (number)
    push dword [eax]    ; push nilai 0 dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 888    ; masukkan nilai 888 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    ; deklarasi variabel x
    sub esp, 4
    mov dword [ebp - 4], eax    ; pindahkan alamat Box* ke dalam offset 4


    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 9987    ; masukkan nilai 9987 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    ; deklarasi variabel y
    sub esp, 4
    mov dword [ebp - 8], eax    ; pindahkan alamat Box* ke dalam offset 8


    ; ambil offset variabel x
    mov eax, [ebp - 4]    ; eax = Box*

    ; print
    push dword [eax + 4]    ; push tipe data value (undefined)
    push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; ambil offset variabel y
    mov eax, [ebp - 8]    ; eax = Box*

    ; print
    push dword [eax + 4]    ; push tipe data value (undefined)
    push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], str_1    ; masukkan alamat label ke alamat dalam register eax
    mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string


    ; deklarasi variabel z
    sub esp, 4
    mov dword [ebp - 12], eax    ; pindahkan alamat Box* ke dalam offset 12


    ; ambil offset variabel z
    mov eax, [ebp - 12]    ; eax = Box*

    ; print
    push dword [eax + 4]    ; push tipe data value (undefined)
    push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 0    ; masukkan nilai false dengan angka berupa 0 ke alamat dalam register eax
    mov dword [eax + 4], 2    ; masukkan tipe data dari value, yaitu boolean


    ; deklarasi variabel contohBool
    sub esp, 4
    mov dword [ebp - 16], eax    ; pindahkan alamat Box* ke dalam offset 16


    ; ambil offset variabel contohBool
    mov eax, [ebp - 16]    ; eax = Box*

    ; print
    push dword [eax + 4]    ; push tipe data value (undefined)
    push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], str_2    ; masukkan alamat label ke alamat dalam register eax
    mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string


    ; deklarasi variabel assign1
    sub esp, 4
    mov dword [ebp - 20], eax    ; pindahkan alamat Box* ke dalam offset 20


    ; ambil offset variabel assign1
    mov eax, [ebp - 20]    ; eax = Box*

    ; print
    push dword [eax + 4]    ; push tipe data value (undefined)
    push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 0    ; masukkan nilai 0 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    ; deklarasi variabel assign2
    sub esp, 4
    mov dword [ebp - 24], eax    ; pindahkan alamat Box* ke dalam offset 24


    ; ambil offset variabel assign2
    mov eax, [ebp - 24]    ; eax = Box*

    ; print
    push dword [eax + 4]    ; push tipe data value (undefined)
    push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 1    ; masukkan nilai true dengan angka berupa 1 ke alamat dalam register eax
    mov dword [eax + 4], 2    ; masukkan tipe data dari value, yaitu boolean


    mov dword [ebp - 24], eax    ; assign2 = Box*
    ; ambil offset variabel assign2
    mov eax, [ebp - 24]    ; eax = Box*

    ; print
    push dword [eax + 4]    ; push tipe data value (undefined)
    push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    mov dword [ebp - 24], eax    ; assign2 = Box*
    ; ambil offset variabel assign2
    mov eax, [ebp - 24]    ; eax = Box*

    ; print
    push dword [eax + 4]    ; push tipe data value (undefined)
    push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], str_3    ; masukkan alamat label ke alamat dalam register eax
    mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string


    mov dword [ebp - 24], eax    ; assign2 = Box*
    ; ambil offset variabel assign2
    mov eax, [ebp - 24]    ; eax = Box*

    ; print
    push dword [eax + 4]    ; push tipe data value (undefined)
    push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; ambil offset variabel assign1
    mov eax, [ebp - 20]    ; eax = Box*

    mov dword [ebp - 24], eax    ; assign2 = Box*
    ; ambil offset variabel assign2
    mov eax, [ebp - 24]    ; eax = Box*

    ; print
    push dword [eax + 4]    ; push tipe data value (undefined)
    push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; ambil offset variabel assign1
    mov eax, [ebp - 20]    ; eax = Box*

    ; deklarasi variabel assignDecl
    sub esp, 4
    mov dword [ebp - 28], eax    ; pindahkan alamat Box* ke dalam offset 28


    ; ambil offset variabel assignDecl
    mov eax, [ebp - 28]    ; eax = Box*

    ; print
    push dword [eax + 4]    ; push tipe data value (undefined)
    push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], str_4    ; masukkan alamat label ke alamat dalam register eax
    mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string


    mov dword [ebp - 20], eax    ; assign1 = Box*
    ; ambil offset variabel assign1
    mov eax, [ebp - 20]    ; eax = Box*

    ; print
    push dword [eax + 4]    ; push tipe data value (undefined)
    push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; ambil offset variabel assignDecl
    mov eax, [ebp - 28]    ; eax = Box*

    ; print
    push dword [eax + 4]    ; push tipe data value (undefined)
    push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 90    ; masukkan nilai 90 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    ; deklarasi variabel first
    sub esp, 4
    mov dword [ebp - 32], eax    ; pindahkan alamat Box* ke dalam offset 32


    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 90    ; masukkan nilai 90 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    ; deklarasi variabel second
    sub esp, 4
    mov dword [ebp - 36], eax    ; pindahkan alamat Box* ke dalam offset 36


    ; ambil offset variabel first
    mov eax, [ebp - 32]    ; eax = Box*

    push eax    ; simpan Box* left operand ke stack
    ; ambil offset variabel second
    mov eax, [ebp - 36]    ; eax = Box*

    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    cmp edx, ebx
    setl bl
    movzx edx, bl
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 0
    mov dword [eax+4], 0


    ; deklarasi variabel isSmall
    sub esp, 4
    mov dword [ebp - 40], eax    ; pindahkan alamat Box* ke dalam offset 40


    ; ambil offset variabel first
    mov eax, [ebp - 32]    ; eax = Box*

    push eax    ; simpan Box* left operand ke stack
    ; ambil offset variabel second
    mov eax, [ebp - 36]    ; eax = Box*

    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    cmp edx, ebx
    setl bl
    movzx edx, bl
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 0
    mov dword [eax+4], 0


    ; print
    push dword [eax + 4]    ; push tipe data value (number)
    push dword [eax]    ; push nilai 0 dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; ambil offset variabel isSmall
    mov eax, [ebp - 40]    ; eax = Box*

    ; print
    push dword [eax + 4]    ; push tipe data value (undefined)
    push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 90    ; masukkan nilai 90 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    push eax    ; simpan Box* left operand ke stack
    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 8    ; masukkan nilai 8 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    cmp edx, ebx
    setg bl
    movzx edx, bl
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 1
    mov dword [eax+4], 0


    ; print
    push dword [eax + 4]    ; push tipe data value (number)
    push dword [eax]    ; push nilai 1 dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; ambil offset variabel first
    mov eax, [ebp - 32]    ; eax = Box*

    push eax    ; simpan Box* left operand ke stack
    ; ambil offset variabel second
    mov eax, [ebp - 36]    ; eax = Box*

    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    cmp edx, ebx
    sete bl
    movzx edx, bl
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 1
    mov dword [eax+4], 0


    ; print
    push dword [eax + 4]    ; push tipe data value (number)
    push dword [eax]    ; push nilai 1 dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; ambil offset variabel first
    mov eax, [ebp - 32]    ; eax = Box*

    push eax    ; simpan Box* left operand ke stack
    ; ambil offset variabel second
    mov eax, [ebp - 36]    ; eax = Box*

    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    cmp edx, ebx
    setne bl
    movzx edx, bl
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 0
    mov dword [eax+4], 0


    ; print
    push dword [eax + 4]    ; push tipe data value (number)
    push dword [eax]    ; push nilai 0 dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; ambil offset variabel first
    mov eax, [ebp - 32]    ; eax = Box*

    push eax    ; simpan Box* left operand ke stack
    ; ambil offset variabel second
    mov eax, [ebp - 36]    ; eax = Box*

    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    cmp edx, ebx
    setge bl
    movzx edx, bl
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 0
    mov dword [eax+4], 0


    ; print
    push dword [eax + 4]    ; push tipe data value (number)
    push dword [eax]    ; push nilai 0 dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; ambil offset variabel first
    mov eax, [ebp - 32]    ; eax = Box*

    push eax    ; simpan Box* left operand ke stack
    ; ambil offset variabel second
    mov eax, [ebp - 36]    ; eax = Box*

    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    cmp edx, ebx
    setle bl
    movzx edx, bl
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 0
    mov dword [eax+4], 0


    ; print
    push dword [eax + 4]    ; push tipe data value (number)
    push dword [eax]    ; push nilai 0 dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; ambil offset variabel x
    mov eax, [ebp - 4]    ; eax = Box*

    push eax    ; simpan Box* left operand ke stack
    ; ambil offset variabel y
    mov eax, [ebp - 8]    ; eax = Box*

    mov esi, eax    ; esi = Box* right operand
    pop ecx    ; ecx = Box* left operand
    ; result disimpan di register eax
    push 8    ; Alokasikan 8 byte untuk Box (value + type)
    call alloc
    add esp, 4
    mov edx, [ecx]      ; ambil left value dari ecx
    mov ebx, [esi]      ; ambil right value dari esi
    add edx, ebx    ; undefined + undefined
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = NaN
    mov dword [eax+4], 0


    ; deklarasi variabel sum
    sub esp, 4
    mov dword [ebp - 44], eax    ; pindahkan alamat Box* ke dalam offset 44


    ; ambil offset variabel sum
    mov eax, [ebp - 44]    ; eax = Box*

    ; print
    push dword [eax + 4]    ; push tipe data value (undefined)
    push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
    call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter

    ; Alokasikan 8 byte untuk Box (value + type)
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 100    ; masukkan nilai 100 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


    ; deklarasi variabel nilai
    sub esp, 4
    mov dword [ebp - 48], eax    ; pindahkan alamat Box* ke dalam offset 48


    ; ambil offset variabel nilai
    mov eax, [ebp - 48]    ; eax = Box*

    mov edx, [eax]    ; pindahkan nilai dalam Box* ke edx
    mov ecx, 10    ; masukkan nilai 10 ke register ecx
    cmp edx, ebx
    setne bl
    movzx edx, bl
    ; simpan hasil
    mov [eax], edx    ; Box* dalam eax = 1
    mov dword [eax+4], 0


    ; jika false maka lanjut kondisi selanjutnya
    cmp eax, 0
    je if_0_elif_0_cond
    jmp if_0_then

if_0_then:
        ; Alokasikan 8 byte untuk Box (value + type)
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_5    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string


        ; print
        push dword [eax + 4]    ; push tipe data value (string)
        push dword [eax]    ; push nilai muehehehehe dalam register eax ke stack sebagai parameter fungsi
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter

    push eax
    pop eax
    jmp if_0_end

if_0_elif_0_cond:
    ; ambil offset variabel nilai
    mov eax, [ebp - 48]    ; eax = Box*

    mov edx, [eax]    ; pindahkan nilai dalam Box* ke edx
    mov ecx, 9    ; masukkan nilai 9 ke register ecx
    cmp edx, ecx
    sete al
    movzx eax, al
    cmp dword eax, 0
    je if_0_elif_1_cond
    jmp if_0_elif_0_then

if_0_elif_0_then:
        ; Alokasikan 8 byte untuk Box (value + type)
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_6    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string


        ; print
        push dword [eax + 4]    ; push tipe data value (string)
        push dword [eax]    ; push nilai elif dalam register eax ke stack sebagai parameter fungsi
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter

    push eax
    pop eax
    jmp if_0_end

if_0_elif_1_cond:
    ; ambil offset variabel nilai
    mov eax, [ebp - 48]    ; eax = Box*

    mov edx, [eax]    ; pindahkan nilai dalam Box* ke edx
    mov ecx, 7    ; masukkan nilai 7 ke register ecx
    cmp edx, ecx
    sete al
    movzx eax, al
    cmp dword eax, 0
    je if_0_elif_2_cond
    jmp if_0_elif_1_then

if_0_elif_1_then:
        ; Alokasikan 8 byte untuk Box (value + type)
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_7    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string


        ; print
        push dword [eax + 4]    ; push tipe data value (string)
        push dword [eax]    ; push nilai elif2 dalam register eax ke stack sebagai parameter fungsi
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter

    push eax
    pop eax
    jmp if_0_end

if_0_elif_2_cond:
    ; ambil offset variabel nilai
    mov eax, [ebp - 48]    ; eax = Box*

    mov edx, [eax]    ; pindahkan nilai dalam Box* ke edx
    mov ecx, 99    ; masukkan nilai 99 ke register ecx
    cmp edx, ecx
    sete al
    movzx eax, al
    cmp dword eax, 0
    je if_0_else
    jmp if_0_elif_2_then

if_0_elif_2_then:
        ; Alokasikan 8 byte untuk Box (value + type)
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_8    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string


        ; print
        push dword [eax + 4]    ; push tipe data value (string)
        push dword [eax]    ; push nilai elif3 dalam register eax ke stack sebagai parameter fungsi
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter

    push eax
    pop eax
    jmp if_0_end

if_0_else:
        ; Alokasikan 8 byte untuk Box (value + type)
        push 8
        call alloc
        add esp, 4
        mov dword [eax], str_9    ; masukkan alamat label ke alamat dalam register eax
        mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string


        ; print
        push dword [eax + 4]    ; push tipe data value (string)
        push dword [eax]    ; push nilai else dalam register eax ke stack sebagai parameter fungsi
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter

        ; Alokasikan 8 byte untuk Box (value + type)
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 99    ; masukkan nilai 99 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


        ; deklarasi variabel m
        sub esp, 4
        mov dword [ebp - 52], eax    ; pindahkan alamat Box* ke dalam offset 52


        ; ambil offset variabel m
        mov eax, [ebp - 52]    ; eax = Box*

        ; print
        push dword [eax + 4]    ; push tipe data value (undefined)
        push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
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
if_0_end:

    for_0_check:
        ; Alokasikan 8 byte untuk Box (value + type)
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 0    ; masukkan nilai 0 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


        ; deklarasi variabel i
        sub esp, 4
        mov dword [ebp - 52], eax    ; pindahkan alamat Box* ke dalam offset 52


        for_0_body:
        mov ecx, 2    ; masukkan nilai 2 ke register ecx
        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        cmp [eax], ecx
        jge for_0_end
        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        ; print
        push dword [eax + 4]    ; push tipe data value (undefined)
        push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter

        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        add dword [eax], 1
        jmp for_0_body
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
    for_1_check:
        ; Alokasikan 8 byte untuk Box (value + type)
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 0    ; masukkan nilai 0 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


        ; deklarasi variabel i
        sub esp, 4
        mov dword [ebp - 52], eax    ; pindahkan alamat Box* ke dalam offset 52


        for_1_body:
        mov ecx, 6    ; masukkan nilai 6 ke register ecx
        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        cmp [eax], ecx
        jge for_1_end
        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        ; print
        push dword [eax + 4]    ; push tipe data value (undefined)
        push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter

        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        add dword [eax], 2
        jmp for_1_body
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
    for_2_check:
        ; Alokasikan 8 byte untuk Box (value + type)
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 5    ; masukkan nilai 5 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


        ; deklarasi variabel i
        sub esp, 4
        mov dword [ebp - 52], eax    ; pindahkan alamat Box* ke dalam offset 52


        for_2_body:
        mov ecx, -1    ; masukkan nilai -1 ke register ecx
        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        cmp [eax], ecx
        jle for_2_end
        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        ; print
        push dword [eax + 4]    ; push tipe data value (undefined)
        push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter

        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        add dword [eax], -2
        jmp for_2_body
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
    for_3_check:
        ; Alokasikan 8 byte untuk Box (value + type)
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


        ; deklarasi variabel i
        sub esp, 4
        mov dword [ebp - 52], eax    ; pindahkan alamat Box* ke dalam offset 52


        for_3_body:
        mov ecx, 12    ; masukkan nilai 12 ke register ecx
        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        cmp [eax], ecx
        jge for_3_end
        for_4_check:
            ; Alokasikan 8 byte untuk Box (value + type)
            push 8
            call alloc
            add esp, 4
            mov dword [eax], 10    ; masukkan nilai 10 ke alamat dalam register eax
            mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


            ; deklarasi variabel j
            sub esp, 4
            mov dword [ebp - 56], eax    ; pindahkan alamat Box* ke dalam offset 56


            for_4_body:
            mov ecx, 12    ; masukkan nilai 12 ke register ecx
            ; ambil offset variabel j
            mov eax, [ebp - 56]    ; eax = Box*

            cmp [eax], ecx
            jge for_4_end
            ; Alokasikan 8 byte untuk Box (value + type)
            push 8
            call alloc
            add esp, 4
            mov dword [eax], 99    ; masukkan nilai 99 ke alamat dalam register eax
            mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


            ; deklarasi variabel z
            sub esp, 4
            mov dword [ebp - 60], eax    ; pindahkan alamat Box* ke dalam offset 60


            ; ambil offset variabel j
            mov eax, [ebp - 56]    ; eax = Box*

            ; print
            push dword [eax + 4]    ; push tipe data value (undefined)
            push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
            call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
            add esp, 8    ; pop argument dari stack
            call newline    ; untuk memanggil enter

            ; ambil offset variabel j
            mov eax, [ebp - 56]    ; eax = Box*

            add dword [eax], 1
            jmp for_4_body
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
        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        add dword [eax], 1
        jmp for_3_body
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
    for_5_check:
        ; Alokasikan 8 byte untuk Box (value + type)
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 0    ; masukkan nilai 0 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


        ; deklarasi variabel i
        sub esp, 4
        mov dword [ebp - 52], eax    ; pindahkan alamat Box* ke dalam offset 52


        for_5_body:
        mov ecx, 2    ; masukkan nilai 2 ke register ecx
        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        cmp [eax], ecx
        jge for_5_end
        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        ; print
        push dword [eax + 4]    ; push tipe data value (undefined)
        push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
        call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
        add esp, 8    ; pop argument dari stack
        call newline    ; untuk memanggil enter

        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        mov edx, [eax]    ; pindahkan nilai dalam Box* ke edx
        mov ecx, 0    ; masukkan nilai 0 ke register ecx
        cmp edx, ecx
        sete al
        movzx eax, al
        ; jika false maka lanjut kondisi selanjutnya
        cmp eax, 0
        je if_1_end
        jmp if_1_then

if_1_then:
            ; Alokasikan 8 byte untuk Box (value + type)
            push 8
            call alloc
            add esp, 4
            mov dword [eax], str_10    ; masukkan alamat label ke alamat dalam register eax
            mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string


            ; print
            push dword [eax + 4]    ; push tipe data value (string)
            push dword [eax]    ; push nilai ini 0 dalam register eax ke stack sebagai parameter fungsi
            call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
            add esp, 8    ; pop argument dari stack
            call newline    ; untuk memanggil enter

        push eax
        pop eax
        jmp if_1_end

if_1_end:

        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        add dword [eax], 1
        jmp for_5_body
        for_5_end:
    push eax
    ; free alamat heap variabel i
    mov eax, [ebp - 52]
    push 8
    push eax
    call dealloc
    add esp, 8
    pop eax
    add esp, 4
    for_6_check:
        ; Alokasikan 8 byte untuk Box (value + type)
        push 8
        call alloc
        add esp, 4
        mov dword [eax], 0    ; masukkan nilai 0 ke alamat dalam register eax
        mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


        ; deklarasi variabel i
        sub esp, 4
        mov dword [ebp - 52], eax    ; pindahkan alamat Box* ke dalam offset 52


        for_6_body:
        mov ecx, 2    ; masukkan nilai 2 ke register ecx
        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        cmp [eax], ecx
        jge for_6_end
        for_7_check:
            ; Alokasikan 8 byte untuk Box (value + type)
            push 8
            call alloc
            add esp, 4
            mov dword [eax], 0    ; masukkan nilai 0 ke alamat dalam register eax
            mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0


            ; deklarasi variabel j
            sub esp, 4
            mov dword [ebp - 56], eax    ; pindahkan alamat Box* ke dalam offset 56


            for_7_body:
            mov ecx, 2    ; masukkan nilai 2 ke register ecx
            ; ambil offset variabel j
            mov eax, [ebp - 56]    ; eax = Box*

            cmp [eax], ecx
            jge for_7_end
            ; ambil offset variabel j
            mov eax, [ebp - 56]    ; eax = Box*

            mov edx, [eax]    ; pindahkan nilai dalam Box* ke edx
            mov ecx, 1    ; masukkan nilai 1 ke register ecx
            cmp edx, ecx
            sete al
            movzx eax, al
            ; jika false maka lanjut kondisi selanjutnya
            cmp eax, 0
            je if_2_else
            jmp if_2_then

if_2_then:
                ; ambil offset variabel j
                mov eax, [ebp - 56]    ; eax = Box*

                ; print
                push dword [eax + 4]    ; push tipe data value (undefined)
                push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
                call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
                add esp, 8    ; pop argument dari stack
                call newline    ; untuk memanggil enter

                ; Alokasikan 8 byte untuk Box (value + type)
                push 8
                call alloc
                add esp, 4
                mov dword [eax], str_11    ; masukkan alamat label ke alamat dalam register eax
                mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string


                ; deklarasi variabel inner
                sub esp, 4
                mov dword [ebp - 60], eax    ; pindahkan alamat Box* ke dalam offset 60


                ; ambil offset variabel inner
                mov eax, [ebp - 60]    ; eax = Box*

                ; print
                push dword [eax + 4]    ; push tipe data value (undefined)
                push dword [eax]    ; push nilai undefined dalam register eax ke stack sebagai parameter fungsi
                call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
                add esp, 8    ; pop argument dari stack
                call newline    ; untuk memanggil enter

            push eax
            ; free alamat heap variabel inner
            mov eax, [ebp - 60]
            push 8
            push eax
            call dealloc
            add esp, 8
            pop eax
            add esp, 4
            jmp if_2_end

if_2_else:
                ; Alokasikan 8 byte untuk Box (value + type)
                push 8
                call alloc
                add esp, 4
                mov dword [eax], str_12    ; masukkan alamat label ke alamat dalam register eax
                mov dword [eax + 4], 1    ; masukkan tipe data dari value, yaitu string


                ; print
                push dword [eax + 4]    ; push tipe data value (string)
                push dword [eax]    ; push nilai hemm dalam register eax ke stack sebagai parameter fungsi
                call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
                add esp, 8    ; pop argument dari stack
                call newline    ; untuk memanggil enter

            push eax
            pop eax
if_2_end:

            ; ambil offset variabel j
            mov eax, [ebp - 56]    ; eax = Box*

            add dword [eax], 1
            jmp for_7_body
            for_7_end:
        push eax
        ; free alamat heap variabel j
        mov eax, [ebp - 56]
        push 8
        push eax
        call dealloc
        add esp, 8
        pop eax
        add esp, 4
        ; ambil offset variabel i
        mov eax, [ebp - 52]    ; eax = Box*

        add dword [eax], 1
        jmp for_6_body
        for_6_end:
    push eax
    ; free alamat heap variabel i
    mov eax, [ebp - 52]
    push 8
    push eax
    call dealloc
    add esp, 8
    pop eax
    add esp, 4

	mov esp, ebp
	pop ebp

	mov eax, 1
	xor ebx, ebx
	int 0x80

