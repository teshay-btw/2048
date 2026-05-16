# 2048 — Custom Rules, Themes & Sounds
A new version of the classic 2048 game, written in Qt/QML, with advanced features:
- Custom rules (two game modes)
- Themes (Normal / Dark / Neon)
- Sound effects (4 options + silent mode)
- Progress saving
- Tile appearance animations
- Windows support (Qt 6)

# Features
## Two game modes
### Classic Mode
#### Standard 2048 rules:
- numbers cannot be combined multiple times, e.g. 2 2 2 2 -> 4 4
- standard connection order, e.g. 2 2 2 -> 2 4
- after each move, a tile of 2 or 4 appears
- a tile cannot appear without moving or combining

### Custom Mode
#### Advanced logic:
- tiles can be chained, e.g. 2 2 2 2 -> 8
- different connection order, e.g. 2 2 2 -> 4 2
- only 2 can appear
- a tile can appear even without moving the others or combining

# Themes
### The game offers three themes:
- Normal — classic, light-colored
- Dark — dark, minimalist, with a blue tint
- Neon — bright, high-contrast, neon-colored

# Sounds
In the settings, you can choose from four sound options, as well as no sound.

# Saving progress
### The game automatically saves:
- 4x4 field
- current score
- best score
- selected mode
- selected theme
- selected sound

All data is stored in settings.txt file next to the .exe file.

# How to install?
- Go to "Releases"
- Download 2048.zip
- Unzip the archive
- Run 2048.exe
- Create a shortcut and move it anywhere

# Screenshots
<img width="492" height="602" alt="2048_release_ytZSqa6MZd" src="https://github.com/user-attachments/assets/64595bed-87b8-4881-b48d-3f128391dca2" />
<img width="492" height="602" alt="2048_4MG6SFXm3q" src="https://github.com/user-attachments/assets/80156015-af56-4a75-bd2d-7c3402fe4848" />
