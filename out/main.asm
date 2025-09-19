%include "/home/hamm/Documents/aiko_js_fullstack/aiko_js/helper/stdio.asm"
section .data
	strLiteralCounter0 db "hello world", 0    ; buat variabel string global bernama strLiteralCounter0 dengan tipe byte
	strLiteralCounter1 db "str", 0    ; buat variabel string global bernama strLiteralCounter1 dengan tipe byte
	strLiteralCounter2 db "muehehehehe", 0    ; buat variabel string global bernama strLiteralCounter2 dengan tipe byte
	strLiteralCounter3 db "elif", 0    ; buat variabel string global bernama strLiteralCounter3 dengan tipe byte
	strLiteralCounter4 db "elif2", 0    ; buat variabel string global bernama strLiteralCounter4 dengan tipe byte
	strLiteralCounter5 db "elif3", 0    ; buat variabel string global bernama strLiteralCounter5 dengan tipe byte
	strLiteralCounter6 db "else", 0    ; buat variabel string global bernama strLiteralCounter6 dengan tipe byte
	strLiteralCounter7 db "ini 0", 0    ; buat variabel string global bernama strLiteralCounter7 dengan tipe byte

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


	mov eax, [ebp - 4]    ; masukkan nilai yang tersimpan didalam offset -4 ke register eax
	push eax    ; push nilai dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 888 dari stack
	call newline    ; untuk memanggil enter

	mov eax, [ebp - 8]    ; masukkan nilai yang tersimpan didalam offset -8 ke register eax
	push eax    ; push nilai dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 9987 dari stack
	call newline    ; untuk memanggil enter

	sub esp, 4    ; alokasi stack sebesar 4 byte untuk variable bernama z
	mov dword [ebp - 12], strLiteralCounter1    ; pindahkan nilai strLiteralCounter1 ke dalam stack dengan offset -12


	mov eax, [ebp - 12]    ; masukkan nilai yang tersimpan didalam offset -12 ke register eax
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


	mov eax, [ebp - 20]    ; masukkan nilai yang tersimpan didalam offset -20 ke register eax
	push eax    ; simpan left operand ke stack
	mov eax, [ebp - 24]    ; masukkan nilai yang tersimpan didalam offset -24 ke register eax
	pop ecx    ; ambil right operand dari stack
	cmp ecx, eax
	setl al
	movzx eax, al


	sub esp, 4    ; alokasi stack untuk variable bernama isSmall
	mov [ebp - 28], eax    ; simpan hasil ekspresi ke stack

	mov eax, [ebp - 20]    ; masukkan nilai yang tersimpan didalam offset -20 ke register eax
	push eax    ; simpan left operand ke stack
	mov eax, [ebp - 24]    ; masukkan nilai yang tersimpan didalam offset -24 ke register eax
	pop ecx    ; ambil right operand dari stack
	cmp ecx, eax
	setl al
	movzx eax, al


	push eax    ; push nilai 0 dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 0 dari stack
	call newline    ; untuk memanggil enter

	mov eax, [ebp - 28]    ; masukkan nilai yang tersimpan didalam offset -28 ke register eax
	push eax    ; push nilai dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 0 dari stack
	call newline    ; untuk memanggil enter

	mov eax, [ebp - 4]    ; masukkan nilai yang tersimpan didalam offset -4 ke register eax
	push eax    ; simpan left operand ke stack
	mov eax, [ebp - 8]    ; masukkan nilai yang tersimpan didalam offset -8 ke register eax
	pop ecx    ; ambil right operand dari stack
	add eax, ecx    ; 888(ecx) + 9987 eax


	sub esp, 4    ; alokasi stack untuk variable bernama sum
	mov [ebp - 32], eax    ; simpan hasil ekspresi ke stack

	mov eax, [ebp - 32]    ; masukkan nilai yang tersimpan didalam offset -32 ke register eax
	push eax    ; push nilai dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 10875 dari stack
	call newline    ; untuk memanggil enter

	mov eax, 10    ; masukkan nilai 10 ke register eax
	sub esp, 4    ; alokasi stack sebesar 4 byte untuk variable bernama nilai
	mov dword [ebp - 36], 10    ; pindahkan nilai 10 ke dalam stack dengan offset -36


	mov eax, [ebp - 36]    ; masukkan nilai yang tersimpan didalam offset -36 ke register eax
	push eax    ; simpan left operand ke stack
	mov eax, 10    ; masukkan nilai 10 ke register eax
	pop ecx    ; ambil right operand dari stack
	cmp ecx, eax
	setg al
	movzx eax, al


	cmp eax, 0    ; apakah false
	je cond_0_elif_0    ; kalau false lompat ke cond_0_elif_0
	jmp cond_0_then    ; kalau true lanjut ke then
cond_0_then:
	mov ecx, strLiteralCounter2
	call print_str    ; panggil fungsi untuk menampilkan nilai berupa string
	call newline    ; untuk memanggil enter

	jmp cond_0_end
cond_0_elif_0:
	mov eax, [ebp - 36]    ; masukkan nilai yang tersimpan didalam offset -36 ke register eax
	push eax    ; simpan left operand ke stack
	mov eax, 9    ; masukkan nilai 9 ke register eax
	pop ecx    ; ambil right operand dari stack
	cmp ecx, eax
	sete al
	movzx eax, al


	cmp eax, 0
	je cond_0_elif_1    ; lompat ke cond_0_elif_1
	jmp cond_0_elif_0_body    ; lompat ke cond_0_elif_0_body
cond_0_elif_0_body:
	mov ecx, strLiteralCounter3
	call print_str    ; panggil fungsi untuk menampilkan nilai berupa string
	call newline    ; untuk memanggil enter

	jmp cond_0_end
cond_0_elif_1:
	mov eax, [ebp - 36]    ; masukkan nilai yang tersimpan didalam offset -36 ke register eax
	push eax    ; simpan left operand ke stack
	mov eax, 7    ; masukkan nilai 7 ke register eax
	pop ecx    ; ambil right operand dari stack
	cmp ecx, eax
	sete al
	movzx eax, al


	cmp eax, 0
	je cond_0_elif_2    ; lompat ke cond_0_elif_2
	jmp cond_0_elif_1_body    ; lompat ke cond_0_elif_1_body
cond_0_elif_1_body:
	mov ecx, strLiteralCounter4
	call print_str    ; panggil fungsi untuk menampilkan nilai berupa string
	call newline    ; untuk memanggil enter

	jmp cond_0_end
cond_0_elif_2:
	mov eax, [ebp - 36]    ; masukkan nilai yang tersimpan didalam offset -36 ke register eax
	push eax    ; simpan left operand ke stack
	mov eax, 99    ; masukkan nilai 99 ke register eax
	pop ecx    ; ambil right operand dari stack
	cmp ecx, eax
	sete al
	movzx eax, al


	cmp eax, 0
	je cond_0_else    ; lompat ke cond_0_else
	jmp cond_0_elif_2_body    ; lompat ke cond_0_elif_2_body
cond_0_elif_2_body:
	mov ecx, strLiteralCounter5
	call print_str    ; panggil fungsi untuk menampilkan nilai berupa string
	call newline    ; untuk memanggil enter

	jmp cond_0_end
cond_0_else:
	mov ecx, strLiteralCounter6
	call print_str    ; panggil fungsi untuk menampilkan nilai berupa string
	call newline    ; untuk memanggil enter

	jmp cond_0_end
cond_0_end:
	mov eax, 0    ; masukkan nilai 0 ke register eax
	sub esp, 4    ; alokasi stack sebesar 4 byte untuk variable bernama i
	mov dword [ebp - 40], 0    ; pindahkan nilai 0 ke dalam stack dengan offset -40


	jmp loop_cond_0
loop_cond_0:
	mov eax, 2    ; masukkan nilai 2 ke register eax
	mov ecx, 2    ; end
	mov eax, [ebp - 40]   ; load i
	cmp eax, ecx                ; bandingkan i dengan end
	jge loop_end_0               ; kalau i > end lompat ke akhir
	jmp loop_body_0
loop_body_0:
	mov eax, [ebp - 40]    ; masukkan nilai yang tersimpan didalam offset -40 ke register eax
	push eax    ; push nilai dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 0 dari stack
	call newline    ; untuk memanggil enter

	jmp loop_inc_0
loop_inc_0:
	mov eax, 1    ; masukkan nilai 1 ke register eax
	mov edx, 1    ; step
	mov eax, [ebp - 40]   ; load i
	add eax, edx                ; i += step
	mov [ebp - 40], eax  ; simpan kembali
	jmp loop_cond_0
loop_end_0:
	mov eax, 0    ; masukkan nilai 0 ke register eax
	sub esp, 4    ; alokasi stack sebesar 4 byte untuk variable bernama i
	mov dword [ebp - 44], 0    ; pindahkan nilai 0 ke dalam stack dengan offset -44


	jmp loop_cond_1
loop_cond_1:
	mov eax, 2    ; masukkan nilai 2 ke register eax
	mov ecx, 2    ; end
	mov eax, [ebp - 44]   ; load i
	cmp eax, ecx                ; bandingkan i dengan end
	jge loop_end_1               ; kalau i > end lompat ke akhir
	jmp loop_body_1
loop_body_1:
	mov eax, 0    ; masukkan nilai 0 ke register eax
	sub esp, 4    ; alokasi stack sebesar 4 byte untuk variable bernama j
	mov dword [ebp - 48], 0    ; pindahkan nilai 0 ke dalam stack dengan offset -48


	jmp loop_cond_2
loop_cond_2:
	mov eax, 2    ; masukkan nilai 2 ke register eax
	mov ecx, 2    ; end
	mov eax, [ebp - 48]   ; load i
	cmp eax, ecx                ; bandingkan i dengan end
	jge loop_end_2               ; kalau i > end lompat ke akhir
	jmp loop_body_2
loop_body_2:
	mov eax, [ebp - 48]    ; masukkan nilai yang tersimpan didalam offset -48 ke register eax
	push eax    ; push nilai dalam register eax ke stack sebagai parameter fungsi
	call print_int    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 4    ; pop nilai 0 dari stack
	call newline    ; untuk memanggil enter

	jmp loop_inc_2
loop_inc_2:
	mov eax, 1    ; masukkan nilai 1 ke register eax
	mov edx, 1    ; step
	mov eax, [ebp - 48]   ; load i
	add eax, edx                ; i += step
	mov [ebp - 48], eax  ; simpan kembali
	jmp loop_cond_2
loop_end_2:
	jmp loop_inc_1
loop_inc_1:
	mov eax, 1    ; masukkan nilai 1 ke register eax
	mov edx, 1    ; step
	mov eax, [ebp - 44]   ; load i
	add eax, edx                ; i += step
	mov [ebp - 44], eax  ; simpan kembali
	jmp loop_cond_1
loop_end_1:
	mov eax, 0    ; masukkan nilai 0 ke register eax
	sub esp, 4    ; alokasi stack sebesar 4 byte untuk variable bernama i
	mov dword [ebp - 52], 0    ; pindahkan nilai 0 ke dalam stack dengan offset -52


	jmp loop_cond_3
loop_cond_3:
	mov eax, 2    ; masukkan nilai 2 ke register eax
	mov ecx, 2    ; end
	mov eax, [ebp - 52]   ; load i
	cmp eax, ecx                ; bandingkan i dengan end
	jge loop_end_3               ; kalau i > end lompat ke akhir
	jmp loop_body_3
loop_body_3:
	mov eax, [ebp - 52]    ; masukkan nilai yang tersimpan didalam offset -52 ke register eax
	push eax    ; simpan left operand ke stack
	mov eax, 0    ; masukkan nilai 0 ke register eax
	pop ecx    ; ambil right operand dari stack
	cmp ecx, eax
	sete al
	movzx eax, al


	cmp eax, 0    ; apakah false
	je cond_1_end    ; kalau false lompat ke cond_1_end
	jmp cond_1_then    ; kalau true lanjut ke then
cond_1_then:
	mov ecx, strLiteralCounter7
	call print_str    ; panggil fungsi untuk menampilkan nilai berupa string
	call newline    ; untuk memanggil enter

	jmp cond_1_end
cond_1_end:
	jmp loop_inc_3
loop_inc_3:
	mov eax, 1    ; masukkan nilai 1 ke register eax
	mov edx, 1    ; step
	mov eax, [ebp - 52]   ; load i
	add eax, edx                ; i += step
	mov [ebp - 52], eax  ; simpan kembali
	jmp loop_cond_3
loop_end_3:

	mov esp, ebp
	pop ebp

	mov eax, 1
	xor ebx, ebx
	int 0x80

