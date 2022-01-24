#Warn
#NoEnv
#Persistent

match_lm2 = LaMulana2 ahk_class UnityWndClass
Gui, Add, Text,,
(
La-Mulana 2 cropping and resizing tool.
Please wait until the game has finished loading
and select windowed mode in the settings menu
before selecting any of the options below.
)
Gui, Add, Button, gCropped2x, Borderless cropped 960p
Gui, Add, Button, gCropped2_25x, Borderless cropped 1080p (non-integer)
Gui, Add, Button, gCropped3x, Borderless cropped 1440p
Gui, Add, Button, gResizable, Uncropped with resizable border
Gui, Add, Button, gRestore, Restore to normal uncropped 1080p
Gui, Show,, LM2 Resizer
Return

GuiClose:
ExitApp

Restore:
WinWait, %match_lm2%
WinSet, Style, +0xC00000
WinSet, Style, -0x40000
WinMoveAdjusted(1920, 1080, 1, 1)
WinSet, Region,
Return

Resizable:
WinWait, %match_lm2%
WinSet, Style, -0xC00000
WinSet, Style, +0x40000
WinMoveAdjusted(1920, 1080, 0, 0)
WinSet, Region,
Return

Cropped2x:
WinWait, %match_lm2%
WinSet, Style, -0xC40000
WinMove,,, -128, -60, 1920, 1080
WinSet, Region, 128-60 W1664 H960
Return

Cropped3x:
WinWait, %match_lm2%
WinSet, Style, -0xC40000
WinMove,,, -160, -90, 2880, 1620
WinSet, Region, 160-90 W2560 H1440
Return

Cropped2_25x:
WinWait, %match_lm2%
WinSet, Style, -0xC40000
WinMove,,, -144, -68, 2160, 1215
WinSet, Region, 144-68 W1872 H1080
Return

WinMoveAdjusted(w, h, gravity_x := 0, gravity_y := 0) {
    hwnd := WinExist()
    if (!hwnd)
        return
    WinGet, Style, style
    WinGet, ExStyle, exstyle
    VarSetCapacity(rect, 16)
    NumPut(0, rect,  0, "int")
    NumPut(0, rect,  4, "int")
    NumPut(w, rect,  8, "int")
    NumPut(h, rect, 12, "int")
    DllCall("AdjustWindowRectEx", "ptr", &rect, "uint", style, "uint", !!DllCall("GetMenu", "ptr", hwnd, "ptr"), "uint", exstyle)
    x := NumGet(rect,  0, "int")
    y := NumGet(rect,  4, "int")
    w := NumGet(rect,  8, "int") - x
    h := NumGet(rect, 12, "int") - y
    x := gravity_x * (A_ScreenWidth - w) / 2
    y := gravity_y * (A_ScreenHeight - h) / 2
    WinMove,,, %x%, %y%, %w%, %h%
}
