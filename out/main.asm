%include "/home/hamm/Documents/aiko_js/helper/stdio.asm"
section .data
	space db " ", 0
	angka dd 8
	counter dd 3
	tmpvar_0 db "hoo", 0
	tmpvar_1 db "cijks", 0
	tmpvar_2 db "snnmn,zc", 0
	tmpvar_3 db "pppp", 0
	a dd 0
	b dd 0

section .bss

section .text
	global _start


_start:
	mov eax, [angka]
	push eax
	mov eax, 5
	pop ecx
	cmp ecx, eax
	setl al
	movzx eax, al
	cmp eax, 0
	je condition_0_elif_0
condition_0_start:
	mov ecx, tmpvar_0
	call print_str
	call newline


	jmp condition_0_end
condition_0_elif_0:
	mov eax, [angka]
	push eax
	mov eax, 5
	pop ecx
	cmp ecx, eax
	sete al
	movzx eax, al
	cmp eax, 0
	je condition_0_elif_1
	mov ecx, tmpvar_1
	call print_str
	call newline


	jmp condition_0_end
condition_0_elif_1:
	mov eax, [angka]
	push eax
	mov eax, 6
	pop ecx
	cmp ecx, eax
	sete al
	movzx eax, al
	cmp eax, 0
	je condition_0_else
	mov ecx, tmpvar_2
	call print_str
	call newline


	jmp condition_0_end
condition_0_else:
	mov ecx, tmpvar_3
	call print_str
	call newline


condition_0_end:
	push 20
	push 10
	call add
	add esp, 8
	push eax
	call print_int
	add esp, 4
	call newline
	push dword [counter]
	push dword [angka]
	call add
	add esp, 8
	push eax
	call print_int
	add esp, 4
	call newline

	mov eax, 1
	xor ebx, ebx
	int 0x80
add:
	push ebp
	mov ebp, esp
	mov eax, [ebp+8]
	mov [a], eax
	mov eax, [ebp+12]
	mov [b], eax
	mov eax, [a]
	push eax
	mov eax, [b]
	pop ecx
	add eax, ecx
	mov esp, ebp
	pop ebp
	ret
	mov esp, ebp
	pop ebp
	ret
