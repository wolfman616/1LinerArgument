/*
here is a mono purpose script to call extension arguments to FileTypesMan by Nirsoft
which for some unknown reason will not accept a file path as an argument to load in the relevant extension via context menu.
from the documentation of Nir:

call only like this... FileTypesMan.exe /SelectedExt ".txt" 
script to provide argument with extension after a dot within quotes
{
	#noenv
	#include C:\Program Files\Autohotkey\LiB\quote.ahk
	if(a_args[1])
		run,% "C:\Apps\filetypesman-x64\FileTypesMan.exe /SelectedExt " . quote("." (splitpath(a_args[1])).ext) 
	return,
}

This lead me to have the idea to opene endedly be able to coerse some simple but unusual arguments for these occasions.

registry shell command as follows:

"C:\Program Files\Autohotkey\ahk_H_x64w\AutoHotkey.exe" "C:\Script\AHK\- _ _ LiB\1LinerArgPasser.ahk" "%l" "C:\Apps\filetypesman-x64\FileTypesMan.exe /SelectedExt " "chr(34) chr(0x2e) u:=(pth(args1)).ext chr(34)" "

requires ahk_H. to run string back as code, but could also be done via pipe.
*/
				#noenv
		  SetWinDelay,	-1
		SetBatchlines,	-1
	Settitlematchmode,	2
	Settitlematchmode,	Slow
  DetectHiddenWindows,	On
	 DetectHiddenText,	On
#include C:\Script\AHK\- _ _ LiB\quote.ahk
#include C:\Script\AHK\- _ _ LiB\AhkDllThread.ahk 
(dll:= AhkDllThread(ahk_H_DLL:= "C:\Program Files\Autohotkey\ahk_H_x64w\AutoHotkey.dll")).ahktextdll("
(
#noenv
#include C:\Script\AHK\- _ _ LiB\Quote.ahk
args1:= " quote(A_args[1]) "
qq:= " quote(a_args[2]) "
q:= " a_args[3] "
run,% qq.= q
exitapp,

Pth(Path="""")) {
 SplitPath,Path,,D,Ext,NameNoExt,Drive
	return,y:= ({""Dir""	: D
	,			 ""Ext""	: Ext
	,			 ""Drv""	: Drive
	,			 ""FN""		: NameNoExt
	,			 ""Name""	: NameNoExt
	,		""NameNoExt""	: NameNoExt
	,			 ""Path""	: Path })
}
)")

loop,100
	if(dllhwnd:= winexist(a_scriptname " ahk_class AutoHotkey",,"ahk_pid " r_pid:= DllCall("GetCurrentProcessId")))
		break,
	else,sleep,100
if(!dllhwnd)
	msgbox,% "fail"
exitapp,

Pth(Path="") {
 SplitPath,Path,,D,Ext,NameNoExt,Drive
	return,y:= ({"Dir"	: D
	,			 "Ext"	: Ext
	,			 "Drv"	: Drive
	,			 "FN"	: NameNoExt
	,			 "Name"	: NameNoExt
	,		"NameNoExt"	: NameNoExt
	,			 "Path"	: Path })
}