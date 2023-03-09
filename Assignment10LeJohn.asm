INCLUDE Irvine32.inc

sumColumnOfArray PROTO arrayPTR: PTR SWORD, rows: DWORD, cols: DWORD, userCol: DWORD


	COMMENT #
	John Le COSC 2407 22SS
	Assignment 10
	August 11th, 2022
	Program: 2D array. Fill array with random numbers, print array and then sum the desired column of array.
	#
.data
	NUM_ROWS = 3
	NUM_COLS = 3
	myArray SWORD 9 DUP(0)
	colPrompt BYTE "Please enter a colmun number to add: " , 0
	colTotal  BYTE "The total is: " , 0
	userColumn DWORD ?
.code

main PROC
	call randomize
	call populateArray

	push OFFSET myArray						;[ebp + 16]
	push NUM_ROWS							;[ebp + 12]
	push NUM_COLS							;[ebp + 8]
	call printArray
	call CrLf
	mov edx, OFFSET colPrompt
	call WriteString
	call ReadDec							;only positive column number, reading user input into eax
	mov userColumn, eax						;placing eax into userColumn
	
	INVOKE  sumColumnOfArray, OFFSET myArray, NUM_ROWS, NUM_COLS, userColumn 
	mov edx, OFFSET colTotal				;asking user for column number to add
	call Writestring
	call WriteInt
	



	exit
	main ENDP
;***********************************************************************************
populateArray PROC
;RECEIVES: no stack parameters, just uses variables from memory
;RETURNS: nothing
;***********************************************************************************
	push ebp
	mov ebp, esp
	mov esi, 0								;setting esi = 0
	mov ecx, NUM_ROWS						;outer loops based on row number
L1:
	push ecx								;saving ecx outer loop counter
	mov edi, 0
	mov ecx, NUM_COLS						;setting inner loop counter to cols

L2:
	call random								;call random proc to place random value into eax, and putting ax value into array pointed at [esi + edi]
	mov (TYPE myArray) PTR myArray[esi + edi], ax
	add edi, TYPE myArray					;incremenets the col/edi pointer to next element in same row

	loop L2
	call CrLf
	add esi, edi							;advances the row pointer to the next row after the inner loop finishes
	pop ecx
	loop L1


	pop ebp
	ret
populateArray ENDP

;***********************************************************************************
printArray PROC
;RECEIVES: stack parameters: offset myArray, NUM_ROWS, and NUM_COLS
;RETURNS: nothing
;***********************************************************************************
	push ebp
	mov ebp, esp
	mov ecx, [ebp + 12]						;NUM_ROWS
	mov esi, [ebp + 16]						;offset of myArray
L1:
	mov edi, 0
	push ecx
	mov al, '|'								;placing pipe at start of array row
	call WriteChar
	mov ecx, [ebp + 8]						;NUM_COLS
L2:
	movsx eax, WORD PTR [esi + edi]			;base-index 
	call WriteInt							;printing signed int
	mov al, ','								;printing comma
	call WriteChar
	add edi, TYPE SWORD						;advancing edi to next element in row
	
	loop L2
	mov al, '|'								;placing pipe at end of array row
	call WriteChar
	call CrLf
	pop ecx
	add esi, edi							;advancing to next row after inner loop finishes
	loop L1

	pop ebp
	ret 12
printArray ENDP

;***********************************************************************************
sumColumnOfArray PROC,
	arrayPTR: PTR SWORD,
	rows: DWORD,
	cols: DWORD,
	userCol: DWORD
;RECEIVES: offset myArray, NUM_ROWS, NUM_COLS, and column index from user
;RETURNS: total in eax
;***********************************************************************************

LOCAL total: DWORD						

	mov total, 0							;sum accumulator
	mov esi, arrayPTR						;offset of myArray
	mov ecx, rows							;rows variable
L1:
	push ecx
	mov edi, userCol
	mov ecx, cols
L2:
	movsx eax, WORD PTR [esi + edi * TYPE myArray]
	add total, eax							;moving value from array into eax, then adding eax to total
	loop L2

	pop ecx
	add esi, edi							;advancing to next row
	loop L1
	mov eax, 0
	mov eax, total							;placing total into eax

	ret 
sumColumnOfArray ENDP 

;*********************************************************
random PROC
;Receives: nothing
;Returns: eax = random nuumber
;*********************************************************
	mov eax, 125							;high range
	mov ebx, -125							;low range
	sub eax, ebx							;(high - low + 1)
	inc eax									;low + (int)(Math.random() * (high - low + 1))
	call RandomRange 						;calling RandomRange
	add eax, ebx							;random number is in eax
	ret
random ENDP

END main