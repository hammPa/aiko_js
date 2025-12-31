%include "/home/hamm/Documents/aiko_js_fullstack/aiko_js/helper/stdio.asm"
section .data

section .bss

section .text
	global _start

_start:
	push ebp
	mov ebp, esp

	call retParam1


	push ebx    ; hasil return tipe data value
	push eax    ; hasil return fungsi (ada di eax)
	call print_generic    ; print hasil dari fungsi
	add esp, 8    ; bersihkan stack
	call newline    ; buat baris baru

	call retParam1


	sub esp, 4    ; alokasi stack untuk variable bernama retParam1Res
	mov [ebp - 8], eax    ; simpan hasil ekspresi ke stack

	mov eax, [ebp - 8]    ; masukkan nilai yang tersimpan didalam offset -8 ke register eax
	cmp ebx, 0
	je isInt_1
	cmp ebx, 1
	je isString_2
	jmp endType_3

isInt_1:
	push 0    ; push tipe data value sebagai int(0)
	push eax    ; push nilai [object Object] dalam register eax ke stack sebagai parameter fungsi
	call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 8    ; pop argument dari stack
	call newline    ; untuk memanggil enter

	jmp endType_3

isString_2:
	push 1    ; push tipe data sebagai string(1)
	mov ecx, [ebp - 8]    ; masukkan nilai yang tersimpan didalam offset -8 ke register ecx
	push ecx
	call print_generic    ; panggil fungsi untuk menampilkan nilai berupa string
	add esp, 8    ; pop argument dari stack
	call newline    ; untuk memanggil enter

	jmp endType_3

endType_3:


	mov eax, 99    ; masukkan nilai 99 ke register eax
	sub esp, 4    ; alokasi stack sebesar 4 byte untuk variable number bernama arg
	mov dword [ebp - 12], eax    ; pindahkan nilai 99 dalam eax ke dalam stack dengan offset -12


	mov eax, [ebp - 12]    ; masukkan nilai yang tersimpan didalam offset -12 ke register eax
	push 0    ; push tipe data variable
	push eax    ; push variable (sudah di-load ke eax)
	call retParam3
	add esp, 8    ; bersihkan parameter dari stack


	push ebx    ; hasil return tipe data value
	push eax    ; hasil return fungsi (ada di eax)
	call print_generic    ; print hasil dari fungsi
	add esp, 8    ; bersihkan stack
	call newline    ; buat baris baru

	mov eax, [ebp - 12]    ; masukkan nilai yang tersimpan didalam offset -12 ke register eax
	push 0    ; push tipe data variable
	push eax    ; push variable (sudah di-load ke eax)
	call retParam3
	add esp, 8    ; bersihkan parameter dari stack


	sub esp, 4    ; alokasi stack untuk variable bernama retParam3Res
	mov [ebp - 16], eax    ; simpan hasil ekspresi ke stack

	mov eax, [ebp - 16]    ; masukkan nilai yang tersimpan didalam offset -16 ke register eax
	cmp ebx, 0
	je isInt_4
	cmp ebx, 1
	je isString_5
	jmp endType_6

isInt_4:
	push 0    ; push tipe data value sebagai int(0)
	push eax    ; push nilai [object Object] dalam register eax ke stack sebagai parameter fungsi
	call print_generic    ; panggil fungsi untuk menampilkan nilai berupa number
	add esp, 8    ; pop argument dari stack
	call newline    ; untuk memanggil enter

	jmp endType_6

isString_5:
	push 1    ; push tipe data sebagai string(1)
	mov ecx, [ebp - 16]    ; masukkan nilai yang tersimpan didalam offset -16 ke register ecx
	push ecx
	call print_generic    ; panggil fungsi untuk menampilkan nilai berupa string
	add esp, 8    ; pop argument dari stack
	call newline    ; untuk memanggil enter

	jmp endType_6

endType_6:



	mov esp, ebp
	pop ebp

	mov eax, 1
	xor ebx, ebx
	int 0x80

retParam1:
	push ebp    ; buat stack frame baru
	mov ebp, esp

	mov eax, 9    ; masukkan nilai 9 ke register eax
	sub esp, 4    ; alokasi stack sebesar 4 byte untuk variable number bernama a
	mov dword [ebp - 4], eax    ; pindahkan nilai 9 dalam eax ke dalam stack dengan offset -4


	mov eax, [ebp - 4]    ; masukkan nilai yang tersimpan didalam offset -4 ke register eax
	mov ebx, 0

	mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
	pop ebp
	ret
retParam3:
	push ebp    ; buat stack frame baru
	mov ebp, esp

	mov eax, [ebp + 8]    ; masukkan nilai yang tersimpan didalam parameter a ke register eax
	mov ebx, 0

	mov esp, ebp    ; bersihkan stack frame saat fungsi selesai
	pop ebp
	ret
