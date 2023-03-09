INCLUDE Irvine32.inc
	COMMENT !
		John Le, COSC 2406 22SF
		Assignment 4 question 2
		July 17th, 2022
	!

.data

	comma byte "," , 0
	array WORD 20 DUP(?)		;creating an array of 20 spaces

.code

main PROC


	mov	esi, 0					;pointer set to index 0	
	mov	ecx, LENGTHOF array		;ecx is the counter variable for loop that will loop based on length of array
	mov	ax, 1					;ax is the sum variable that will be added with bx and placed into array
	mov	bx, 0					;bx set to 0. will be used to increment and add to ax


L1:								;start of loop 1
	
	mov	array[esi], ax			;adding value of ax into array at position esi = 0
	add	ax, bx					;adding both ax and bx
	inc bx						;incrementing bx
	inc bx						;incrementing bx
	inc ax						;incrementing ax
	add	esi, TYPE array			;increasing/moving esi pointer based on bytes of array. for word, it would be adding 2 to move to the next position
	loop L1						;end of loop

	mov ecx, LENGTHOF array - 1	;resetting the counter for second loop
	mov esi, OFFSET array 		;setting the pointer to array 0

	mov	al, '['					;moving start of square brackets to al reg
	CALL WriteChar				;calling WriteChar to print opening [ bracket
L2:								;start of second loop to display numbers within array
	movzx eax, WORD PTR [esi]	;assigning esi to word via PTR and then zero extension
	call WriteDec				;printing out the value stored in eax as decimal
	mov edx, OFFSET comma		;moving comma to edx reg
	call WriteString			;printing out comma following the printed number and with a space
	add	esi, TYPE array			;advancing esi pointer to the next index within array
	loop	L2					;end of printing loop
	
	movzx eax, WORD PTR [esi]	;printing out the last element without comma following it
	call WriteDec				;printing value to output

	MOV		al, ']'				;moving closing ] bracket to al reg
	CALL	WriteChar			;print closing ] bracket


	exit
	main ENDP
end main