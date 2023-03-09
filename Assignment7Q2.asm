INCLUDE Irvine32.inc

	TITLE Assignment 7 Question 2 (Assignment7Q2.asm)

	COMMENT #
	John Le, COSC 2406 22SS
	Assignment 7 question 2, July 30th 2022
	Program: create a program to print out prime numbers from 1 to 1000.

	CITATIONS:
	Irvine, K. (2014). Assembly Language for x86 Processors (7th ed.) Pearson.
	Liang, D. (2018). Introduction to Java Programming and Data Structures ( 11th ed., pp.882)
	Green, A. (2013, September 21). How to create nested loops in x86 assembly language [Forum post]. Stack Overflow. https://stackoverflow.com/q/15995696
	#

.data
	primeStr BYTE "The prime numbers from 2 to 1000 is: " , 0

	arrayPrime BYTE 1000 DUP (1)
	number DWORD 1
	n DWORD 1000
.code

main PROC
	mov edx, OFFSET primeStr			;offset string saying prime numbers 2 to 1000
	call WriteString					;calling WriteString 
	call CrLf

	call isPrimeNum						;calling isPrimeNum proc to set i * k values = false
	mov eax, 2		
	mov esi, OFFSET arrayPrime			;setting esi to point to arrayPrime
beginWhile:								;start of while loop 
	cmp eax, 1000						;if not (2 < 1000)
	jnl endWhile						;escapes while loop once conditions becomes false
	cmp esi, 1							;comparing esi pointer at array to 1, if 1, write value of eax
	jne L1								;jumping to L1 is value at esi pointer doesn't equal 1/true
	call WriteInt						;writing value of eax
	mov al, ' '							;printing spaces between each value
	call WriteChar
L1:	
	inc eax								;incrementing eax (k)
	inc esi								;advancing esi pointer to next element in array
	jmp beginWhile						;jump back to start of while loop

endWhile:

	exit
	main ENDP
;********************************************************************
isPrimeNum PROC USES ecx ebx eax
;receives: ecx = k, 
;returns: nothing, just sets the arrayPrime to false when i * k
;********************************************************************
	mov ecx, 2							;k = 2

forLoop1:
	cmp ecx, 500						;k <= 1000/2 
	je done
	mov ebx, ecx						;i = k
forLoop2:
	mov eax, ecx						;moving k to eax
	mul ebx								;multiplying k * i
	mov arrayPrime[eax], 0				;setting array at i * k =0 /false
	cmp ebx, 500						;i <= 500
	jz forLoop2Done
	inc ebx								;incrementing ebx
	jmp forLoop2

forLoop2Done:
	inc ecx								;k++
	jmp forLoop1						;jumps back to outer loop


done:

	ret
isPrimeNum ENDP


END main