INCLUDE Irvine32.inc
	COMMENT #
	John Le COSC 2406 22SF Assignment 5 question 2 part b
	program: asking user for character input, foreground/background color and printing out the character
	randomly via gotoxy function. Printing each character with a delay of 1/5th a second.

	#



.data
	prompt1 BYTE "Please enter a character to print: " , 0
	prompt2 BYTE "Please enter a starting foreground color for text (0 - 15): " , 0
	prompt3 BYTE "please enter a starting background color for text (0 - 15): " , 0

	prompt4 BYTE "Please enter a high value: " , 0Dh, 0Ah, 0
	prompt5 BYTE "Please enter a low value: " , 0Dh, 0Ah, 0
	
	bufferChar BYTE 1 DUP (?)
	userChar DWORD ?
	fgColor DWORD ?
	bgColor DWORD ?

	lowValue DWORD ?
	highValue DWORD ?
	rowNum BYTE ?
	colNum BYTE ?
.code

main PROC

	mov edx, OFFSET prompt1				;asking user for character
	call WriteString
	mov edx, OFFSET bufferChar			;setting edx to buffer
	mov ecx, SIZEOF bufferChar			;setting max number of characters
	call ReadString						;calling for string input and reading it
	mov userChar, eax					;moving the read string to userChar

	mov edx, OFFSET prompt2				;asking user for foreground color
	call WriteString
	call ReadDec
	mov fgColor, eax

	mov edx, OFFSET prompt2				;asking user for background color
	call WriteString
	call ReadDec
	mov bgColor, eax
	
	mov ecx, 16							;loop to take background color multiply by 16 via looping 16 times
	mov eax, 0
L1:
	add eax, bgColor					;adding bg color 16 times
	loop L1

	add eax, fgColor					;adding fg color
	mov edx, OFFSET userChar			;setting edx to offset of Character

	


	mov eax, 0							;setting eax to 0

	call BetterRandomRange				;calling BetterRandomRange Proc
	mov rowNum, al						;setting al to row num for dh
	mov dh, rowNum
	call BetterRandomRange
	mov colNum, al						;setting al to colNum for dl
	mov dl, colNum
	call Gotoxy							;calling the Gotoxy function
	mov ecx, 512						;setting loop counter to 512
L2:										;loop to print the random character
	
	call SetTextColor					;calling setTextcolor
	call WriteChar						;printing the Character
	mov eax, 200						;calling delay at 1/5th of a second
	call Delay
	push eax							;pushing eax onto stack
	inc eax								;incrementing eax for color change
	pop eax								;popping eax off stack
	loop L2								;end of loop

	
	exit
	main ENDP




;****************************************************
;Receives user input for high and low range values
;returns a value in the EAX register
;****************************************************
BetterRandomRange PROC USES ebx

	call Randomize
	mov edx, OFFSET prompt4
	call WriteString
	call ReadInt
	mov highValue, eax

	mov edx, OFFSET prompt5
	call WriteString
	call ReadInt
	mov lowValue, eax


	mov eax, highValue
	mov ebx, lowValue



	sub eax, ebx				;(high - low + 1)
	inc eax
	
	call RandomRange 
	add eax, ebx

	call WriteInt

	ret
BetterRandomRange ENDP



END main