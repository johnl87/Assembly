INCLUDE Irvine32.inc
	TITLE Assignment8 (Assignment8LeJohn.asm)

	COMMENT #
		John Le COSC 2406 22SS Assignment 8
		August 04, 2022
		Program: creating a menu that presents the user with options to populate array, rotate array, divide the array, and printing the array

	#
.data
	array1 SWORD 10 DUP (12345)
	prompt1 BYTE "  Please select from the following options listed above by entering 1 - 5: " , 0
	op1 BYTE " 1 - Populate array with random numbers " , 0
	op2 BYTE " 2 - Rotate the array value bits a specified number of positions " , 0
	op3 BYTE " 3 - Divide the array with a user provided divisor " , 0
	op4 BYTE " 4 - Print the array " , 0
	op5 BYTE " 5 - Exit " , 0

	rotateBits BYTE "Please specify number of bits to rotate. negative for rotate left and positive for rotate right:  " , 0
	divisorUser BYTE "Please enter a divisor: " , 0

	option1Done BYTE "The array has been populated! " , 0
	option2Done BYTE "The array has been rotated! " , 0
	option3Done BYTE "The array elements has been divided! " , 0

	count DWORD ?
	shiftVal DWORD ?
	divisor DWORD ?
.code

main PROC

menu:
	call randomize						;calling randomize for random numbers
	call CrLf
	mov edx, OFFSET op1					;printing out option1 - populateRandomNum proc
	call WriteString
	call CrLf

	mov edx, OFFSET op2					;printing out option2 - rotateArray Proc
	call WriteString
	call CrLf

	mov edx, OFFSET op3					;printing out option3 - dividingArray proc
	call WriteString
	call CrLf

	mov edx, OFFSET op4					;printing out option4 - printing the array
	call WriteString
	call CrLf

	mov edx, OFFSET op5					;printing out option5 - exiting the program
	call WriteString
	call CrLf

	mov edx, OFFSET prompt1
	call WriteString
	call ReadDec

	call CrLf
										;eax compares to 1 to 5, if any number matches it will jump to the corresponding option
	cmp eax, 1							;else, the menu will appear again until a number between 1 - 5 is entered by the user
	je option1

	cmp eax, 2
	je option2

	cmp eax, 3
	je option3

	cmp eax, 4
	je option4

	cmp eax, 5
	je option5

	jmp menu							;shows menu again if 1 - 5 is not entered


option1:								;random numbers range: -1000 - +3000

	push OFFSET array1 					;ebp + 12 second param
	push LENGTHOF array1 				;ebp + 8  first param
	call populateRandomNum
	mov edx, OFFSET option1Done			;text to indicate option is finished
	call WriteString
	call CrLf

	jmp menu							;jumps back to display menu

option2:
	
	mov edx, OFFSET rotateBits
	call WriteString
	call ReadInt
	mov shiftVal, eax

	push OFFSET array1					;ebp + 16
	push LENGTHOF array1				;ebp + 12
	push shiftVal						;ebp + 8
	call rotateArray
	mov edx, OFFSET option2Done			;text to indicate option is finished
	call WriteString
	call CrLf

	jmp menu							;jumps back to display menu

option3:	

	mov edx, OFFSET divisorUser			;asking for divisor 
	call WriteString
	call ReadInt
	mov divisor, eax					;getting the user value and setting to variable called divisor

	push divisor						;pushing divisor onto stack - ebp + 12
	push OFFSET array1					;pushing offset onto stack - ebp + 8
	call dividingArray

	mov edx, OFFSET option3Done			;text to indicate option is finished
	call WriteString
	call CrLf

	jmp menu							;jumps back to display menu

option4:								;printing array

	printArray proto
	mov esi, OFFSET array1
	mov ecx, LENGTHOF array1 - 1
	invoke printArray
	call CrLf
	jmp menu							;jumps back to display menu

option5:								;exiting

	exit
	main ENDP
 
;*********************************************************
populateRandomNum PROC
;Receives: offset of array and number of elements in array
;Returns: nothing
;*********************************************************
	push ebp							;push ebp onto stack
	mov ebp, esp						;set ebp = esp
	push eax							;push eax onto stack
	mov esi, [ebp + 12]					;offset of array1
	mov ecx, [ebp + 8]					;length of array1
L1:

	call randomNumber					;call randomNumber proc to fill array
	mov [esi], eax						;esi points to current index of array
	add esi, 2							;advancing the pointer to next index 
	loop L1								;end of loop
	pop eax								;pop eax off stack
	pop ebp								;pop ebp off stack
	ret 8								;pop/remove the two parameters pushed onto stack
populateRandomNum ENDP

;*********************************************************
rotateArray PROC
;Receives: shiftVal = shift value, OFFSET array, number of elements
;Returns: array will contain answer, nothing returns back.
;*********************************************************
	push ebp
	mov ebp, esp
	mov cl, [ebp + 8]					;cl contains the shift value
	cmp eax, 0							;checking user entered value in eax to 0
	jg positive							;jump to positive label is eax > 0

	mov esi, [ebp + 16]					;setting esi to offset of array1
	mov ecx, [ebp + 12]					;setting outer loop to length of array1
L1: push ecx							;save loop counter
	
	mov eax, [esi + TYPE WORD]			
	shld [esi], eax, cl					;shifting eax into high bits of [esi] and shifts left due to negative number

	add esi, 2							;points to next two elements
	pop ecx				
	loop L1
	jmp ending

positive:
	mov esi, [ebp + 16]					;setting esi to offset of array1
	mov ecx, [ebp + 12]					;setting outer loop to length of array1
L2: push ecx							;save loop counter
	
	mov eax, [esi + TYPE WORD]
	shrd [esi], eax, cl					;shifts to the right due to positive
	add esi, 2	
	pop ecx								;restore loop counter
	loop L2

	pop ebp
ending:	ret
rotateArray ENDP

;*********************************************************
dividingArray PROC
;Receives: OFFSET of array and divisor
;Returns: nothing, answer will be saved onto array
;*********************************************************
	enter 4, 0
	push ebx							;pushing ebx, esi, ecx onto stack
	push esi
	push ecx
	mov bx, [ebp + 12]					;setting bl to 
	mov esi, [ebp + 8]					;setting esi = offset of array1
	mov ecx, 10							;looping 10 times for 10 elements
L1:	
	mov ax, [esi]						;setting value at pointer to ax
	cwd									;converting word to DWORD
	idiv bx								;dividing value in ax by bx (user entered divisor)
	mov [esi], ax						;moving the divided value (quotient) in ax back to index at esi
	add esi, 2							;advancing esi to next index by adding 2

	loop L1

	pop ecx								;popping ecx, esi, ebx off stack
	pop esi
	pop ebx
	leave
	ret
dividingArray ENDP

;*********************************************************
printArray PROC
;Receives: ecx = length of array1, esi = offset of array1
;Returns: nothing, just prints the elements in array1
;*********************************************************
	push esi							;pushing esi, ecx, eax onto stack
	push ecx
	push eax
	mov al, '<'							;printing the opening < 
	call WriteChar
	mov eax, 0

L1:
	movsx eax, WORD PTR [esi]			;setting eax to esi
	call WriteInt						;printing the value at esi
	mov al, ','							;printing comma after value
	call WriteChar
	add esi, TYPE WORD					;incrementing esi by 2 because it is WORD type
	loop L1

	movsx eax, WORD PTR [esi]			;printing last element without comma following it
	call WriteInt

	mov al, '>'							;printing the closing >
	call WriteChar
	pop eax								;popping eax, ecx, esi from stack
	pop ecx
	pop esi
	ret
printArray ENDP

;*********************************************************
randomNumber PROC
;Receives: nothing
;Returns: eax = random nuumber
;*********************************************************
	mov eax, 3000						;high range
	mov ebx, -1000						;low range
	sub eax, ebx						;(high - low + 1)
	inc eax								;low + (int)(Math.random() * (high - low + 1))
	call RandomRange 					;calling RandomRange
	add eax, ebx						;random number is in eax
	ret
randomNumber ENDP

END main