

;Deniz Burak


INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	
	vDonem BYTE "Deniz Burak",0
	vOdev BYTE "Assembler",0
	vName BYTE "Deniz",0
	vPropmt BYTE"INPUT:",0

		   vArray		BYTE "January ",0,"   "
                        BYTE "February ",0,"  "
                        BYTE "March ",0,"     "
                        BYTE "April ",0,"     "
                        BYTE "May ",0,"       "
                        BYTE "June ",0,"      "
                        BYTE "July ",0,"      "
                        BYTE "August ",0,"    "
                        BYTE "September ",0," "
                        BYTE "October ",0,"   "
                        BYTE "November ",0,"  "
                        BYTE "December ",0,"  "

		   vTh BYTE "th, ",0
           vSt BYTE "st, ",0
           vNd BYTE "nd, ",0
           vRd BYTE "rd, ",0

		   ;vDays"stndrdthththththththththththththththththstndrdthththththththth",0

           vDay BYTE "--",0
           vYear BYTE "----",0

.code
main PROC

call clrscr


		mov dh, 4
		mov dl, 33
		call Gotoxy

		mov edx, OFFSET vSemester
		call writeString

	
		mov dh, 5
		mov dl, 33
		call Gotoxy

		mov edx, OFFSET vAssignment
		call writeString

	
		mov dh, 6
		mov dl, 33
		call Gotoxy

		mov edx, OFFSET vName
		call writeString


		mov dh, 8
		mov dl, 33
		call Gotoxy

		mov edx, OFFSET vPropmt
		call writeString


		; little endian format

    call ReadHex
    ror ax, 8
    mov ebx, eax

	    mov dh, 10
		mov dl, 33
		call Gotoxy
		call writestring




    and ax, 0000000111100000b
    shr ax, 5

    mov edx, offset [vArray]
    sub eax, 1
    mov cl, 12
    mul cl
    add edx, eax

	 call WriteString




    mov eax, ebx
	
    and ax, 0000000000011111b
	mov cx, ax
	mov bl, 10
	div bl
	add ax, 3030h
	mov word ptr [vDay], ax
	mov edx, offset [vDay]

	
	call writeString
 
	
	  
   cmp cx, 00000b
   jz TheEnd

   cmp cx, 00001b
   jz dSt

   cmp cx, 00010b
   jz dNd

   cmp cx, 00011b
   jz dRd

   cmp cx, 10101b
   jz dSt

   cmp cx, 10110b
   jz dNd

   cmp cx, 10111b
   jz dRd

   cmp cx, 11111b
   jz dSt

   mov edx, offset [vTh]
   jmp Display

   dSt:
		mov edx, offset [vSt]
		jmp Display
	
   dNd:
		mov edx, offset [vNd]
		jmp Display
   
   dRd:
		mov edx, offset [vRd]
		jmp Display


Display:
call writeString




mov eax, ebx

and ax, 1111111000000000b
shr ax, 9

add ax, 1980
cmp eax, 0
jz TheEnd

xor dx,dx
mov bx, 1000
div bx
add al, 30h

mov byte ptr [vYear],al
mov ax, dx
xor dx, dx

mov bx, 100
div bx
add al, 30h
mov byte ptr [vYear+1],al

mov ax, dx
xor dx, dx

mov bl, 10
div bl
add ax, 3030h
mov word ptr [vYear+2],ax
mov edx, offset [vYear]

call WriteString
    xor ecx, ecx
    call ReadChar

TheEnd:
    exit

main ENDP
END main