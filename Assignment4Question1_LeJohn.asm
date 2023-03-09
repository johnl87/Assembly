INCLUDE Irvine32.inc

	COMMENT !
		John Le, COSC 2406 22SF
		Assignment 4 question 1
		July 17th, 2022
	!



.data
	
	prompt1 BYTE "The first 30 values of the number sequence: " , 0
	comma BYTE ", " , 0
	count1 DWORD 4
	count2 DWORD 4
.code

main PROC
	mov edx, OFFSET prompt1		;moving prompt to edx register
	call WriteString			;writing the string to output
	call CrLf					;creating a new line 


	mov eax, 1					;f(0) = 1
	call WriteDec				;writing value at eax to output
	mov edx, OFFSET comma		;placing the comma to the edx register
	call WriteString			;using the WriteString to print the comma from the edx register

	mov eax, 3					;f(1) = 3
	call WriteDec				;writing value at eax to output
	mov edx, OFFSET comma		;placing the comma to the edx register
	call WriteString			;using the WriteString to print the comma from the edx register

	mov eax, 2					;f(2) = 2
	call WriteDec				;writing value at eax to output
	mov edx, OFFSET comma		;placing the comma to the edx register
	call WriteString			;using the WriteString to print the comma from the edx register

	mov eax, 5					;f(3) = 5
	call WriteDec				;writing value at eax to output
	mov edx, OFFSET comma
	call WriteString

								
	mov ecx, 26					;setting loop to run 26 more times
	mov eax, count1				;setting eax equal to count1
		
L1:							
	sub eax, 1					;using the formula f(n-1) + 2*(n-4). Here count -1
	mov ebx, count2				;this is the second half of the formula (2n - 8)
	add ebx, count2				;count2 is moved to ebx, and add count again to double value inside ebx, then subtract by 8
	sub ebx, 8
	
	add eax, ebx				;add both eax and ebx (first and second half of the formula)
	call WriteDec				;output the value currently inside eax register
	mov edx, OFFSET comma		;calling the comma string with a null terminator
	call WriteString			;outputting the comma
	inc count1					;increment count1
	inc count2					;increment count2
	loop L1
	

	exit
	main ENDP
end main