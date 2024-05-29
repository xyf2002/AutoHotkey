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
global minimized := {}  ; 用于存储窗口是否被最小化的状态


;win+M 
#m::WinMinimize, A




; 如果当前窗口是 Windows Terminal
#IfWinActive ahk_class CASCADIA_HOSTING_WINDOW_CLASS

; 将 Win+V 映射为 Alt+V
#v::Send !v

; 将 Win+H 映射为 Alt+H
#h::Send !h

; 将 Win+Q 映射为 Ctrl+D
#q::Send ^d

; 将 Win+Enter 映射为 Alt+V
#Enter::Send !v

; 结束 IfWinActive 块
#IfWinActive

; 重新加载AutoHotkey脚本
#+r::Reload  
