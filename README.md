## Setup

| Category       | Item                  |
| -------------- | --------------------- |
| Distro         | Arch Linux            |
| Editor         | NeoVim                |
| Browser        | Firefox / Zen         |
| Shell          | Fish                  |
| Process Viewer | Btop                  |
| Compositor     | picom                 |
| Notifications  | dunst                 |
| WM             | i3wm                  |
| Terminal       | Kitty                 |
| App Launcher   | Rofi                  |
| Theme          | Pywal                 |
| Font           | Maple Mono / Hack     |

## Installation

> [!Note]
> Currently supports **Arch Linux** only.

Clone the dotfiles repository:

```bash
mkdir ~/.dotfiles-manager
cd ~/.dotfiles-manager
git clone https://github.com/Ordeeper/dotfiles.git .
```

Run the installation script:

```bash
./install.sh
```

## Keybinds

### i3wm

| **Action**                   | **Keybinding**                                                                                                                                                                    |
| ---------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Window Focus**             | `Alt+h/j/k/l` or `Alt+←/↓/↑/→` (Move focus between windows)                                                                                                                       |
| **Toggle Tiling/Floating**   | `Alt+Tab` (Toggle focus between tiling and floating)                                                                                                                              |
| **Focus Parent Container**   | `Alt+a` (Focus parent container)                                                                                                                                                  |
| **Move Window**              | `Alt+Shift+h/j/k/l` or `Alt+Shift+←/↓/↑/→` (Move window in direction)                                                                                                             |
| **Split Layouts**            | `Alt+b` (Split horizontally) <br> `Alt+n` (Split vertically)                                                                                                                      |
| **Stack Layout**             | `Alt+s` (Stack layout)                                                                                                                                                            |
| **Tabbed Layout**            | `Alt+w` (Tabbed layout)                                                                                                                                                           |
| **Toggle Split Layout**      | `Alt+e` (Toggle split layout)                                                                                                                                                     |
| **Toggle Floating**          | `Alt+Return` (Toggle floating mode)                                                                                                                                               |
| **Fullscreen**               | `Alt+f` (Fullscreen)                                                                                                                                                              |
| **Resize Mode**              | `Alt+r` (Enter resize mode) <br> `h/j/k/l` or `←/↓/↑/→` to resize <br> `Enter/Escape` to exit                                                                                     |
| **Kill Window**              | `Alt+Shift+q` (Kill focused window)                                                                                                                                               |
| **Move to Scratchpad**       | `Alt+Shift+-` (Move to scratchpad)                                                                                                                                                |
| **Show/Hide Scratchpad**     | `Alt+-` (Show/hide scratchpad)                                                                                                                                                    |
| **Switch Workspaces**        | `Alt+1..0` (Switch to workspace 1–10) <br> `Alt+Ctrl+Left/Right` (Prev/Next workspace)                                                                                            |
| **Move Window to Workspace** | `Alt+Shift+1..0` (Move window to workspace 1–10)                                                                                                                                  |
| **Reload Config**            | `Alt+Shift+c` (Reload i3 config)                                                                                                                                                  |
| **Restart i3**               | `Alt+Shift+r` (Restart i3)                                                                                                                                                        |
| **Exit i3**                  | `Alt+Shift+e` (Exit i3 with confirmation prompt)                                                                                                                                  |
| **Volume Control**           | `Alt+[`: Volume up <br> `Alt+]`: Volume down <br> `XF86AudioMute`: Toggle mute <br> `XF86AudioMicMute`: Toggle mic mute                                                           |
| **Brightness Control**       | `XF86MonBrightnessUp`: Increase brightness <br> `XF86MonBrightnessDown`: Decrease brightness                                                                                      |
| **MPRIS Media Control**      | `Alt+comma` or `XF86AudioPrev`: Previous <br> `Alt+period` or `XF86AudioNext`: Next <br> `Alt+semicolon` or `XF86AudioPlay`: Play/Pause                                           |
| **Pomodoro**                 | `Alt+Shift+semicolon`: Toggle Pomodoro <br> `Alt+Shift+/`: Start/Stop Pomodoro                                                                                                    |
| **Launchers**                | `Alt+space`: Launch terminal <br> `Alt+d`: Launch Rofi <br> `Alt+c`: Clipboard insert (clipcat) <br> `Alt+x`: Clipboard remove (clipcat)                                          |
| **Custom Scripts**           | `Alt+Shift+w`: Launch draw window <br> `Alt+Shift+s`: Launch Flameshot <br> `Alt+Shift+d`: Launch image-to-text <br> `Alt+Shift+a`: Launch code-to-link <br> `Alt+'`: Lock screen |
| **Applications**             | `Alt+F1`: Firefox Nightly <br> `Alt+F2`: Reverso <br> `Alt+F3`: Spotify <br> `Alt+F4`: Obsidian                                                                                   |

### Tmux

> [!Note]
> The `<Prefix>` key is set to `<C-Space>`.

| Keybind   | Mode      | Action                            |
| --------- | --------- | --------------------------------- |
| `r`       | Prefix    | Reload tmux configuration         |
| `N`       | Prefix    | Previous Window                   |
| `b`       | Prefix    | Split Window Horizontally         |
| `n`       | Prefix    | Split Window Vertically           |
| `Q`       | Prefix    | Kill Window (Confirm)             |
| `Space`   | Prefix    | New Window                        |
| `Tab`     | Prefix    | Last Window                       |
| `q`       | Prefix    | Kill Pane                         |
| `k`       | Prefix    | Select Pane Up                    |
| `j`       | Prefix    | Select Pane Down                  |
| `h`       | Prefix    | Select Pane Left                  |
| `l`       | Prefix    | Select Pane Right                 |
| `K`       | Prefix    | Resize Pane Up                    |
| `J`       | Prefix    | Resize Pane Down                  |
| `H`       | Prefix    | Resize Pane Left                  |
| `L`       | Prefix    | Resize Pane Right                 |
| `f`       | Prefix    | Toggle Pane Zoom (Resize)         |
| `B`       | Prefix    | Swap Pane Up                      |
| `N`       | Prefix    | Swap Pane Down                    |
| `v`       | Copy Mode | Begin Selection                   |
| `y`       | Copy Mode | Copy Selection to Clipboard       |
| `o`       | Prefix    | Toggle Status Bar                 |

### NeoVim

> [!Note]
> The `<leader>` key is set to `<Space>`.

| Keybind      | Mode     | Action                           |
| ------------ | -------- | -------------------------------- |
| `<Esc>`      | Normal   | Clear Highlights                 |
| `<C-s>`      | Normal   | Save File                        |
| `<C-x>`      | Normal   | Save and Exit                    |
| `<C-q>`      | Normal   | Don't Save and Exit              |
| `<C-p>`      | Normal   | Scroll Up (Page Up)              |
| `<leader>n`  | Normal   | Toggle Line Number               |
| `<leader>rn` | Normal   | Toggle Relative Line Number      |
| `<C-h>`      | Normal   | Move to Left Window              |
| `<C-l>`      | Normal   | Move to Right Window             |
| `<C-k>`      | Normal   | Move to Upper Window             |
| `<C-j>`      | Normal   | Move to Lower Window             |
| `<tab>`      | Normal   | Next Buffer                      |
| `<S-tab>`    | Normal   | Previous Buffer                  |
| `<leader>ch` | Normal   | Create New Buffer                |
| `<C-d>`      | Normal   | Kill Buffer                      |
| `<C-c>`      | Normal   | Save and Kill Buffer             |
| `<C-b>`      | Normal   | Vertical Split                   |
| `<C-n>`      | Normal   | Horizontal Split                 |
| `<C-h>`      | Insert   | Move Left                        |
| `<C-l>`      | Insert   | Move Right                       |
| `<C-k>`      | Insert   | Move Up                          |
| `<C-j>`      | Insert   | Move Down                        |
| `gp`         | Visual   | Replace Selection with TitleCase |
| `<C-d>`      | Terminal | Force Exit Terminal              |

#### Plugins

##### Telescope

| Keybind             | Mode          | Action                 | 
| ------------------- | ------------- | ---------------------- | 
| `<leader>f`         | Normal        | Live Grep              |
| `<leader>h`         | Normal        | Open File Browser      |
| `<leader>j`         | Normal        | List Open Buffers      |
| `<CR>`              | Normal/Insert | Select Default         |
| `<C-t>`             | Normal/Insert | Select One or Multi    |
| `<C-k>`             | Normal/Insert | Move Selection Up      |
| `<C-j>`             | Normal/Insert | Move Selection Down    |
| `<C-u>`             | Normal/Insert | Focus Preview (Up)     |
| `<C-p>`             | Normal/Insert | Scroll Preview Left    |
| `<C-g>`             | Normal/Insert | Scroll Preview Right   |
| `<C-v>`             | Normal/Insert | Scroll Preview Up      |
| `<C-f>`             | Normal/Insert | Scroll Preview Down    |
| `<ScrollWheelUp>`   | Normal/Insert | Scroll Preview Up      |
| `<ScrollWheelDown>` | Normal/Insert | Scroll Preview Down    |
| `<C-d>`             | Normal/Insert | Close Telescope Window |
| `<C-b>`             | Normal/Insert | Select Vertical        |
| `<C-n>`             | Normal/Insert | Select Horizontal      |

##### Telescope File Browser

| Keybind | Mode          | Action               |
| ------- | ------------- | -------------------- |
| `<C-c>` | Normal/Insert | Create File          |
| `<C-x>` | Normal/Insert | Delete File          |
| `<C-r>` | Normal/Insert | Rename File          |
| `<C-m>` | Normal/Insert | Move File            |
| `<C-y>` | Normal/Insert | Copy File            |
| `<C-s>` | Normal/Insert | Toggle All Files     |
| `<C-e>` | Normal/Insert | Go to Home Directory |
| `<C-w>` | Normal/Insert | Go to CWD            |
| `<C-q>` | Normal/Insert | Change CWD           |
| `<C-a>` | Insert        | Toggle Hidden Files  |
| `<C-h>` | Normal        | Toggle Hidden Files  |
| `<C-o>` | Normal/Insert | Open File            |

##### Telescope Buffers

| Keybind | Mode   | Action        |
| ------- | ------ | ------------- |
| `<C-x>` | Insert | Delete Buffer |
| `x`     | Normal | Delete Buffer |

##### Zen Mode & Twilight

| Keybind     | Mode   | Action          |
| ----------- | ------ | --------------- |
| `<leader>z` | Normal | Toggle ZenMode  |
| `<leader>a` | Normal | Toggle Twilight |

##### Ufo

| Keybind | Mode   | Action                   |
| ------- | ------ | ------------------------ |
| `zR`    | Normal | Open All Folds           |
| `zM`    | Normal | Close All Folds          |
| `za`    | Normal | Toggle Fold Under Cursor |

##### Toggleterm

| Keybind | Mode                   | Action          |
| ------- | ---------------------- | --------------- |
| `<C-g>` | Normal/Insert/Terminal | Toggle Terminal |

##### Neovim Project

| Keybind     | Mode   | Action              |
| ----------- | ------ | ------------------- |
| `<leader>l` | Normal | Project History     |
| `<leader>k` | Normal | Discover Projects   |
| `<leader>R` | Normal | Load Recent Project |

##### Codesnap

| Keybind     | Mode   | Action        |
| ----------- | ------ | ------------- |
| `<leader>C` | Visual | Open CodeSnap |
| `<leader>S` | Visual | Save CodeSnap |

##### LSP (lspconfig)

| Keybind      | Mode          | Action                  |
| ------------ | ------------- | ----------------------- |
| `<leader>ç`  | Normal        | Open Diagnostics Float  |
| `<leader>[`  | Normal        | Previous Diagnostic     |
| `<leader>]`  | Normal        | Next Diagnostic         |
| `<leader>~`  | Normal        | Set Location List       |
| `gD`         | Normal        | Go to Declaration       |
| `gd`         | Normal        | Go to Definition        |
| `K`          | Normal        | Hover Documentation     |
| `gi`         | Normal        | Go to Implementation    |
| `<C-ç>`      | Normal        | Signature Help          |
| `<leader>wa` | Normal        | Add Workspace Folder    |
| `<leader>wr` | Normal        | Remove Workspace Folder |
| `<leader>wl` | Normal        | List Workspace Folders  |
| `<leader>D`  | Normal        | Go to Type Definition   |
| `<leader>rx` | Normal        | Rename Symbol           |
| `<leader>ca` | Normal/Visual | Code Action             |
| `gr`         | Normal        | List References         |
| `<leader>t`  | Normal        | Format Code             |
