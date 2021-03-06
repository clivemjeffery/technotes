Option Explicit

Dim objShell
Dim strIPAddress
Dim strDomain
Dim NetworkAdapters, Nic

Set objShell = WScript.CreateObject("WScript.Shell")

' Find enabled ip address
Set NetworkAdapters = GetObject("winmgmts:").InstancesOf("Win32_NetworkAdapterConfiguration")
For Each Nic in NetworkAdapters
  if Nic.IPEnabled then
    strIPAddress = Nic.IPAddress(0)
  End if
Next
' Identify location using first 6 characters of ip address (enough to distinguish)
strDomain = Left (strIPAddress,6)

Const regKeyProxyServer = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyServer"
Const regKeyProxyEnable = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyEnable"
If strDomain = "172.23" Then
  ' Grove Street
  objShell.RegWrite regKeyProxyServer, "172.23.56.3:8080", "REG_SZ"
  objShell.RegWrite regKeyProxyEnable, "1", "REG_DWORD"
  MsgBox "Grove Street proxy is set."

ElseIf strDomain = "172.20" Then
  ' Langton Road
  objShell.RegWrite regKeyProxyServer, "172.20.24.1:8080", "REG_SZ"
  objShell.RegWrite regKeyProxyEnable, "1", "REG_DWORD"
  MsgBox "Langton Road proxy is set."

Else
  ' Elsewhere
  objShell.RegWrite regKeyProxyServer,"0.0.0.0:80","REG_SZ"
  objShell.RegWrite regKeyProxyEnable,"0","REG_DWORD"

  MsgBox "School proxies disabled. Should work OK at home."

End If

' Finish
Set objShell = Nothing
WScript.Quit
