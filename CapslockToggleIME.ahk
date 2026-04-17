#Requires AutoHotkey v2.0
#SingleInstance Force

; ===================================
; CapsLock 切换微软拼音中英文模式
; ===================================

; 禁用 CapsLock 原始功能
SetCapsLockState("AlwaysOff")

; 按下 CapsLock 切换中英文
CapsLock:: {
    ToggleIME()
}


; ===================================
; 核心函数
; ===================================

GetIMEConversionMode(hwnd) {
    imeWnd := DllCall("imm32\ImmGetDefaultIMEWnd", "Ptr", hwnd, "Ptr")
    if (!imeWnd)
        return -1
    return DllCall("user32\SendMessageW"
        , "Ptr", imeWnd
        , "UInt", 0x0283        ; WM_IME_CONTROL
        , "UInt", 0x0001        ; IMC_GETCONVERSIONMODE
        , "UInt", 0
        , "Ptr")
}

SetIMEConversionMode(hwnd, mode) {
    imeWnd := DllCall("imm32\ImmGetDefaultIMEWnd", "Ptr", hwnd, "Ptr")
    if (!imeWnd)
        return
    DllCall("user32\SendMessageW"
        , "Ptr", imeWnd
        , "UInt", 0x0283        ; WM_IME_CONTROL
        , "UInt", 0x0002        ; IMC_SETCONVERSIONMODE
        , "UInt", mode
        , "Ptr")
}

ToggleIME() {
    hwnd := WinGetID("A")
    try {
        focused := ControlGetFocus("A")
        ctrlHwnd := ControlGetHwnd(focused, "A")
        if (ctrlHwnd)
            hwnd := ctrlHwnd
    }
    mode := GetIMEConversionMode(hwnd)

    if (mode = 0) {
        ; 当前英文 → 切换到中文
        SetIMEConversionMode(hwnd, 1025)
        ShowTooltip("中文 ●")
    } else {
        ; 当前中文 → 切换到英文
        SetIMEConversionMode(hwnd, 0)
        ShowTooltip("EN ○")
    }
}

ShowTooltip(text) {
    ToolTip(text)
    SetTimer(() => ToolTip(), -800)  ; 800ms 后自动消失
}
