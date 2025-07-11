

//6x7 matrix that stores the state of the 4InARow board
extern "C" char mBoard[6][7] = {
				   {'.','.','.','.','.','.','.'},
				   {'.','.','.','.','.','.','.'},
				   {'.','.','.','.','.','.','.'},
				   {'.','.','.','.','.','.','.'},
				   {'.','.','.','.','.','.','.'},
				   {'.','.','.','.','.','.','.'} };

extern "C" char tecla;			// ASCII code of the pressed key

extern "C" int row;				// Row index to access the gameCards matrix [1..5]
extern "C" char col;			// Column index to access the gameCards matrix [A..D]
extern "C" char colCursor;		// Current column where the cursor is located [A..D]
extern "C" int player;			// Indicates the current player number

extern "C" int rowScreen;		// Row position on the screen to place the cursor
extern "C" int colScreen;		// Column position on the screen to place the cursor

extern "C" int rowScreenIni;	// Initial screen row of the board (in screen coordinates)
extern "C" int colScreenIni;	// Initial screen column of the board (in screen coordinates)

extern "C" int pos;				// Index to access the mBoard matrix
extern "C" char carac;			// ASCII code of the character to be printed on screen

extern "C" int inaRow;			// Counter for consecutive pieces (4 in a row triggers win)
extern "C" int row4Complete;	// Indicates that 4 pieces in a row have been achieved
