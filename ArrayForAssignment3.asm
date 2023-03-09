INCLUDE Irvine32.inc

COMMENT !
	
	John Le COSC 2406 Assignment 3 part 2
	Due: July 12, 2022
	Program: Asks user for 4 integer inputs into word array. Then taking the 1st and 3rd element and adding it. 
	Taking the 2nd and 4th elment and subtracting then displaying the sum and difference of the selected elements.
!



.data

prompt1 BYTE "Enter 4 integers for array in the range of 0 - 65535: " , 0
prompt2 BYTE "enter the next integer: " , 0
prompt3 BYTE "Adding the first and third element: " , 0
prompt4 BYTE "Subtracting the second and fourth element: " , 0

array WORD 4 DUP(?)

resultAdding WORD ?
resultSubstracting WORD ?

.code
main PROC
	;getting user input into array

	MOV EDX, OFFSET prompt1				;First input into array
	CALL WriteString
	CALL ReadInt
	MOV array[2*0], AX
	

	MOV EDX, OFFSET prompt2				;Second input into array
	CALL WriteString
	CALL ReadInt
	MOV array[2*1], AX

	MOV EDX, OFFSET prompt2				;Third input into array
	CALL WriteString
	CALL ReadInt
	MOV array[2*2], AX

	MOV EDX, OFFSET prompt2				;Fourth input into array
	CALL WriteString
	CALL ReadInt
	MOV array[2*3], AX


	;Calculating array ------------------------------------------------
	MOV EDX, OFFSET prompt3				;String that prints adding 1st and 3rd element of array
	CALL WriteString					
	MOV AX, array[2*0]					;taking the first element and moving it into AX
	ADD AX, array[2*2]					;taking the third element and adding it into AX
	MOV resultAdding, AX				;taking the sum of 1st and 3rd element and placing it into resultAdding 
	CALL WriteDec						;Printing the sum in unsigned integer, hex, and binary
	CALL CrLf
	CALL WriteHex
	CALL CrLf
	CALL WriteBin
	CALL CrLf

	CALL CrLf
	MOV EDX, OFFSET prompt4				;String that prints the difference of 2nd and 4th element of array
	CALL WriteString
	MOV AX, array[2*1]					;taking the second element and moving it into AX
	SUB AX, array[2*3]					;taking the fourth element and subtracting it into AX
	MOV resultSubstracting, AX			;taking the difference of 2nd and 4th element and placing it into resultSubtracting
	CALL WriteDec						;Printing the difference in unsigned integer, hex, and binary
	CALL CrLf
	CALL WriteHex
	CALL CrLf
	CALL WriteBin
	CALL CrLf

	exit
	main ENDP
end main

 