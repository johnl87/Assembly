INCLUDE Irvine32.inc

.data

prompt1 BYTE "Enter 5 integers for array: " , 0
prompt2 BYTE "enter the next integer: " , 0

array SDWORD 5 DUP(?)
comma BYTE ", " , 0


.code
main PROC
	;getting user input into array

	MOV EDX, OFFSET prompt1
	CALL WriteString
	CALL ReadInt
	MOV array[4*0], EAX
	

	MOV EDX, OFFSET prompt2
	CALL WriteString
	CALL ReadInt
	MOV array[4*1], EAX

	MOV EDX, OFFSET prompt2
	CALL WriteString
	CALL ReadInt
	MOV array[4*2], EAX

	MOV EDX, OFFSET prompt2
	CALL WriteString
	CALL ReadInt
	MOV array[4*3], EAX

	MOV EDX, OFFSET prompt2
	CALL WriteString
	CALL ReadInt
	MOV array[4*4], EAX

	;outputting array ------------------------------------------------

	MOV EAX, array[4*0]
	CALL WriteInt
	

	MOV EAX, array[4*1]
	MOV EDX, OFFSET comma
	CALL WriteString
	CALL WriteInt

	MOV EAX, array[4*2]
	MOV EDX, OFFSET comma
	CALL WriteString
	CALL WriteInt


	MOV EAX, array[4*3]
	MOV EDX, OFFSET comma
	CALL WriteString
	CALL WriteInt


	MOV EAX, array[4*4]
	MOV EDX, OFFSET comma
	CALL WriteString
	CALL WriteInt

	exit
	main ENDP
end main

