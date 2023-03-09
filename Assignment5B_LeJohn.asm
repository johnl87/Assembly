INCLUDE Irvine32.inc

	COMMENT #
	John Le COSC 2406 22SF Assignment 5 question 2 part a
	program: creating the BetterRandomRange procedure that repeats 5 times in asking user for high and low values for the range
	#
.data
	prompt1 BYTE "Please enter a high value: " , 0Dh, 0Ah, 0
	prompt2 BYTE "Please enter a low value: " , 0Dh, 0Ah, 0


	highValue DWORD ?
	lowValue DWORD ?
.code

main PROC

	call randomize				;calling the random seed to generate pseudorandom numbers
	mov ecx, 5
L1:
	mov edx, OFFSET prompt1
	call WriteString
	call ReadInt
	mov highValue, eax

	mov edx, OFFSET prompt2
	call WriteString
	call ReadInt
	mov lowValue, eax
	
	loop L1
	call random					;calling random number



	exit
	main ENDP

;randomness procedure
;-----------------------------------------------
random PROC
	mov edx, OFFSET prompt1
	call WriteString
	call ReadInt
	mov highValue, eax

	mov edx, OFFSET prompt2
	call WriteString
	call ReadInt
	mov lowValue, eax


	mov eax, highValue
	mov ebx, lowValue

	;low + (int)(Math.random() * (high - low + 1))
	;random range is in eax

	sub eax, ebx	;(high - low + 1)
	inc eax
	call Randomize
	call RandomRange 
	add eax, ebx

	call CrLf
	call WriteInt

	ret
random ENDP


END main