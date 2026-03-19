%include "/home/hamm/Documents/aiko_js_fullstack/aiko_js/helper/stdio.asm"
section .data
	str_0 db "Halo \k dunia", 0    ; variabel string global bernama str_0 dengan tipe byte

section .bss

section .text
    global _start

_start:
    push ebp
    mov ebp, esp
    call arena_init

    ; ------------------------------ Start Literal ------------------------------
    push 8    ; ------------------------------ alokasi untuk 1 element ------------------------------
    call arena_alloc
    add esp, 4
    mov dword [eax], str_0    ; alamat dalam register eax = alamat label
    mov dword [eax + 4], 1    ; tipe data = string sebagai 1
    ; ------------------------------ End Literal ------------------------------


    ; ------------------------------ Start Deklarasi variabel str2 ------------------------------
    sub esp, 4
    mov dword [ebp - 4], eax    ; pindahkan alamat Box* ke dalam offset 4
    ; ------------------------------ End Deklarasi variabel str2 ------------------------------



    mov esp, ebp
    pop ebp

    mov eax, 1
    xor ebx, ebx
    int 0x80

