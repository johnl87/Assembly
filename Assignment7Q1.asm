INCLUDE Irvine32.inc

	TITLE Assignment 7 Question 1 (Assignment7Q1.asm)
	COMMENT #
	John Le, COSC 2406 22SS
	Assignment 7 question 1, July 30th 2022
	Program: create a program to determine if a number is a power of two or not.
	#


.data
	prompt1 BYTE "Please enter a power of two number: " , 0
	binaryStr BYTE "The number entered in binary is: " , 0
	powerOfTwoStr BYTE "The number entered is a power of two " , 0
	notPowerOfTwo BYTE "The number entered is not a power of two " , 0
.code

main PROC
	mov edx, OFFSET prompt1
	call WriteString
	call ReadDec
	call CrLf
	mov edx, OFFSET binaryStr
	call WriteString
	call WriteBin
	call CrLf

	call isPowerOfTwo
	COMMENT #
	jz finish
	mov edx, OFFSET notPowerOfTwo
	call WriteString
	jmp ending

Finish:
	mov edx, OFFSET powerOfTwoStr
	call WriteString
ending:
#
	exit
	main ENDP


;*****************************************
isPowerOfTwo PROC USES eax ebx 
;Receives: eax = number that is power of two
;Returns: ZF
;*****************************************

	mov ebx, 1
start:
	
	cmp eax, ebx
	je powerOf2
	shl bl, 1
	jmp start
powerOf2:
	test ax, 0

	jz finish
	mov edx, OFFSET notPowerOfTwo
	call WriteString
	jmp ending

Finish:
	mov edx, OFFSET powerOfTwoStr
	call WriteString
ending:



	ret
isPowerOfTwo ENDP

END main