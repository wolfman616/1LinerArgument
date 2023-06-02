#noenv
#include C:\Program Files\Autohotkey\LiB\quote.ahk
if(a_args[1])
	run,% "C:\Apps\filetypesman-x64\FileTypesMan.exe /SelectedExt " . quote("." (splitpath(a_args[1])).ext) 
return,