INCLUDE Irvine32.inc
	

	COMMENT #
	John Le COSC 2406 22SF Assignment 5 question 1 
	program: asking user input for the name of the file to be opened. Using the readfromfile function to read first byte
	into a varaible and the next mytes into the letters and index array. 
	#
.data
	prompt1 BYTE "Please type in the name of the data file" , 0Dh, 0Ah, 0
	letters BYTE 256 DUP (0)
	index BYTE 256 DUP (?)
	filename BYTE ?
	msgLength DWORD ?
	fileHandle DWORD ?
.code

main PROC

	mov edx, OFFSET prompt1				;moves prompt1 to edx
	call WriteString					;displays to user to enter name of data file




	mov edx, OFFSET letters				;moves letters to edx
	mov ecx, LENGTHOF letters - 1		;set ecx to the length of letters - 1 to remove null terminator	
	call ReadString						;readstring to take in the user input
	mov DWORD PTR filename, eax			;moving the length from readstring to index array

	mov edx, OFFSET filename			
	call OpenInputFile					;opening file from user input
	mov fileHandle, eax					;creating fileHandle and saving it 
	
	mov eax, fileHandle					;an open file handle
	mov edx, OFFSET msgLength			;offset of input buffer msgLength
	mov ecx, LENGTHOF letters - 1		;max number of bytes to read
	call ReadFromFile
	mov msgLength, eax

	mov eax, fileHandle					;an open file handle
	mov edx, OFFSET msgLength			;offset of input buffer msgLength
	mov ecx, LENGTHOF letters - 1		;max number of bytes to read
	call ReadFromFile

	mov eax, fileHandle					;an open file handle
	mov edx, OFFSET msgLength			;offset of input buffer msgLength
	mov ecx, LENGTHOF letters - 1		;max number of bytes to read
	call ReadFromFile




	mov msgLength, eax
	call ReadFromFile






	mov eax, fileHandle					;closing file
	call CloseFile







	exit
	main ENDP
END main