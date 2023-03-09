INCLUDE Irvine32.inc
	
	COMMENT #
	John Le
	August 7th, 2022
	COSC 2406 Assignment 9, Question 1
	program: calculating the properties of Rhombicosidodecahedron with given length, e
	#

.data
	prompt1 BYTE "Please enter the length of the edge of the Rhombicosidodecahedron: "
	e		REAL4 ?
	area	REAL4 ?
	vol		REAL4 ?
	msr		REAL4 ?
	junk	REAL4 ?
	two		DWORD 2
	three	DWORD 3
	four	DWORD 4
	five	DWORD 5
	ten		DWORD 10
	twenty5 DWORD 25
	twenty9 DWORD 29
	thirty	DWORD 30
	sixty	DWORD 60
	printArea BYTE "The area of the Rhombicosidodecahedron is: " , 0
	printVol  BYTE "The volume of the Rhombicosidodecahedron is: " , 0
	printMSR  BYTE "The MidSphere radius of the Rhombicosidodecahedron is: " , 0
.code

main PROC
	FINIT
askQuestion:
	mov edx, OFFSET prompt1				;displays prompt1
	call WriteString
	call ReadFloat

	FLDZ								;loads zero at ST(0); ST(1) = e
	FCOMP								;cmp ST(0), ST(1)
	FNSTSW AX							;transfers FPU flags to ALU
	SAHF								;store high byte ah into flag register

	jb useNum							;if zero is less than e, continue with program
	FFREE ST(0)							;clears top of stack
	jmp askQuestion						;if zero is greater than e, it indicates a negative number. 

useNum:

	FSTP e								;saves user value into e variable and pop off FPU stack

	FLD e								;loads e onto stack at ST(0)
	call calculateArea					

	mov edx, OFFSET printArea			;prints area string
	call WriteString
	call WriteFloat
	call CrLf
	FSTP area							;clears FPU stack by storing into area variable and popping off stack

	FLD e								;loads e onto stack at ST(0)
	call calculateVolume
	mov edx, OFFSET printVol			;prints volume string
	call WriteString
	call WriteFloat
	call CrLf
	FSTP vol							;clears FPU stack by storing into volume variable and popping off stack

	FLD e								;loads e onto stack at ST(0)
	call calculateMidSphereRadius
	mov edx, OFFSET printMSR			;prints MSR string
	call WriteString
	call WriteFloat
	call CrLf
	FSTP msr							;clears FPU stack by storing into MidSphereRadius variable and popping off stack

	call ShowFPUStack


	exit
	main ENDP
;*********************************************************
calculateArea PROC
;RECEIVES: the edge length (e) on the FPU stack
;RETURNS: value on the FPU stack
;*********************************************************
	FLD ST(0)							;loads first item in stack at ST(0), e => ST(0) = edge; ST(1) = edge
	FMUL								;e * e = e^2 = ST(0)

	FILD thirty							;ST(0) = 30; ST(1) = e^2
	FILD three							;ST(0) = 3; ST(1) = 30; ST(2) = e^2
	FSQRT								;sqrt ST(0) = sqrt(3)
	FIMUL five							;ST(0) = 5 * sqrt(3); ST(1) = 30; ST(2) = e^2
	FADD								;30 + 5 * sqrt(3) without popping; result will be at ST(0); ST(1) = e^2

	FILD five							;ST(0) = 5; ST(1) = 30 + 5 * sqrt(3); ST(2) = e^2
	FSQRT								;sqrt (ST(0))
	FIMUL ten							;ST(0) = 10* sqrt(5)
	FILD twenty5						;ST(0) = 25; ST(1) = 10 * sqrt(5); ST(2) = 30 + 5 * sqrt(3); ST(3) = e^2
	FADD								;ST(0) = 25 + 10*sqrt(5); ST(1) = 30 + 5 * sqrt(3); ST(2) = e^2
	FSQRT								;sqrt(25 + 10* sqrt(5))
	FIMUL three							;ST(0) = 3 * sqrt(25 + 10* sqrt(5)); ST(1) = 30 + 5 * sqrt(3); ST(2) = e^2

	FADD								;ST(0) = 3 * sqrt(25 + 10* sqrt(5)) + 30 + 5 * sqrt(3); ST(1) e^2

	FMUL
	ret
calculateArea ENDP

;*********************************************************
calculateVolume PROC
;RECEIVES: the edge length (e) on the FPU stack
;RETURNS: value on the FPU stack
;*********************************************************

	FLD ST(0)							;loads first item in stack at ST(0), e => ST(0) = edge; ST(1) = edge
	FLD ST(0)							;loads another e => ST(0) = e; ST(1) = e^2
	FMUL								;e * e = e^2 = ST(0)
	FMUL								;ST(0) = e^3
	FILD three							;ST(0) = 3;ST(1) = e^3
	FDIV								;ST(1)/ST(0) = e^3 / 3 = ST(0)

	FILD five							;ST(0) = 5; ST(1) = e^3 / 3 
	FSQRT								;ST(0) = sqrt(5); ST(1) = e^3 / 3 
	FIMUL twenty9						;ST(0) = 29 * sqrt(5); ST(1) = e^3 / 3 
	FILD sixty							;ST(0) = 60; ST(1) = 29 * sqrt(5); ST(2) = e^3 / 3 
	FADD								;ST(0) = 60 + 29 * sqrt(5); ST(1) = e^3 / 3
	FMUL								;ST(0) = e^3/3 * (60 + 29 * sqrt(5))
	ret
calculateVolume ENDP

;*********************************************************
calculateMidSphereRadius PROC
;RECEIVES: the edge length (e) on the FPU stack
;RETURNS: value on the FPU stack
;*********************************************************
	
	FILD two							;ST(0) = 2; ST(1) = e
	FDIV								;ST(0) = e/2								

	FILD five							;ST(0) = 5; ST(1) = e/2	
	FSQRT								;ST(0) = sqrt(5); ST(1) = e/2	
	FIMUL four							;ST(0) = 4 * sqrt(5); ST(1) = e/2	
	FILD ten							;ST(0) = 10;ST(1) = 4 * sqrt(5); ST(2) = e/2
	FADD								;ST(0)= 10 + 4 * sqrt(5); ST(1) = e/2
	FSQRT								;ST(0)= sqrt(10 + 4 * sqrt(5)); ST(1) = e/2
	FMUL								;ST(0)= sqrt(10 + 4 * sqrt(5)) * e/2

	ret
calculateMidSphereRadius ENDP
END main