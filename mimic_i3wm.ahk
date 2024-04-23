#f::
WinGet, windowID, ID, A ; 获取当前窗口ID
WinGet, Style, Style, A ; 获取当前窗口样式


; 检测窗口是否已最大化 (WS_MAXIMIZEBOX 并且 WS_MAXIMIZE 都存在)
If (Style & 0x10000) and (Style & 0x01000000)
{
    ; 如果已经最大化，发送 Win + Down 来恢复窗口
    Send, {LWin Down}{Down}{LWin Up}
}
else
{
    ; 如果未最大化，发送 Win + Up 来最大化窗口
    Send, {LWin Down}{Up}{LWin Up}
}
Return

^Space::Send, {LWin Down}{Space}{LWin Up}
#q::WinClose, A


#Enter::
SetTitleMatchMode, 2  ; 设置窗口标题匹配模式为部分匹配
IfWinExist, PowerShell
{
    WinActivate  ; 激活现有的PowerShell窗口
}
else
{
    Run, powershell  ; 打开一个新的PowerShell窗口
}
return

; 快速移动窗口到屏幕边缘
#+h::WinMove, A,, 0, 0, A_ScreenWidth / 2, A_ScreenHeight  ; 移动到屏幕左半部
#+l::WinMove, A,, A_ScreenWidth / 2, 0, A_ScreenWidth / 2, A_ScreenHeight  ; 移动到屏幕右半部

; 模拟 Alt+Tab
#j::Send, {Alt Down}{Tab}{Alt Up}
; 模拟 Shift+Alt+Tab  
#k::Send, {Alt Down}{Shift Down}{Tab}{Shift Up}{Alt Up}  


#XButton1::
    ;按 Win+鼠标后退 快速后退桌面
    Send, ^#{Left}
Return

#XButton2::
    ;按 Win+鼠标前进 快速前进桌面
    Send, ^#{Right}
Return

;Win+M shortcut to minimize the active window
#m::WinMinimize, A

#IfWinActive ahk_exe msedge.exe

    ^p::Send, ^+{Tab}  ; Ctrl+P 映射到 Ctrl+Shift+Tab，切换到上一个标签
    ^n::Send, ^{Tab}   ; Ctrl+N 映射到 Ctrl+Tab，切换到下一个标签

#IfWinActive  ; 重置条件，以便快捷键仅在指定窗口生效


; 重新加载AutoHotkey脚本
#+r::Reload  
