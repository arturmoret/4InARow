#include <stdio.h>
#include <conio.h>

#include <iostream>
#include <iomanip>
#include <stdlib.h>
#include <time.h>
#include <windows.h>
#include "globals.h"

extern "C" {
	// Definition of ASM subroutines
	void showCursor();
	void showPlayer();
	void showBoard();
	void moveCursor(); 
	void moveCursorContinuous();
	void putPiece();
	void put2Players();
	void Play();
	 

	void printChar_C(char c);
	int  clearscreen_C();
	int  printMenu_C();
	int  gotoxy_C(int row_num, int col_num);
	char getch_C();
	int  printBoard_C(int tries);
}



/**
 * Definition of global variables
 */

char carac,tecla;
int  rowScreenIni = 6; // Initial row of the game board
int  colScreenIni = 8; // Initial column of the game board
int  row;
char col,colCursor;
int  pos;
int  player = 1;
int  rowScreen;
int  colScreen;
int row4Complete = 0;
int inaRow;
int i, j;


int opc;



// Print a character
// When calling this function from Assembly, the parameter must be passed via the stack
void printChar_C(char c) {
	putchar(c);
}

// Clear the screen
int clearscreen_C() {
	system("CLS");
	return 0;
}

int migotoxy(int x, int y) { //USHORT x,USHORT y) {
	COORD cp = { y,x };
	SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), cp);
	return 0;
}

// Set the cursor to a specific row and column on the screen
// When calling this function from Assembly, the parameters (row_num) and (col_num) must be passed via the stack
int gotoxy_C(int row_num, int col_num) {
	migotoxy(row_num, col_num);
	return 0;
}


// Print the game menu
int printMenu_C() {

	clearscreen_C();
	gotoxy_C(1, 1);
	printf("                                 \n");
	printf("                                 \n");
	printf("                                 \n");
	printf(" _______________________________ \n");
	printf("|                               |\n");
	printf("|           MAIN MENU           |\n");
	printf("|_______________________________|\n");
	printf("|                               |\n");
	printf("|       1. Show Cursor          |\n");
	printf("|       2. Show Player          |\n");
	printf("|       3. Show Board           |\n");
	printf("|       4. Move Cursor          |\n");
	printf("|       5. Move Continuous      |\n");
	printf("|       6. Put Piece            |\n");
	printf("|       7. Put 2 players        |\n");
	printf("|       8. Play                 |\n");
	printf("|                               |\n");
	printf("|                               |\n");
	printf("|        0. Exit                |\n");
	printf("|_______________________________|\n");
	printf("|                               |\n");
	printf("|           OPTION:             |\n");
	printf("|_______________________________|\n");
	return 0;
}


// Read a key without waiting and without displaying it on the screen
char getch_C() {
	DWORD mode, old_mode, cc;
	HANDLE h = GetStdHandle(STD_INPUT_HANDLE);
	if (h == NULL) {
		return 0; // console not found
	}
	GetConsoleMode(h, &old_mode);
	mode = old_mode;
	SetConsoleMode(h, mode & ~(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT));
	TCHAR c = 0;
	ReadConsole(h, &c, 1, &cc, NULL);
	SetConsoleMode(h, old_mode);

	return c;
}


/**
 * Display the game board on the screen (board lines).
 *
 * This function is called from both C and Assembly,
 * and there is no equivalent Assembly subroutine.
 * It takes no parameters.
 */
void printBoard_C() {

	gotoxy_C(1, 1);                                     //Rows
														 //Board                                 
	printf("_____________________________________ \n"); //01
	printf("|                                     |\n"); //02
	printf("|             4 in a ROW              |\n"); //03
	printf("|                                     |\n"); //04
	printf("|    +---+---+---+---+---+---+---+    |\n"); //05
	printf("|  M |   |   |   |   |   |   |   |    |\n"); //06
	printf("|    +---+---+---+---+---+---+---+    |\n"); //07
  //Cols board. 08   12  16  20  24   28         
	printf("|      A   B   C   D   E   F   G      |\n"); //08
	printf("|    +---+---+---+---+---+---+---+    |\n"); //09
	printf("|  0 |   |   |   |   |   |   |   |    |\n"); //10
	printf("|    +---+---+---+---+---+---+---+    |\n"); //11
	printf("|  1 |   |   |   |   |   |   |   |    |\n"); //12
	printf("|    +---+---+---+---+---+---+---+    |\n"); //13
	printf("|  2 |   |   |   |   |   |   |   |    |\n"); //14
	printf("|    +---+---+---+---+---+---+---+    |\n"); //15
	printf("|  3 |   |   |   |   |   |   |   |    |\n"); //16
	printf("|    +---+---+---+---+---+---+---+    |\n"); //17
	printf("|  4 |   |   |   |   |   |   |   |    |\n"); //18
	printf("|    +---+---+---+---+---+---+---+    |\n"); //19
	printf("|  5 |   |   |   |   |   |   |   |    |\n"); //20
	printf("|    +---+---+---+---+---+---+---+    |\n"); //21  

   //Cols digits     15       24                 
	printf("|               +-----+               |\n"); //22
	printf("|       Player  |     |               |\n"); //23
	printf("|               +-----+               |\n"); //24 
	printf("|    (ESC)Exit     (Space)Put Piece   |\n"); //25
	printf("|     (j)Left          (l)Right       |\n"); //26
	printf("|                                     |\n"); //27
	printf("|                                     |\n"); //28
	printf("|_____________________________________|\n"); //29

}

int main(void) {
	opc = 1;

	while (opc != '0') {
		printMenu_C();				// Display the menu
		gotoxy_C(22, 20);			// Position the cursor
		opc = getch_C();			// Read an option
		switch (opc) {
		case '1':					// First Menu Option -> 1. Show Cursor
			clearscreen_C();  		// Clear the screen
			printBoard_C();			// Display the board
			gotoxy_C(30, 12);		// Position the cursor below the board
			printf("Press any key ");

			colCursor = 'D';		// Initial column where we want the cursor to appear ('D')
			showCursor();			// Place the cursor in the column specified by colCursor

			getch_C();				// Wait for any key press
			break;

		case '2':					// Second Menu Option -> 2. Show Player
			clearscreen_C();  		// Clear the screen
			printBoard_C();   		// Display the board

			player = 1;
			showPlayer();			// Show the player number in the Player cell

			gotoxy_C(30, 12);		// Position the cursor below the board
			printf("Press any key ");
			getch_C();
			break;

		case '3':					// Third Menu Option -> 3. Show Board
			clearscreen_C();  		// Clear the screen
			printBoard_C();   		// Display the board

			player = 1;				
			showPlayer();			// Show the player number in the Player cell
			showBoard();			// Write each cell value stored in mBoard to its corresponding screen position

			gotoxy_C(30, 12);		// Position the cursor below the board
			printf("Press any key ");
			getch_C();
			break;
		
		case '4':					// Fourth Menu Option -> 4. Move Cursor
			clearscreen_C();  		// Clear the screen
			printBoard_C();   		// Display the board

			colCursor = 'D';		// Initial column where we want the cursor to appear ('D')
			showCursor();			// Place the cursor in the column specified by colCursor

			moveCursor();			// Subroutine that moves the cursor right with ‘k’ and left with ‘j’

			gotoxy_C(30, 12);		// Position the cursor below the board
			printf("Press any key ");

			showCursor();			// Place the cursor in the column specified by colCursor

			getch_C();
			break;

		case '5':					// Fifth Menu Option -> 5. Move Continuous
			clearscreen_C();  		// Clear the screen
			printBoard_C();   		// Display the board

			player = 1;
			gotoxy_C(30, 5);
			printf(" Press j, k, <space> or <Quit> ");
			colCursor = 'D';		// Initial column where we want the cursor to appear ('D')

			moveCursorContinuous();	// Subroutine that implements continuous cursor movement

			gotoxy_C(30, 2);		// Position the cursor below the board
			printf("          Press any key          ");

			getch_C();
			break;
		case '6':					// Sixth Menu Option -> 6. Put Piece
			clearscreen_C();  		// Clear the screen
			printBoard_C();   		// Display the board

			player = 1;
			gotoxy_C(30, 5);
			printf(" Press j, k, <space> or <Quit> ");
			colCursor = 'D';		// Initial column where we want the cursor to appear ('D')

			putPiece();				// Place a piece in a free position on the board

			gotoxy_C(30, 2);
			if (tecla != 'q')
				printf("  Piece inserted - Press any key ");
			else
				printf("           Press any key          ");
			getch_C();

			break;
		case '7':					// Seventh Menu Option -> 7. Put 2 Players
			clearscreen_C();  		// Clear the screen
			printBoard_C();   		// Display the board
			player = 1;
			gotoxy_C(30, 5);
			printf(" Press j, k, <space> or <Quit> ");
			colCursor = 'D';		// Initial column where we want the cursor to appear ('D')

			put2Players();

			gotoxy_C(30, 2);		// Position the cursor below the board
			printf("          Press any key          ");

			getch_C();
			break;
		case '8':					// Eighth Menu Option -> 8. Play
			clearscreen_C();  		// Clear the screen
			printBoard_C();   		// Display the board
			player = 1;
			gotoxy_C(30, 5);
			printf(" Press j, k, <space> or <Quit> ");
			colCursor = 'D';		// Initial column where we want the cursor to appear ('D')
			
			row4Complete = 0;
			for (i = 0; i < 6; i++)
				for (j = 0; j < 7; j++)
					mBoard[i][j] = '.';

			Play();

			gotoxy_C(30, 2);
			if (row4Complete != 1)
				printf("           Press any key          ");
			else
				if (player == 1)
					printf("            Player 1 WINS          ");
				else
					printf("            Player 2 WINS          ");
			getch_C();

			break;
		}
	}
	gotoxy_C(19, 1);						// Position the cursor under row 19
	return 0;
}
