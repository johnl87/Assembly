INCLUDE Irvine32.inc

TITLE Assignment6 (Assignment6LeJohn.asm)

	COMMENT #
	John Le, COSC 2406 22SS
	Assignment 6, July 26th 2022
	Program: create a isLetter procedure to determine if character inside al is a letter or not
	#


.data
	prompt1	BYTE "Please enter the file name you wish to open: " , 0
	countStr BYTE "count of ", 0
	errorStr BYTE "The file was not opened successfully - invalid handle value. " , 0

	array BYTE 62 DUP (?)

	BUFFER_SIZE = 5000
	buffer BYTE 50 DUP (?)
	byteCount DWORD ?

	startingNum BYTE '0', 0
	lowerCaseAlphabet BYTE 'a' , 0
	upperCaseAlphabet BYTE 'A' , 0
	alphabetCount = 26
.code

main PROC

	mov edx, OFFSET prompt1				;asking user for name of file to open
	call WriteString					;displaying prompt1

	mov edx, OFFSET buffer				
	mov ecx, SIZEOF buffer
	call ReadString						;collecting user input
	mov edx, eax						;moving user input stored in eax to edx
	call OpenInputFile					;calling OpenInputFile to open the named file
	cmp eax, -1							;invalid file handle = -1 if eax is <= -1, jump to invalidHandle label and print an error message
	jng invalidHandle					;if eax = invalid_handle_value then file was not opened else eax = handle for open file

	mov edx, OFFSET buffer				;points to buffer
	mov ecx, BUFFER_SIZE				;max bytes to read 
	call ReadFromFile					;reading from the specified file
	mov byteCount, eax					;count of bytes that were used to read from file

	mov ebx, LENGTHOF byteCount
	mov esi, OFFSET array				;setting esi pointer to start of array to store count
	mov ecx, byteCount					;setting loop counter for processing the characters using bufferCount.
	call bufferCount					;calling the bufferCount procedure



	call CrLf
	mov ecx, 10							;setting loop counter = 10 to print 0 - 9
	call printResultsNum

	mov ecx, alphabetCount				;setting loop counter = 26 to print lower case letters a - z
	call printResultsLower

	mov ecx, alphabetCount				;setting loop counter = 26 to print upper case letters A - Z
	call printResultsUpper
invalidHandle:
	mov edx, OFFSET errorStr
	call WriteString
	exit
	main ENDP

;********************************************************************
isLetter PROC
;Determines if the character in al register is a valid letter
;receives: al = character
;returns: zf = 1 if al is a letter, else returns zf = 0
;********************************************************************
	cmp al, 'a'							;comparing character inside al to 'a'. Ideally want al >= 'a' and al <= 'z'
	jb next								;zf = 0 when jumping 
	cmp al, 'z'							;comparing character within al to 'z'
	ja next								;if al greater than 'z', jump to IL1 and return zf = 0
	test ax, 0							;setting zf = 1
	jmp IL1								;skipping over next label

next:									;next label serving as an "or" 
	cmp al, 'A'							;comparing al to 'A'. ideally want al >= 'A' and al <= 'Z'
	jb IL1								;zf = 0
	cmp al, 'Z'							;comparing al to 'Z'
	ja IL1								;if al greater than 'Z', jump to IL1 and return zf = 0
	test ax,0							;setting zf = 1
IL1:									;is Letter 1 label
	ret
isLetter ENDP

;********************************************************************
printResultsNum PROC
;Determines if the character in al register is a valid letter
;receives: ecx = buffer size, 
;returns: nothing, just prints the count of numbers.
;********************************************************************
	pushfd								;push all flags
	pushad								;push all registers
L1:
	mov edx, OFFSET countStr			;setting edx to have the string "count of"
	call WriteString
	mov al, startingNum					;setting al to 0
	call WriteChar						;writing out 0 to output after the countStr
	mov al, ' '
	call WriteChar						;adding a space
	mov al, '='							;adding an equal sign
	call WriteChar
	inc startingNum						;incrementing the ascii value of 0 to get 1..2..3... after each inc
	call CrLf
	loop L1
	popad								;pop all registers
	popfd								;pop all flags
	ret
printResultsNum ENDP

;********************************************************************
printResultsLower PROC
;Determines if the character in al register is a valid letter
;receives: ecx, 
;returns: nothing, just prints the count of lowercase letters.
;********************************************************************
	pushfd								;push all flags
	pushad								;push all registers
L1:
	mov edx, OFFSET countStr			;setting edx to have the string "count of"
	call WriteString
	mov al, lowerCaseAlphabet			;setting al to 'a'
	call WriteChar
	mov al, ' '
	call WriteChar
	mov al, '='
	call WriteChar
	inc lowerCaseAlphabet				;incrementing the ascii value of a to get b,c,d...z after each inc
	call CrLf
	loop L1
	popad								;pop all registers
	popfd								;pop all flags
	ret
printResultsLower ENDP

;********************************************************************
printResultsUpper PROC
;Determines if the character in al register is a valid letter
;receives: ecx, 
;returns: nothing, just prints the count of uppercase letters.
;********************************************************************
	pushfd								;push all flags
	pushad								;push all registers
L1:
	mov edx, OFFSET countStr			;setting edx to have the string "count of"
	call WriteString
	mov al, upperCaseAlphabet			;setting al to 'A'
	call WriteChar
	mov al, ' '
	call WriteChar
	mov al, '='
	call WriteChar
	inc upperCaseAlphabet				;incrementing the ascii value of A to get B,C,D...Z after each inc
	call CrLf
	loop L1
	popad								;pop all registers
	popfd								;pop all flags
	ret
printResultsUpper ENDP

;********************************************************************
bufferCount PROC 
;counts the occurance of letters and numbers and returns count in array
;receives: ecx, esi, 
;returns: count in array.
;********************************************************************

outerLoop:								;outer loop sets the current character to be searched for in the buffer. 
	cmp ecx, 0							;comparing loop counter to types of distincy characters. 62 due to 10 digits, and 26 lowercase and 26 uppercase
	jecxz complete						;jump out of loop once ecx = 0
	mov eax, 0							;setting occurance = 0
	mov ebx, 62							;setting inner loop counter = 62
innerLoop:								;inner loop serves as looping through the buffer, finding the same letter being search and increasing the count(eax) for each occurance
	


	cmp ebx, 0							;once ebx = 0, we finish the inner loop
	je finishInner						;once ebx = 0, the inner loop is finished and one count of outer loop is done
	dec ebx								;since inner loop isn't finished, we dec ebx by 1 and continue the inner loop
	jmp innerLoop						;restarts the inner loop, but ebx = ebx - 1
finishInner:
	
	dec ecx								;dec ecx by 1 until ecx 0 to exit from outerloop completely
	jmp outerLoop						;since we are still in outer loop, we jump back to begin again but with ecx = ecx - 1



complete: ret
bufferCount ENDP


;********************************************************************
isDigit1 PROC
;Determines if the character in al register is a valid letter
;receives: al = character
;returns: zf = 1 if al is a digit, else returns zf = 0
;********************************************************************
	cmp al, '0'							;compares al to '0'
	jb ID1								;if al is less than 0, jump to ID1 and zf = 0
	cmp al, '9'							;if al is > '9', zf = 0;
	ja ID1					
	test ax, 0							;setting zf = 1
ID1: ret	
isDigit1 ENDP


END main