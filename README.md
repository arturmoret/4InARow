# 4InARow – Connect Four in x86 Assembly (MASM)

A fully-playable, console-based Connect Four game built **from scratch in Intel x86 assembly**.  
Written for the pure low-level challenge: direct matrix indexing, manual cursor control, and win detection without any high-level helpers.

---

## Features

- **6 × 7 ASCII board** rendered in real time  
- Keyboard controls: `j` ← left `k` → right `Space` drop piece `q` quit  
- Vertical, horizontal & diagonal win detection in pure assembly  
- Two modes  
  - *Single insert* (`putPiece`)  
  - *Full match* (`Play`) – automatic turn alternation  
- Clean separation between C front-end (I/O stub) and ASM core logic

---

## Build & Run

1. Open **`4InARow.sln`** in **Visual Studio 2022** (Community or higher).  
2. Choose the **x86** target platform.  
3. Build & run <kbd>F5</kbd>.  
   The console menu appears; select an option (1-8) to play or test each feature.

> **Note:** MASM is enabled via *Project → Build Customizations → masm*.

---

## Controls in-game

| Key | Action                      |
|-----|-----------------------------|
| `j` | Move cursor left            |
| `k` | Move cursor right           |
| `Space` | Drop piece in column |
| `q` | Quit current action / game |

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



