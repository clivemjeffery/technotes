<job>
<script language="VBScript">

Option Explicit

Dim valUserIn
Dim objShell, RegLocate, RegLocate1
Dim objRemXML
Dim objMyIP
Dim strIPAddress
Dim strHostname
Dim strHomeDomain

On Error Resume Next

Set objShell = WScript.CreateObject("WScript.Shell")
On Error Resume Next

Set objRemXML = CreateObject("Microsoft.XMLDOM")
objRemXML.async = False
objRemXML.load(cstrShowMyIP)

' Get our IP address
Set objMyIP = objRemXML.selectSingleNode("/ip_address/ip")
strIPAddress = objMyIP.text

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

  objShell.RegWrite regKeyProxyServer, "172.20.24.1:8080", "REG_SZ"
  objShell.RegWrite regKeyProxyEnable, "1", "REG_DWORD"
  MsgBox "Langton Road proxy is set."

else

  objShell.RegWrite regKeyProxyServer,"0.0.0.0:80","REG_SZ"
  objShell.RegWrite regKeyProxyEnable,"0","REG_DWORD"

  MsgBox "School proxy disabled. Should work OK at home."

end if

' Finish
Set objMyIP = Nothing
Set objRemXML = Nothing

WScript.Quit

</script>
</job>
