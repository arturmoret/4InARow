.586
.MODEL FLAT, C


; Functions defined in C
printChar_C PROTO C, value:SDWORD
gotoxy_C PROTO C, value:SDWORD, value1: SDWORD
getch_C PROTO C


; Subroutines called from C  
public C showCursor, showPlayer, showBoard, moveCursor, moveCursorContinuous, putPiece, put2Players, Play
                         
; Variables used – declared in C:
extern C row: DWORD, col: BYTE, rowScreen: DWORD, colScreen: DWORD, rowScreenIni: DWORD, colScreenIni: DWORD 
extern C carac: BYTE, tecla: BYTE, colCursor: BYTE, player: DWORD, mBoard: BYTE, pos: DWORD
extern C inaRow: DWORD, row4Complete: DWORD

.code   
   
; Macros that save and restore the general-purpose registers of the Intel 32-bit architecture using the stack
Push_all macro
	
	push eax
   	push ebx
    push ecx
    push edx
    push esi
    push edi
endm


Pop_all macro

	pop edi
   	pop esi
   	pop edx
   	pop ecx
   	pop ebx
   	pop eax
endm
   
   


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DO NOT MODIFY THIS ROUTINE.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Position the cursor at a specific row and column on the screen,
; based on the values in the variables colScreen and rowScreen,
; by calling the gotoxy_C function.
;
; Variables used:
; None
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gotoxy proc
   push ebp
   mov  ebp, esp
   Push_all

   ; Quan cridem la funció gotoxy_C(int row_num, int col_num) des d'assemblador 
   ; els paràmetres s'han de passar per la pila
      
   mov eax, [colScreen]
   push eax
   mov eax, [rowScreen]
   push eax
   call gotoxy_C
   pop eax
   pop eax 
   
   Pop_all

   mov esp, ebp
   pop ebp
   ret
gotoxy endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; NO LA PODEU MODIFICAR AQUESTA RUTINA.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Mostrar un caràcter, guardat a la variable carac
; en la pantalla en la posició on està  el cursor,  
; cridant a la funció printChar_C.
; 
; Variables utilitzades: 
; carac : variable on està emmagatzemat el caracter a treure per pantalla
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printch proc
   push ebp
   mov  ebp, esp

; We save the processor register state because  
; C functions do not preserve the register values.

   
   
   Push_all
   

; When calling the function printch_C(char c) from Assembly,  
; the parameter (carac) must be passed through the stack.
 
   xor eax,eax
   mov  al, [carac]
   push eax 
   call printChar_C
 
   pop eax
   Pop_all

   mov esp, ebp
   pop ebp
   ret
printch endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DO NOT MODIFY THIS ROUTINE.   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Read a character from the keyboard  
; by calling the getch_C function,  
; and store it in the variable tecla.
;
; Variables used:  
; tecla: variable where the read character is stored
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

getch proc
   push ebp
   mov  ebp, esp
    
   Push_all

   call getch_C
   mov [tecla],al
 
   Pop_all

   mov esp, ebp
   pop ebp
   ret
getch endp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Position the cursor at the column indicated by the variable colCursor,  
; on the row M located above the game board.  
; To position the cursor, call the provided gotoxy subroutine.  
; This subroutine moves the cursor to the position indicated by the  
; variables rowScreen and colScreen.  
; To calculate the cursor position on screen (rowScreen and colScreen),  
; use the following formulas:
;
;            rowScreen = rowScreenIni - 2
;            colScreen = colScreenIni + (colCursor * 4)
;
; Note that colCursor is an ASCII character and must be  
; converted to a numeric value before performing the operation.
;
; Variables used:
; colCursor   : column used to access the matrix  
; rowScreen   : row where we want to position the cursor on the screen  
; colScreen   : column where we want to position the cursor on the screen  
; rowScreenIni: initial row of the matrix on the screen  
; colScreenIni: initial column of the matrix on the screen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

showCursor proc
	push ebp
	mov  ebp, esp
	;Inici Codi de la pràctica: aquí heu d'escriure el vostre codi
	push_all 

	mov eax, [rowScreenIni]
	mov [rowScreen], eax

	;si no hemos usado el registro eax antes y queremos colocar un char debemos poner el eax a 0 haciendo un xor eax, eax
	;para que los bits más significativos sean zero.
	mov al, [colCursor]     
    sub al, 'A'             

    ; Calcular colScreen
    mov ebx, [colScreenIni] 
    shl eax, 2              
    add ebx, eax            
    mov [colScreen], ebx 
	
	call gotoxy

	pop_all




	;Fi Codi de la pràctica
	mov esp, ebp
	pop ebp
	ret

showCursor endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Displays the player number in the Player cell
; Converts the 32-bit integer value from the variable 'player'
; into an ASCII character and displays it at the screen position 
; indicated by rowScreen and colScreen, [23,19]
; The gotoxy subroutine must be called to position the cursor,
; and the printch subroutine must be called to display the character.
; The printch subroutine prints the character stored in the dil register.
;
; Variables used:
; rowScreen : row where we want to position the cursor on the screen.
; colScreen : column where we want to position the cursor on the screen.
; player: variable that indicates which player's turn it is
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

showPlayer proc
	push ebp
	mov  ebp, esp
	;Inici Codi de la pràctica: aquí heu d'escriure el vostre codi

	mov eax, [player]
	add eax, '0'	;char '0' = 48 dec
	mov [carac], al
	mov ebx, 19
	mov [colScreen], ebx
	mov ebx, 23
	mov [rowScreen], ebx
	call gotoxy
	call printch



	;Fi Codi de la pràctica
	mov esp, ebp
	pop ebp
	ret


showPlayer endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Writes the value of each cell stored in mBoard to its corresponding screen position
; Positions the cursor at each board cell by calling the gotoxy subroutine,
; and displays the corresponding value from the mBoard matrix by calling
; the printch subroutine
;
; To calculate the cursor position on screen, rowScreen and colScreen must be computed
; using the following formulas:
;          rowScreen = rowScreenIni + (row * 2) + 4
;          colScreen = colScreenIni + (col * 4) - 1
;
; Variables used:
; rowScreen : row where we want to position the cursor on the screen.
; colScreen : column where we want to position the cursor on the screen.
; rowScreenIni : row of the first position of the matrix on the screen.
; colScreenIni : column of the first position of the matrix on the screen.
; mBoard: matrix that contains the values of the different positions of the board.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


showBoard proc
	push ebp
	mov  ebp, esp
	;Inici Codi de la pràctica: aquí heu d'escriure el vostre codi

	mov esi,0

	for_fila:
		cmp esi, 6
		jge fi_for_fila ;saltar a final
		mov edi, 0
		
		for_columna:
			cmp edi, 7
			jge fi_for_columna ;saltar a for_fila

			;acceder cursor
			mov eax, edi
			shl eax, 2
			dec eax
			mov ebx, [ColScreenIni]
			add ebx, eax
			mov [colScreen], ebx
			mov eax, esi
			shl eax, 1
			add eax, 4
			mov ebx, [RowScreenIni]
			add ebx, eax
			mov [rowScreen], ebx
			
			

			;acceder  a matriz
			mov ebx, 7
			mov eax, esi
			mul ebx
			mov ebx, edi
			add ebx, eax
			mov al, [mBoard+ebx]
			mov [carac], al
			call gotoxy
			call printch
			
			inc edi
			jmp for_columna
		fi_for_columna:
			inc esi
			jmp for_fila
	fi_for_fila:



	;Fi Codi de la pràctica
	mov esp, ebp
	pop ebp
	ret


showBoard endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Subroutine that implements cursor movement to the right with ‘k’ and to the left with ‘j’.
; Calls the getch subroutine to read a key
; until one of the valid keys is pressed (‘j’, ‘k’, space, or 'q'<Quit>).
; The ‘j’ key moves the cursor to the left,
; the ‘k’ key moves the cursor to the right.
; It must ensure the cursor does not go out of bounds.
; If an invalid key is pressed, it must wait for a valid one.
;
; Variables used:
; tecla: variable where the read character is stored
; colCursor: variable that indicates the column where the cursor is currently located
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

moveCursor proc
	push ebp
	mov  ebp, esp
	;Inici Codi de la pràctica: aquí heu d'escriure el vostre codi

	tecla_valida:
		call getch
		cmp [tecla], 'j'   ;mou cursor a l'esquerra
		je mou_esquerra
		cmp [tecla], 'k'   ;mou dreta
		je mou_dreta
		cmp [tecla], ' '
		je fi
		cmp [tecla], 'q'
		je fi
		jmp tecla_valida 
	

	mou_esquerra:
		cmp [colCursor], 'A'
		jle fi
		dec colCursor
		jmp fi	

	mou_dreta:
		cmp [colcursor], 'G'
		jge fi
		inc colCursor
		jmp fi

	fi:



	;Fi Codi de la pràctica
	mov esp, ebp
	pop ebp
	ret


moveCursor endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Subroutine that implements continuous cursor movement
; The moveCursor subroutine must be repeatedly called
; until the space key or 'q'<Quit> is pressed.
; The ‘j’ key moves the cursor to the left,
; the ‘k’ key moves the cursor to the right.
; If an invalid key is pressed, it must wait for a valid one.
;
; Variables used:
; tecla: variable where the read character is stored
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

moveCursorContinuous proc
	push ebp
	mov  ebp, esp
	;Inici Codi de la pràctica: aquí heu d'escriure el vostre codi

	call showPlayer
	call showCursor
	loop_moveCursor:
		
		call moveCursor
		cmp [tecla], ' '
		je fi_loop
		cmp [tecla], 'q'
		je fi_loop
		call showCursor
		jmp loop_moveCursor

	fi_loop:



	;Fi Codi de la pràctica
	mov esp, ebp
	pop ebp
	ret


moveCursorContinuous endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This subroutine allows access to the matrix elements.
; It calculates the index to access the mBoard matrix in Assembly.
; mBoard[row][col] in C becomes [mBoard + pos] in Assembly,
; where pos = (row * 7 + col (converted to a number)).
;
; Variables used:
; row: row to access the mBoard matrix
; col: column to access the mBoard matrix
; pos: index to access the mBoard matrix
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

calcIndex proc
	push ebp
	mov  ebp, esp
	;Inici Codi de la pràctica: aquí heu d'escriure el vostre codi

	mov eax, [row]
	mov ebx, 7
	mul ebx
	mov bl, [col] 
	sub bl, 'A'  
	add eax, ebx
	mov [pos], eax



	;Fi Codi de la pràctica
	mov esp, ebp
	pop ebp
	ret


calcIndex endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; From the position where the piece was placed, check if the pieces
; below it vertically match the one just inserted.
; If they match, increment the counter and check if we’ve reached 4.
; If not yet at 4, continue checking downward.
; If 4 in a row is reached, set the row4Complete flag to 1.
;
; Variables used:
; mBoard : board matrix where the pieces are being inserted
; inaRow : counter to track the number of consecutive matching pieces
; row4Complete : flag indicating whether 4 in a row has been achieved
; pos : current position in the mBoard matrix being checked
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


checkRow proc
    push ebp
    mov ebp, esp

    mov [row4Complete], 0
    ; cargo en eax la posición actual en el tablero
    mov eax, [pos]
    ; guardo la ficha actual en bl
    mov bl, [mBoard+eax]

    ; guardo eax en la pila para usarlo más tarde
    push eax

    ; compruebo en vertical
    mov [inaRow], 1
    mov eax, [pos]

bucle_vertical:
    cmp eax, 35
    jge fin_vertical
    add eax, 7
    mov cl, [mBoard+eax]
    cmp cl, bl
    jne fin_vertical
    inc [inaRow]
    cmp [inaRow], 4
    je establecer_row4Complete
    jmp bucle_vertical

fin_vertical:
    ; restauro eax para la siguiente comprobación

    pop eax
    push eax

    ; empieza la comprobación horizontal

    mov [inaRow], 1
    mov al, [col]
    sub al, 'A'
    mov ah, 0
    mov esi, eax

    mov edi, [pos]
    mov ecx, esi

bucle_izquierda:
    cmp ecx, 0
    je comprobar_derecha
    dec ecx
    dec edi
    mov dl, [mBoard+edi]
    cmp dl, bl
    jne comprobar_derecha
    inc [inaRow]
    cmp [inaRow], 4
    je establecer_row4Complete
    jmp bucle_izquierda

comprobar_derecha:
    mov edi, [pos]
    mov ecx, esi

bucle_derecha:
    cmp ecx, 6
    je comprobar_diagonal
    inc ecx
    inc edi
    mov dl, [mBoard+edi]
    cmp dl, bl
    jne comprobar_diagonal
    inc [inaRow]
    cmp [inaRow], 4
    je establecer_row4Complete
    jmp bucle_derecha

comprobar_diagonal:
    
    mov [inaRow], 1
    mov edi, [pos]
    mov ecx, esi 

bucle_arriba_izquierda:
    cmp edi, 6 
    jle diagonal_abajo_derecha 
    cmp ecx, 0 
    je diagonal_abajo_derecha 
    sub edi, 8 
    dec ecx
    mov dl, [mBoard+edi]
    cmp dl, bl
    jne diagonal_abajo_derecha 
    inc [inaRow]
    cmp [inaRow], 4
    je establecer_row4Complete
    jmp bucle_arriba_izquierda

diagonal_abajo_derecha:
    mov edi, [pos]
    mov ecx, esi

bucle_abajo_derecha:
    cmp edi, 35 
    jge comprobar_diagonal_opuesta 
    cmp ecx, 6
    je comprobar_diagonal_opuesta 
    add edi, 8 
    inc ecx
    mov dl, [mBoard+edi]
    cmp dl, bl
    jne comprobar_diagonal_opuesta 
    inc [inaRow]
    cmp [inaRow], 4
    je establecer_row4Complete
    jmp bucle_abajo_derecha

comprobar_diagonal_opuesta:
    
    mov [inaRow], 1
    mov edi, [pos]
    mov ecx, esi

bucle_arriba_derecha:
    cmp edi, 6 
    jle diagonal_abajo_izquierda 
    cmp ecx, 6
    je diagonal_abajo_izquierda 
    sub edi, 6 ; 
    inc ecx
    mov dl, [mBoard+edi]
    cmp dl, bl
    jne diagonal_abajo_izquierda 
    inc [inaRow]
    cmp [inaRow], 4
    je establecer_row4Complete
    jmp bucle_arriba_derecha

diagonal_abajo_izquierda:
    mov edi, [pos]
    mov ecx, esi

bucle_abajo_izquierda:
    cmp edi, 35 
    jge fin_comprobacion
    cmp ecx, 0
    je fin_comprobacion
    add edi, 6 
    dec ecx
    mov dl, [mBoard+edi]
    cmp dl, bl
    jne fin_comprobacion
    inc [inaRow]
    cmp [inaRow], 4
    je establecer_row4Complete
    jmp bucle_abajo_izquierda


establecer_row4Complete:
    mov [row4Complete], 1

fin_comprobacion:
    pop eax
    mov esp, ebp
    pop ebp
    ret
checkRow endp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Places a piece in a free position on the game board
; The moveCursorContinuous subroutine must be called to choose the desired column.
; Once in the desired column, press the space key to "drop" the piece.
; Calculate the matrix position corresponding to the lowest empty cell
; in the column where the cursor is located, by calling the calcIndex subroutine.
; Move upward through the column until an empty position is found,
; and place the piece in that position in mBoard.
; Call the showBoard subroutine to display the updated board.
; If 'q'<Quit> is pressed, no piece should be inserted.
;
; Variables used:
; row : row index to access the mBoard matrix
; col : column index to access the mBoard matrix
; colCursor: column where the cursor is currently located
; pos : index to access the mBoard matrix
; mBoard : 6x7 matrix representing the game board
; carac : character to print on the screen
; tecla: ASCII code of the key pressed
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

putPiece proc
	push ebp
	mov  ebp, esp
	;Inici Codi de la pràctica: aquí heu d'escriure el vostre codi

	call showBoard 
	call moveCursorContinuous
	cmp [tecla], 'q'
	je fi

	mov al, [colCursor]
	mov [col], al

	mov esi, 5
	calcula_pos:
		mov [row], esi
		call calcIndex
		mov ebx, [pos]
		mov al, [mBoard+ebx] 
		cmp al, '.' 
		je m_carac	
		dec esi
		cmp esi, 0 
		jl fi 
		jmp calcula_pos 

		m_carac:
		cmp [player], 1
		jne carac_2
		mov [carac], 'O'	
		jmp coloca_fitxa

		carac_2:
		mov [carac], 'X'	

	coloca_fitxa:
		mov al, [carac]
		mov [mBoard+ebx], al 
		call checkRow
		

	fi:
		call showBoard



	;Fi Codi de la pràctica
	mov esp, ebp
	pop ebp
	ret


putPiece endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Two turns must be allowed by calling putPiece,
; one for each player,
; updating the corresponding cell on the screen
; with the player identifier by calling showPlayer.
; If 'q'<Quit> is pressed or a 4-in-a-row is achieved,
; the process must end.
;
; Variables used:
; tecla: ASCII code of the key pressed
; player: variable indicating which player is taking the turn
; row4Complete: variable updated by the checkRow subroutine
;               to indicate whether a 4-in-a-row has been achieved
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

put2Players proc
	push ebp
	mov  ebp, esp
	;Inici Codi de la pràctica: aquí heu d'escriure el vostre codi
	
	mov [player], 1 
	call putPiece 
	cmp [tecla], 'q' 
	je fi 
	cmp [row4Complete], 1 
	je fi 

	mov [player], 2
	call putPiece
	cmp [tecla], 'q'
	je fi
	cmp [row4Complete], 1
	je fi


	fi:


	;Fi Codi de la pràctica
	mov esp, ebp
	pop ebp
	ret


put2Players endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The put2Players subroutine is repeatedly called
; until 'q'<Quit> is pressed or a player achieves a 4-in-a-row.
;
; Variables used:
; tecla: ASCII code of the key pressed
; row4Complete: variable updated by the checkRow subroutine
;               to indicate whether a 4-in-a-row has been achieved
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Play proc
	push ebp
	mov  ebp, esp
	;Inici Codi de la pràctica: aquí heu d'escriure el vostre codi

	loop_play:
		call put2Players 
		cmp [tecla], 'q' 
		je fi_loop 
		cmp [row4Complete], 1 
		je fi_loop 
		jmp loop_play 
	fi_loop:



	;Fi Codi de la pràctica
	mov esp, ebp
	pop ebp
	ret


Play endp


END
