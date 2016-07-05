#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
1::
   clipboard =
   Send ^c
   ClipWait
   FileAppend, %clipboard%++, %A_ScriptDir%\text.txt
Return
2::
   FileAppend, NULL++, %A_ScriptDir%\text.txt
Return
1 & 2::
   clipboard =
   Send ^c
   ClipWait
   FileAppend, %clipboard%\, %A_ScriptDir%\text.txt
Return
2 & 1::
   FileAppend, NULL\, %A_ScriptDir%\text.txt
   FileRead, Str, %A_ScriptDir%\text.txt
   StringReplace Str,Str,+,+,UseErrorLevel
   colo= %ErrorLevel%
   FileRead, Str, %A_ScriptDir%\text.txt
   StringReplace Str,Str,\,\,UseErrorLevel
   semic= %ErrorLevel%
   if((colo/2)/semic=7){
	Msgbox approved
   }
   else{
   	Msgbox fail
   }
Return
3::
   FileRead, Str, %A_ScriptDir%\text.txt
   StringReplace Str,Str,§,§,UseErrorLevel
   colo= %ErrorLevel%
   FileRead, Str, %A_ScriptDir%\text.txt
   StringReplace Str,Str,\,\,UseErrorLevel
   semic= %ErrorLevel%
   if(colo/semic=7){
	Msgbox approved
   }
   else{
   	Msgbox fail
   }
