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



