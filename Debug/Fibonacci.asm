TITLE Fibonacci(Fibonacci.asm)

; Description:	 Recursive Fibonacci number calculator
; Author:		 Ted Mader
; Revision date: 11/13/2014

INCLUDE Irvine32.inc

.code
fib PROC
	push	ebp				; save base pointer
	mov		ebp,esp			; set EBP to beginning of current stack frame
	sub		esp,4			; create space for storing fib(n - 1)
	mov		eax,[ebp+8]		; retrieve n from stack and load into EAX
	cmp		eax,0			; check if EAX equals 0
	je		finish			; if EAX equals 0 return n
	cmp		eax,1			; check if EAX equals 1
	je		finish			; if EAX equals 1 return n
	dec		eax				; n - 1
	push	eax				; fib(n - 1)
	call	fib				; get fib(n - 1)
	mov		[ebp-4],eax		; store fib(n - 1)
	dec		dword ptr[esp]	; decrement (n - 1) on the stack to get fib(n - 2)
	call	fib				; get fib(n - 2)
	add		esp,4			; move ESP up
	add		eax,[ebp-4]		; add fib(n - 1) and fib(n - 2)
finish:
	mov		esp,ebp			; move ESP to EBP
	pop		ebp				; return EAX
	ret
fib ENDP

main PROC
	push	3				; push 3 to the stack
	call	fib				; calculate fib(n), n = 3
	add		esp,4			; move ESP up
	call	WriteDec		; write result the console window
	call	Crlf			; write an end-of-line sequence to the console window
	exit
main ENDP
END main