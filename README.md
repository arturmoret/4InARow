# 4InARow – Connect Four in x86 Assembly (MASM)

A fully-playable, console-based Connect Four game built **from scratch in Intel x86 assembly**.  
Written for the pure low-level challenge: direct matrix indexing, manual cursor control, and win detection without any high-level helpers.

---

## Features

- **6 × 7 ASCII board** rendered in real time  
  A classic Connect Four grid, drawn and updated directly in the console.

- **Keyboard input with responsive controls**  
  `j` to move left, `k` to move right, `Space` to drop a piece, and `q` to quit.

- **Full win detection in pure assembly**  
  Checks for 4-in-a-row vertically, horizontally, and diagonally using memory arithmetic and conditional jumps — no `if` statements or loops from C.

- **Two gameplay modes**  
  - *Single insert* (`putPiece`): drop a single piece manually for testing or demonstration  
  - *Full match* (`Play`): alternate turns between two players until someone wins or quits

- **Live board rendering with cursor control**  
  The board updates instantly with each move, and the cursor position is manually handled via screen coordinates.

- **Clear separation of responsibilities**  
  The C layer handles I/O and system calls, while all game logic and computation live in x86 assembly, making the flow modular and testable.

- **Simple UI via console menu**  
  An in-game menu (also built from scratch) lets you test individual components or start full matches.

---

## Build & Run

1. Open **`4InARow.sln`** in **Visual Studio 2022** (Community or higher).  
2. Choose the **x86** target platform.  
3. Build & run <kbd>F5</kbd>.  
   The console menu appears; select an option (1-8) to play or test each feature.

> **Note:** MASM is enabled via *Project → Build Customizations → masm*.

---

## Controls in-game

<div align="center">

| Key     | Action                   |
|---------|--------------------------|
| `j`     | Move cursor left         |
| `k`     | Move cursor right        |
| `Space` | Drop piece in column     |
| `q`     | Quit current action/game |

</div>

---


## Why Assembly?

This project was an opportunity to go beyond high-level abstractions and work directly with the architecture.  
Building a game like Connect Four in x86 assembly requires full control over memory, logic, and execution flow, which makes it both challenging and rewarding.

The main goals were:

- Understand and apply manual stack handling and subroutine calling conventions  
- Perform explicit memory arithmetic for 2D array indexing 
- Use processor flags and conditional jumps to control game logic without `if` statements  
- Handle screen output and cursor movement without any libraries or built-in helpers  
- Define clear integration between C and Assembly code through consistent global symbols

By doing all of this manually, the project becomes a hands-on exercise in how programs actually execute at the lowest level, while still delivering a playable and structured result.

---

## Screenshots

A few examples of the game running in the console:

### Main menu
The program starts with a menu where you can select different game features or modes.

<p align="center">
  <img width="350" alt="Main Menu" src="https://github.com/user-attachments/assets/d0ae0ee4-69a7-491a-98d4-ae6a2fc94184" />
</p>

### Empty board
When a match begins, the board is clean and ready for the first move.

<p align="center">
  <img width="350" alt="Empty Board" src="https://github.com/user-attachments/assets/afd918fc-5518-46a9-940c-ba1313bdd969" />
</p>

### Mid-game with a winner
Here’s an example of a board with several moves and a winning combination.

<p align="center">
  <img width="350" alt="Winning Board" src="https://github.com/user-attachments/assets/4ab9b831-0dd0-41fa-981e-5f81f8af4587" />
</p>



