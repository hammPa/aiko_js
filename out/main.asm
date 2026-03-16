%include "/home/hamm/Documents/aiko_js_fullstack/aiko_js/helper/stdio.asm"
section .data

section .bss

section .text
    global _start

_start:
    push ebp
    mov ebp, esp
    call arena_init



    mov esp, ebp
    pop ebp

    mov eax, 1
    xor ebx, ebx
    int 0x80

; ------------------------------ Start Deklarasi fungsi inner ------------------------------
fun_inner:
    push ebp    ; buat stack frame baru
    mov ebp, esp


    ; ------------------------------ Start Return ------------------------------
    ; ------------------------------ Start Ambil offset variabel x ------------------------------
    mov eax, [ebp - 4]    ; eax = Box*
    ; ------------------------------ End Ambil offset variabel x ------------------------------


    push eax
    push 8    ; ------------------------------ alokasi untuk 1 element ------------------------------
    call arena_alloc
    add esp, 4
    pop edx
    mov ecx, [edx]      ; Ambil value dari Box Lama
    mov [eax], ecx      ; Masukkan ke Box Baru
    mov ecx, [edx+4]    ; Ambil type dari Box Lama
    mov [eax+4], ecx    ; Masukkan ke Box Baru
    jmp inner_exit
    ; ------------------------------ End Return ------------------------------


inner_exit:
    push eax    ; simpan return value
    mov eax, [esp + 4]    ; ambil arena mark
    call arena_rewind
    pop eax    ; kembalikan return value




    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
    ; ------------------------------ End Deklarasi fungsi inner ------------------------------
; ------------------------------ Start Deklarasi fungsi outer ------------------------------
fun_outer:
    push ebp    ; buat stack frame baru
    mov ebp, esp


    ; ------------------------------ Start Literal ------------------------------
    push 8    ; ------------------------------ alokasi untuk 1 element ------------------------------
    call arena_alloc
    add esp, 4
    mov dword [eax], 10    ; alamat dalam register eax = 10
    mov dword [eax + 4], 0    ; tipe data = angka sebagai 0
    ; ------------------------------ End Literal ------------------------------


    ; ------------------------------ Start Deklarasi variabel x ------------------------------
    sub esp, 4
    mov dword [ebp - 4], eax    ; pindahkan alamat Box* ke dalam offset 4
    ; ------------------------------ End Deklarasi variabel x ------------------------------


    ; ------------------------------ Start Return ------------------------------
    ; ------------------------------ Start Ambil offset variabel x ------------------------------
    mov eax, [ebp - 4]    ; eax = Box*
    ; ------------------------------ End Ambil offset variabel x ------------------------------


    push eax
    push 8    ; ------------------------------ alokasi untuk 1 element ------------------------------
    call arena_alloc
    add esp, 4
    pop edx
    mov ecx, [edx]      ; Ambil value dari Box Lama
    mov [eax], ecx      ; Masukkan ke Box Baru
    mov ecx, [edx+4]    ; Ambil type dari Box Lama
    mov [eax+4], ecx    ; Masukkan ke Box Baru
    jmp inner_exit
    ; ------------------------------ End Return ------------------------------


outer_exit:
    push eax    ; simpan return value
    ; free alamat heap variabel x
    mov eax, [esp + 4]    ; ambil arena mark
    call arena_rewind
    pop eax    ; kembalikan return value
add esp, 4




    mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
    pop ebp
    ret
    ; ------------------------------ End Deklarasi fungsi outer ------------------------------