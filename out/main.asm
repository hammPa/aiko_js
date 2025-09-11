%include "/home/hamm/Documents/aiko_js_fullstack/aiko_js/helper/stdio.asm"
section .data
	strLiteralCounter0 db "hello world", 0    ; buat variabel string global bernama strLiteralCounter0 dengan tipe byte
	strLiteralCounter1 db "str", 0    ; buat variabel string global bernama strLiteralCounter1 dengan tipe byte

section .bss

section .text
	global _start

_start:
	push ebp
	mov ebp, esp

	mov eax, 10    ; masukkan nilai 10 ke register eax
	push eax    ; push nilai 10 dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 10 dari stack
	call newline    ; untuk memanggil enter

	mov eax, 10    ; masukkan nilai 10 ke register eax
	push eax    ; simpan left operand ke stack
	mov eax, 5    ; masukkan nilai 5 ke register eax
	pop ecx    ; ambil right operand dari stack
	add eax, ecx    ; 10(ecx) + 5 eax


	push eax    ; push nilai 15 dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 15 dari stack
	call newline    ; untuk memanggil enter

	mov eax, 10    ; masukkan nilai 10 ke register eax
	push eax    ; simpan left operand ke stack
	mov eax, 2    ; masukkan nilai 2 ke register eax
	pop ecx    ; ambil right operand dari stack
	sub ecx, eax    ; 10(ecx) - 2(eax)
	mov eax, ecx    ; pindahkan hasil pengurangan dari register ecx ke eax


	push eax    ; push nilai 8 dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 8 dari stack
	call newline    ; untuk memanggil enter

	mov eax, 10    ; masukkan nilai 10 ke register eax
	push eax    ; simpan left operand ke stack
	mov eax, 4    ; masukkan nilai 4 ke register eax
	pop ecx    ; ambil right operand dari stack
	imul eax, ecx    ; 10(eax) * 4(ecx)


	push eax    ; push nilai 40 dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 40 dari stack
	call newline    ; untuk memanggil enter

	mov eax, 10    ; masukkan nilai 10 ke register eax
	push eax    ; simpan left operand ke stack
	mov eax, 2    ; masukkan nilai 2 ke register eax
	pop ecx    ; ambil right operand dari stack
	xchg eax, ecx
	cdq
	div ecx


	push eax    ; push nilai 5 dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 5 dari stack
	call newline    ; untuk memanggil enter

	mov eax, 10    ; masukkan nilai 10 ke register eax
	push eax    ; simpan left operand ke stack
	mov eax, 4    ; masukkan nilai 4 ke register eax
	pop ecx    ; ambil right operand dari stack
	imul eax, ecx    ; 10(eax) * 4(ecx)


	push eax    ; simpan left operand ke stack
	mov eax, 2    ; masukkan nilai 2 ke register eax
	pop ecx    ; ambil right operand dari stack
	xchg eax, ecx
	cdq
	div ecx


	push eax    ; simpan left operand ke stack
	mov eax, 1    ; masukkan nilai 1 ke register eax
	pop ecx    ; ambil right operand dari stack
	add eax, ecx    ; 20(ecx) + 1 eax


	push eax    ; push nilai 21 dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 21 dari stack
	call newline    ; untuk memanggil enter

	mov ecx, strLiteralCounter0
	call print_str    ; panggil fungsi untuk menampilkan nilai berupa string
	call newline    ; untuk memanggil enter

	mov eax, 888    ; masukkan nilai 888 ke register eax
	sub esp, 4    ; alokasi stack sebesar 4 byte untuk variable bernama x
	mov dword [ebp - 4], 888    ; pindahkan nilai 888 ke dalam stack dengan offset -4


	mov eax, 9987    ; masukkan nilai 9987 ke register eax
	sub esp, 4    ; alokasi stack sebesar 4 byte untuk variable bernama y
	mov dword [ebp - 8], 9987    ; pindahkan nilai 9987 ke dalam stack dengan offset -8


	mov eax, [ebp - 4]
	mov eax, [ebp - 4]    ; masukkan nilai yang tersimpan didalam offset -4 ke register eax
	push eax    ; push nilai dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai [object Object] dari stack
	call newline    ; untuk memanggil enter

	mov eax, [ebp - 8]
	mov eax, [ebp - 8]    ; masukkan nilai yang tersimpan didalam offset -8 ke register eax
	push eax    ; push nilai dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai [object Object] dari stack
	call newline    ; untuk memanggil enter

	sub esp, 4    ; alokasi stack sebesar 4 byte untuk variable bernama z
	mov dword [ebp - 12], strLiteralCounter1    ; pindahkan nilai strLiteralCounter1 ke dalam stack dengan offset -12


	mov eax, [ebp - 12]
	mov ecx, [ebp - 12]    ; masukkan nilai yang tersimpan didalam offset -12 ke register ecx
	call print_str    ; panggil fungsi untuk menampilkan nilai berupa number
	call newline    ; untuk memanggil enter

	mov eax, 0    ; masukkan nilai false dengan angka berupa 0 ke eax
	push eax    ; push nilai 0 dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 0 dari stack
	call newline    ; untuk memanggil enter

	mov eax, 1    ; masukkan nilai true dengan angka berupa 1 ke eax
	sub esp, 4    ; alokasi stack sebesar 4 byte (1 boolean, 3 kosong) untuk variable bernama boolean
	mov dword [ebp - 16], eax    ; pindahkan nilai 1 dalam eax ke dalam stack dengan offset -16


	mov eax, [ebp - 16]
	mov eax, [ebp - 16]    ; masukkan nilai yang tersimpan didalam offset -16 ke register eax
	push eax    ; push nilai dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	call newline    ; untuk memanggil enter

	mov eax, 90    ; masukkan nilai 90 ke register eax
	sub esp, 4    ; alokasi stack sebesar 4 byte untuk variable bernama first
	mov dword [ebp - 20], 90    ; pindahkan nilai 90 ke dalam stack dengan offset -20


	mov eax, 90    ; masukkan nilai 90 ke register eax
	sub esp, 4    ; alokasi stack sebesar 4 byte untuk variable bernama second
	mov dword [ebp - 24], 90    ; pindahkan nilai 90 ke dalam stack dengan offset -24


	mov eax, [ebp - 20]
	push eax    ; simpan left operand ke stack
	mov eax, [ebp - 24]
	pop ecx    ; ambil right operand dari stack
	cmp ecx, eax
	setl al
	movzx eax, al


	push eax    ; push nilai 0 dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 0 dari stack
	call newline    ; untuk memanggil enter

	mov eax, [ebp - 4]
	push eax    ; simpan left operand ke stack
	mov eax, [ebp - 8]
	pop ecx    ; ambil right operand dari stack
	add eax, ecx    ; [object Object](ecx) + [object Object] eax



	mov esp, ebp
	pop ebp

	mov eax, 1
	xor ebx, ebx
	int 0x80

