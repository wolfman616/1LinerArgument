#NoEnv 
menu,tray,icon,% "C:\Icon\24\Gterminal_24_32.ico"
; #IfTimeout,200 ;* DANGER * : Performance impact if set too low. *think about using this*.
; ListLines,Off  THis executor was written to run numerous .bak
#persistent 
#Singleinstance,	Force
DetectHiddenWindows,On
DetectHiddenText,	On
SetTitleMatchMode,	2
SetTitleMatchMode,	Slow
Setworkingdir,% (splitpath(A_AhkPath)).dir
SetBatchLines,		-1
SetWinDelay,		-1
coordMode,	ToolTip,Screen
coordmode,	Mouse,	Screen
OnMessage(0x404,"AHK_NOTIFYICON")
OnMessage(0x0101,"wmKeyUp")
loop,parse,% "VarZ,MenuZ",`,
	 gosub,% a_loopfield
global _:= " ", Pipes:= {}
, ScriptUNC:= (A_Args[1]? A_Args[1] : "C:\Users\ninj\Desktop11\gay.bak")
(!PtrP? global PtrP:= A_IsUnicode?	"UPtr*" : "UInt*")
  ,(!Ptr? Ptr:= A_IsUnicode? "Ptr"	: "UInt")
   ,char_size:= A_IsUnicode? 2 : 1
pipe(ScriptUNC)
return,

CreateNamedPipe(Name,OpenMode=3,PipeMode=0,MaxInstances=255) {
	return,dllcall("CreateNamedPipe","str","\\.\pipe\" Name,"uint",OpenMode
	,"uint",PipeMode,"uint",MaxInstances,"uint",0,"uint",0,"uint",0,"uint",0)
}

getPipePiD(byref pipe_n) {
	Sleep(3000), hw:= winexist(ad:= ("\\.\pipe\" . pipe_n))
	winget,pid,PID,Ahk_id %hw%
	return,pid
}

ProcPath(PiDhWnd="") {
	(PiDhWnd="")?PiDhWnd:= DllCall("GetCurrentProcessId") : ()
	Process,Exist,% PiDhWnd
	if(errorlevel)
		winget,ProcPath,processpath,AhK_PiD %PiDhWnd%
	else,winget,ProcPath,processpath,AhK_iD %PiDhWnd%
	return,ProcPath
}

Pipe(filename="",ahkexe="") {
	global
	pipe_ga:= ""
	(filename="")? filename:= a_scriptfullpath : ()
	(ahkexe="")? ahkexe:= quote(ProcPath()) : ()
	 static pipe:= A_Tickcount
	, pip2:= pipe . 1
	;ahkexe:= (%bLabel%).exe
	local pipe_name:= a_now ;splitpath(filename).fn  ;a_now ;pipe_name:= "'" MyTab . "'" . " - " .AHK_Portable;

	if(aca:= winexist(_:= "\\.\pipe\" . pipe_name))
	loop,
		if(aca:= winexist(_:= "\\.\pipe\" .  pipe_name .  A_index))
			msgbox,% result "`n" pipe_name "`n" aca " taken"
		else,break,
	pipe_name.=A_index
	msgbox % GI:= (ahkexe . " " . CHR(34) . "\\.\pipe\" . pipe_name .  CHR(34))
	(%pip2%):= CreateNamedPipe(pipe_name,2) ; "PIPE-Name" ; AHK calls GetFileAttributes()
	(%pipe%):= CreateNamedPipe(pipe_name,2) ; <=>=> So,Closepipe,& Create 2nd pipe.
	if(!((%pipe%)=-1||(%pip2%)=-1)) {
		run,% GI,"C:\Program Files\Autohotkey",,ppidd
		dllcall("ConnectNamedPipe",	ptr,pipe_ga,ptr,0)
		dllcall("CloseHandle",ptr,	pipe_ga)
		dllcall("ConnectNamedPipe",	ptr,(%pipe%),ptr,0)
		TxtNew:= file2var(filename)
		Script:= (A_IsUnicode?	chr(0xfeff)	: chr(239) chr(187) chr(191)) . "#persistent`n" . TxtNew
		char_size:= (A_IsUnicode?	2:1)
		sleep,400 ; v-important ;
		(!Dllcall("WriteFile",ptr, %pipe%,"str",Script,"uint",(StrLen(Script)+1)*char_size,"uint*",0,ptr,0)
		? MsgB0x("WriteFile failed: " ErrorLevel "/" A_LastError) : Pipes.push({ "name" : a:=pipe_name, "hWnd" : b:=(ppidd)}))
		dllcall("CloseHandle",ptr,(%pipe%))
		ppid:= getPipePiD(pipe_name)
		return,ppid
	; } else,exitapp(msgB0x("Fail","CreateNamedPipe failed.",4))
	} else,msgBox,"Fail","CreateNamedPipe failed.",4)
}
guiescape:
~escape::
exitapp
menutray() {
	Menu,Tray,Show
}

menuz:
menu,Tray,NoStandard
menu,Tray,Add,%	 splitpath(A_scriptFullPath).fn,% "do_nothing"
menu,Tray,disable,% splitpath(A_scriptFullPath).fn
menu,Tray,Add ,% "Open",%		"MenHandlr"
menu,Tray,Icon,% "Open",%		"C:\Icon\24\Gterminal_24_32.ico"
menu,Tray,Add ,% "script dir",%	"MenHandlr"
menu,Tray,Icon,% "script dir",%	"C:\Icon\24\explorer24.ico"
menu,Tray,Add ,% "Edit",%		"MenHandlr"
menu,Tray,Icon,% "Edit",%		"C:\Icon\24\explorer24.ico"
menu,Tray,Add ,% "Reload",%		"MenHandlr"
menu,Tray,Icon,% "Reload",%		"C:\Icon\24\eaa.bmp"
menu,Tray,Add,%	 "Suspend",%	"MenHandlr"
menu,Tray,Icon,% "Suspend",%	"C:\Icon\24\head_fk_a_24_c1.ico"
menu,Tray,Add,%	 "Pause",%		"MenHandlr"
menu,Tray,Icon,% "Pause",%		"C:\Icon\24\head_fk_a_24_c2b.ico"
menu,Tray,Add ,% "Exit",%		"MenHandlr"
menu,Tray,Icon,% "Exit",%		"C:\Icon\24\head_fk_a_24_c2b.ico"
msgb0x((ahkexe:= splitpath(A_AhkPath)).fn
,	 (_:= (splitpath(A_scriptFullPath).fn) " Started`n@ " time4mat() "   In:  "
.	_:= (a_tickCount-a_scriptStartTime) " Ms"),3)
sleep,100
a_scriptStartTime:= time4mat(a_now,"H:m - d\M")
_:=""
menu,Tray,Tip,% splitpath(A_scriptFullPath).fn "`nRunning, Started @`n" a_scriptStartTime
do_nothing:
return,

MenHandlr(isTarget="") {
	listlines,off
	switch 	(isTarget=""? a_thismenuitem : isTarget) {
		case "script-dir": TT("Opening "   a_scriptdir "..." Open_Containing(A_scriptFullPath),1)
		case "edit","Open","SUSPEND","pAUSE":
			PostMessage,0x0111,(%a_thismenuitem%),,,% A_ScriptName " - AutoHotkey"
		case "RELOAD": reload()
		case "EXIT": exitapp
		default: islabel(a_thismenuitem)? timer(a_thismenuitem,-10) : ()
	}	
	return,1
}

AHK_NOTIFYICON(byref wParam="",byref lParam="",b1="",br="",bb="") {
	;	tt("wparam -" wParam "`nlparam - " lParam "`n3 - " b1 "`n4 - " br "`n5 - " bb,"tray",5)
	switch,lParam {
	;	case 0x0206: ; WM_RBUTTONDBLCLK	;	case 0x020B: ; WM_XBUTTONDOWN
	;	case 0x0201: ; WM_LBUTTONDOWN	;	case 0x0202: ; WM_LBUTTONUP
		case,0x0204: settimer,menutray,-20
			return, ;WM_RBUTTONdn;
		case,0x0203: tt("Loading...","Tray",1.5)
			PostMessage,0x0111,%Open%,,,% a_scriptname " - AutoHotkey"
			return, ; WM_doubleclick  
		case,0x101: msgbox 101
		case,512: mp:= mPosGet()
			tt("e88t`n2w42",mp.x-56,mp.y-64)
		return,
	}
	return,
}

mPosGet() {
	static init:=0, o
	(init=0? o:={},init:=1)
	mousegetpos,x,y,hwnd,cwnd,2
	return,o.push({"x" 	: x ,		"y"	: y
			  , "hwnd"	: hwnd,	 "cwnd"	: cwnd})
}

wmKeyUp(byref wParam="",byref lParam="",b1="",br="",bb="") {
	tt("wmKeyUp`nwparam -" wParam "`nlparam - " lParam "`n3 - " b1 "`n4 - " br "`n5 - " bb,"tray",5)
	switch,lParam {
	;	case,0x0206: ; WM_RBUTTONDBLCLK	;	case 0x020B: ; WM_XBUTTONDOWN
	;	case,0x0201: ; WM_LBUTTONDOWN	;	case 0x0202: ; WM_LBUTTONUP
		case,0x0204: settimer,menutray,-20
			return, ;WM_RBUTTONdn;
		case,0x0203: tt("Loading...","Tray",1.5)
			PostMessage,0x0111,%Open%,,,% a_scriptname " - AutoHotkey"
			return, ; WM_doubleclick  
	}
	return,
} 

File2Var(Path,ByRef Var="",Type="#10") { 
	VarSetCapacity(Var,128),VarSetCapacity(Var,0)
	if(!A_IsCompiled) {
		FileGetSize,nSize,%Path%
		; FileRead,Var,*c %Path%
		FileRead,Var,%Path%
		Return,Var
	}
	If(hMod:= DllCall("GetModuleHandle",UInt,0))
		If(hRes:= DllCall("FindResource",UInt,hMod,Str,Path,Str,Type)) ;RCDATA = #10
			If(hData:= DllCall("LoadResource",UInt,hMod,UInt,hRes))
				If(pData:= DllCall( "LockResource",UInt,hData)) {
					VarSetCapacity(Var,nSize:= DllCall( "SizeofResource",UInt,hMod,UInt,hRes))
				,	DllCall("RtlMoveMemory",Str,Var,UInt,pData,UInt,nSize)
					return,byref Var
				}
	Return,0
}

Varz:
ID_VIEW_VARIABLES:
global Edit:= 65304, Open:= 65407, Suspend:= 65305, Pause:= 65306, Exit:= 6530
, This_PiD:= DllCall("GetCurrentProcessId")
return,


reload() {
	reload,
	exitapp,
}