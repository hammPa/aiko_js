%include "/home/hamm/Documents/aiko_js_fullstack/aiko_js/helper/stdio.asm"
section .data
	str_0 db "hemm", 0    ; variabel string global bernama str_0 dengan tipe byte

section .bss

section .text
    global _start

_start:
    push ebp
    mov ebp, esp

    ; ------------------------------ Start Literal ------------------------------
    push 8    ; ------------------------------ alokasi untuk 1 element ------------------------------
    call alloc
    add esp, 4
    mov dword [eax], str_0    ; alamat dalam register eax = alamat label
    mov dword [eax + 4], 1    ; tipe data = string sebagai 1
    ; ------------------------------ End Literal ------------------------------


    ; ------------------------------ Start Deklarasi variabel assign1 ------------------------------
    sub esp, 4
    mov dword [ebp - 4], eax    ; pindahkan alamat Box* ke dalam offset 4
    ; ------------------------------ End Deklarasi variabel assign1 ------------------------------


    ; ------------------------------ Start Ambil offset variabel assign1 ------------------------------
    mov eax, [ebp - 4]    ; eax = Box*
    ; ------------------------------ End Ambil offset variabel assign1 ------------------------------


    ; ------------------------------ Start Print ------------------------------
    push dword [eax + 4]    ; push tipe data variabel: assign1
    push dword [eax]    ; push nilai variabel: assign1
    call print_generic    ; panggil fungsi untuk menampilkan nilai
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter
    ; ------------------------------ End Print ------------------------------


    ; ------------------------------ Start Ambil offset variabel assign1 ------------------------------
    mov eax, [ebp - 4]    ; eax = Box*
    ; ------------------------------ End Ambil offset variabel assign1 ------------------------------


    ; ------------------------------ Start Deklarasi variabel assignDecl ------------------------------
    sub esp, 4
    mov dword [ebp - 8], eax    ; pindahkan alamat Box* ke dalam offset 8
    ; ------------------------------ End Deklarasi variabel assignDecl ------------------------------


    ; ------------------------------ Start Ambil offset variabel assignDecl ------------------------------
    mov eax, [ebp - 8]    ; eax = Box*
    ; ------------------------------ End Ambil offset variabel assignDecl ------------------------------


    ; ------------------------------ Start Print ------------------------------
    push dword [eax + 4]    ; push tipe data variabel: assignDecl
    push dword [eax]    ; push nilai variabel: assignDecl
    call print_generic    ; panggil fungsi untuk menampilkan nilai
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter
    ; ------------------------------ End Print ------------------------------


    ; ------------------------------ Start Ambil offset variabel assign1 ------------------------------
    mov eax, [ebp - 4]    ; eax = Box*
    ; ------------------------------ End Ambil offset variabel assign1 ------------------------------


    ; ------------------------------ Start Print ------------------------------
    push dword [eax + 4]    ; push tipe data variabel: assign1
    push dword [eax]    ; push nilai variabel: assign1
    call print_generic    ; panggil fungsi untuk menampilkan nilai
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter
    ; ------------------------------ End Print ------------------------------


    ; ------------------------------ Start Ambil offset variabel assignDecl ------------------------------
    mov eax, [ebp - 8]    ; eax = Box*
    ; ------------------------------ End Ambil offset variabel assignDecl ------------------------------


    ; ------------------------------ Start Print ------------------------------
    push dword [eax + 4]    ; push tipe data variabel: assignDecl
    push dword [eax]    ; push nilai variabel: assignDecl
    call print_generic    ; panggil fungsi untuk menampilkan nilai
    add esp, 8    ; pop argument dari stack
    call newline    ; untuk memanggil enter
    ; ------------------------------ End Print ------------------------------



    mov esp, ebp
    pop ebp

    mov eax, 1
    xor ebx, ebx
    int 0x80

