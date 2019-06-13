TITLE	RANDOM STRINGS
; Generates a random string of length L
; containing all capital letters. Pass the value of L in EAX
; and pass a pointer to an array of byte that will
; hold the random string. call procedure 20 times and display
; strings in console window

INCLUDE Irvine32.inc
.data
randomArray		BYTE 20 DUP (?),0

.code
main PROC
	mov		eax,20					; Length of array
	call	Randomize				; Seed RNG
	mov		esi,OFFSET randomArray	; Pass pointer to array
	mov		edx,OFFSET randomArray	; Load edx for writestring
	mov		ecx,eax					; Pass length to ecx
	L1:
		push	ecx				; Save original loop counter
		push	esi				; Save original location to overwrite
		call	RandomString	; Fill specified array with uppercase letters
		call	WriteString		; Display random string
		call	Crlf			; Make output look prettier
		pop		esi				; Restore original location
		pop		ecx				; Save original loop counter
		Loop L1					;

exit
main ENDP

;---------------------------------------------------;
RandomString PROC									;
;													;
;	Description:	Fills a byte array with random	;
;				Uppercase letters, length passed	;
;				from eax to ecx for looping			;
;---------------------------------------------------;

	push	eax		; Saves value of length for future looping
	mov		ecx,eax	; Gets length of array for loop
	L1:
		mov		eax,26		; Range of A-Z
		call	RandomRange	; random# between 0 and eax
		add		eax,65		; Make into capital
		mov		[esi],al	; Move result into location of esi
		inc		esi			; Move to next location
		Loop L1				;
	pop		eax		; Restore value of array length
	ret	
RandomString ENDP
END main