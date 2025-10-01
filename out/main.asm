%include "/home/hamm/Documents/aiko_js_fullstack/aiko_js/helper/stdio.asm"
section .data

section .bss

section .text
	global _start

_start:
	push ebp
	mov ebp, esp

	mov eax, 10    ; masukkan nilai 10 ke register eax
	sub esp, 4    ; alokasi stack sebesar 4 byte (1 boolean, 3 kosong) untuk variable bernama x
	mov dword [ebp - 4], eax    ; pindahkan nilai 10 dalam eax ke dalam stack dengan offset -4


	mov eax, [ebp - 4]    ; masukkan nilai yang tersimpan didalam offset -4 ke register eax
	push eax    ; push nilai dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 10 dari stack
	call newline    ; untuk memanggil enter


	mov esp, ebp
	pop ebp

	mov eax, 1
	xor ebx, ebx
	int 0x80

