%include "/home/hamm/Documents/aiko_js_fullstack/aiko_js/helper/stdio.asm"
section .data

section .bss

section .text
    global _start

_start:
    push ebp
    mov ebp, esp

    ; ------------------------------Alokasikan 8 byte untuk Box (value + type)------------------------------
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
    push 8
    call alloc
    add esp, 4
    mov dword [eax], 90    ; masukkan nilai 90 ke alamat dalam register eax
    mov dword [eax + 4], 0    ; masukkan tipe data dari value, yaitu angka sebagai 0
    ; ------------------------------Deklarasi variabel first------------------------------
    sub esp, 4
    mov dword [ebp - 4], eax    ; pindahkan alamat Box* ke dalam offset 4



    mov esp, ebp
    pop ebp

    mov eax, 1
    xor ebx, ebx
    int 0x80

