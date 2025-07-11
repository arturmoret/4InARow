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

I wanted to explore:

- Manual stack discipline and calling conventions  
- Direct memory arithmetic for 2-D arrays (`pos = row*7 + col`)  
- Flag-based branching for game rules  

Plus, it’s fun to see a classic game run with zero high-level abstractions.

---


