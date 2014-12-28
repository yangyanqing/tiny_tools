@ECHO OFF

SET reg_file=svn_diff.reg
SET bat_file=svn_diff.bat

:: ���� svn.exe ·��
ECHO Searching path of svn.exe ...
SET  svn_path=
FOR /F "usebackq tokens=*" %%I IN (`which svn.exe ^| sed "s@/cygdrive/\(.\)@\1:@g;s@/@\\\\@g"`) DO SET svn_path=%%~dpI

:: ������������˳�
IF "%svn_path%" == "" (
    ECHO Can't find svn.exe in %%PATH%%, please install command line svn first.
    PAUSE
    GOTO :eof
)
ECHO     %svn_path%

:: �����������ļ�
ECHO Copy %bat_file% to %svn_path% ...
copy %bat_file% "%svn_path%"

:: ����ע����ļ�
ECHO Generate register file ...
ECHO Windows Registry Editor Version 5.00>%reg_file%
ECHO [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shell\SvnDiff]>>%reg_file%
ECHO @="SVN Diff">>%reg_file%
ECHO [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shell\SvnDiff\command]>>%reg_file%
ECHO @="cmd.exe /c \"%svn_path:\=\\%%bat_file%\" %%1 result">>%reg_file%

:: ����ע����ļ�
ECHO Regist %bat_file% to PopMenu ...
regedit /s %reg_file%

ECHO Done!
Pause
