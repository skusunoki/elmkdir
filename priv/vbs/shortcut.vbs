Option Explicit
Dim fso, ws, link_target, link_place, link_name, shortcut

Set fso = CreateObject("Scripting.FileSystemObject")
Set ws = CreateObject("WScript.Shell")

link_place = Wscript.Arguments(0)
link_target = Wscript.Arguments(1)
link_name = Wscript.Arguments(2)

Set shortcut = ws.CreateShortcut(link_place & "\" & link_name & ".lnk")

With shortcut
    .TargetPath = link_target
    .WorkingDirectory = link_place
    .Save
End With