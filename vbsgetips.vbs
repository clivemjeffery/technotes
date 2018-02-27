
Option Explicit
Dim NIC1, Nic, StrIP, CompName, i, WshNetwork

Set NIC1 =     GetObject("winmgmts:").InstancesOf("Win32_NetworkAdapterConfiguration")

For Each Nic in NIC1

    if Nic.IPEnabled then
        StrIP = Nic.IPAddress(0)

        Set WshNetwork = WScript.CreateObject("WScript.Network")
        CompName= WshNetwork.Computername

        MsgBox i
        MsgBox "IP Address:  " & StrIP & vbNewLine _
            & "Computer Name:  " & CompName, 4160, "IP Address and Computer Name"


    End if
Next
wscript.quit
