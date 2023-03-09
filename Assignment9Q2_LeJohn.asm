INCLUDE Irvine32.inc
	COMMENT #
	John Le
	August 7th, 2022
	COSC 2406 Assignment 9, Question 2
	program: converting a float value to binary
	#
.data
	prompt1 BYTE "Please enter a float value: " , 0
	binary  BYTE "Real number in binary: " , 0
	value	DWORD ?
	unbias  BYTE "x 2 ^ " , 0
	onePos	BYTE "+1" , 0
	oneNeg	BYTE "-1" , 0
.code

main PROC
	FINIT
	mov edx, OFFSET prompt1				;asking user to input float value
	call WriteString
	call Readfloat

	FSTP value							;storing float value from user into float
	mov edx, OFFSET binary
	call WriteString
	FLD value							;ebp + 8
	call displayFloat


	call WriteString
	;call WriteFloat
	FFREE ST(0)
	call ShowFPUStack

	exit
	main ENDP

;**************************************************
displayFloat PROC USES eax
;RECEIVES:float from user called value
;RETURNS: binary value ontop of FPU stack
;**************************************************
	push ebp
	mov ebp, esp

	mov eax, DWORD PTR [ebp + 8]		;load float into eax register
	call WriteBin
	call CrLf
	call CrLf
	cmp eax, 0							;comparing eax to zero, if eax > 0, positive number. else negative num
	jg positive							;jump if greater to positive label
	mov edx, OFFSET oneNeg
	jmp next
positive:
	mov edx, OFFSET onePos
	
	
next:
	
	call WriteBin
										;127 = 0111 1111b
	mov eax, DWORD PTR [ebp + 8]		;load float into eax register
	shl al, 9
	mov ecx, 23
L1:
	sal eax, 1							;shifting once to left and having value inside CF
	push eax
	jc notZero							;if CF=1 jump to notZero
	mov eax, 0

	jmp finish
notZero:
	mov eax, 1
	
finish:
	call WriteInt						;displaying 1 or 0 based on CF value set
	pop eax
	loop L1


	pop ebp
	ret
displayFloat ENDP

END main