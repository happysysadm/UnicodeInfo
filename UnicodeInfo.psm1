#Dot source all functions in all ps1 files located in the UnicodeModule folder
Get-ChildItem -Path \\server\c$\Admin\Scripts\Modules\UnicodeInfo\*.ps1
ForEach-Object {
    . $_.FullName
}