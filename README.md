# 1LinerArgument
currently using AHK-H_v1
shell argument concatenator with invoketime code execution via ahk_H
Calculate simple asrguments in the same breath as invoking them.
such as NIRsoft FiletypesMan doesnt support "%1" argument to derrive the desired target extension.
We can simply call a splitpath around the argument in our call, as follows:

"C:\Program Files\Autohotkey\ahk_H_x64w\AutoHotkey.exe" "C:\Script\AHK\- _ _ LiB\1LinerArgPasser.ahk" "%l" "C:\Apps\filetypesman-x64\FileTypesMan.exe /SelectedExt " "chr(34) chr(0x2e) u:=(pth(args1)).ext chr(34)" "
resulting in the application receiving any of extensions handled in the class-nodes, i have the script registered for HKCR\\AllFileSystemObjects. It is quite a common oversight in numerous CLI tools for there to be any type of mental connection to the environment and the problems commonly sought to be solved by said application. (such as a pouplar developers enaction of an extension management utility which cannot natively percieve any targetted directions.)
todo: refactor logic to run the command through a piped ahkl instance, negating the necessity to use AHKH.
