Option Explicit

Dim objShell
Dim strIPAddress
Dim strDomain
Dim NetworkAdapters, Nic

' Find enabled ip address
Set NetworkAdapters = GetObject("winmgmts:").InstancesOf("Win32_NetworkAdapterConfiguration")
For Each Nic in NetworkAdapters
  if Nic.IPEnabled then
    strIPAddress = Nic.IPAddress(i)
  End if
Next

' Print info
WScript.Echo "IP address : " & strIPAddress

strDomain = Left (strIPAddress,6)

Const regKeyProxyServer = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyServer"
Const regKeyProxyEnable = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyEnable"
If strDomain = "172.23" then
  ' Grove Street
  objShell.RegWrite regKeyProxyServer, "172.23.56.3:8080", "REG_SZ"
  objShell.RegWrite regKeyProxyEnable, "1", "REG_DWORD"
  MsgBox "Grove Street proxy is set."

elseif strDomain = "172.20"
  ' Langton Road
  objShell.RegWrite regKeyProxyServer, "172.20.24.1:8080", "REG_SZ"
  objShell.RegWrite regKeyProxyEnable, "1", "REG_DWORD"
  MsgBox "Langton Road proxy is set."

else
  ' Elsewhere
  objShell.RegWrite regKeyProxyServer,"0.0.0.0:80","REG_SZ"
  objShell.RegWrite regKeyProxyEnable,"0","REG_DWORD"

  MsgBox "School proxies disabled. Should work OK at home."

end if

' Finish
Set objMyIP = Nothing
WScript.Quit
