
				#noenv
				#persistent
		  SetKeyDelay,	-1
		  SetWinDelay,	-1
		SetBatchlines,	-1
	  SetControlDelay,	-1
	Settitlematchmode,	2
	Settitlematchmode,	Slow
  DetectHiddenWindows,	On
	 DetectHiddenText,	On
	 SendMode,	Input
	  CoordMode,Mouse,	Screen
	  CoordMode,Pixel,	Screen
	  CoordMode,Tooltip,Screen
#include C:\Script\AHK\- _ _ LiB\quote.ahk

#include C:\Script\AHK\- _ _ LiB\AhkDllThread.ahk 
ahk_H_DLL:= "C:\Program Files\Autohotkey\ahk_H_x64w\AutoHotkey.dll"
(dll:= AhkDllThread(ahk_H_DLL)).ahktextdll("
(
#noenv
#persistent
#include C:\Script\AHK\- _ _ LiB\quote.ahk 
args1:= " quote(A_args[1]) "
qq:= " quote(a_args[2]) "
q:= " a_args[3] "
run,% qq.= q
settimer,qqq,-1000
return,

pth(Path) {
 SplitPath,Path,,D,Ext,NameNoExt,Drive
	return,y:= ({""Dir""	: D
	,			 ""Ext""	: Ext
	,			 ""Drv""	: Drive
	,			 ""FN""	: NameNoExt
	,			 ""Name""	: NameNoExt
	,		""NameNoExt""	: NameNoExt
	,			 ""Path""	: Path })
}
qqq:
exitapp,
)")

r_pid:= DllCall("GetCurrentProcessId")
loop,100
	if(dllhwnd:= winexist(a_scriptname " ahk_class AutoHotkey",,"ahk_pid " r_pid))
		break,
	else,sleep,100
if(!dllhwnd)
	msgbox,% "fail"
settimer,qqq,-3000

return,

pth(Path ) {
 SplitPath,Path,,D,Ext,NameNoExt,Drive
	return,y:= ({"Dir"	: D
	,			 "Ext"	: Ext
	,			 "Drv"	: Drive
	,			 "FN"	: NameNoExt
	,			 "Name"	: NameNoExt
	,		"NameNoExt"	: NameNoExt
	,			 "Path"	: Path })
}

qqq:
exitapp,