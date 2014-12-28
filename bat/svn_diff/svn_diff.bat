@echo off

setlocal enabledelayedexpansion

set wc_path=%~f1
set result_path=%~f2
set old_path=%result_path%\old
set new_path=%result_path%\new

call :strlen %wc_path%
set /a wc_len=%strlen%
set /a wc_len=%wc_len%+1

if not exist %wc_path% (
    echo SVN root path %wc_path% does not exist ...
    exit 1
)

if exist %result_path% (
    echo Remove %result_path% ...
    rd /S /Q %result_path%
)
mkdir %old_path%
mkdir %new_path%

:: 获取SVN路径
for /F "tokens=2" %%i in ('svn info %wc_path% ^| findstr /B URL') do (
    set url_path=%%i
)

:: 获取新增文件列表
for /F "tokens=1,2" %%i in ('svn st %wc_path%') do (
    if "%%i" == "A" (
        call :copy_new_file %%i %%j
    )

    if "%%i" == "?" (
        call :copy_new_file %%i %%j
    )

    if "%%i" == "M" (
        call :copy_new_file %%i %%j
        call :export_svn_file %%i %%j
    )

    if "%%i" == "D" (
        call :export_svn_file %%i %%j
    )

    if "%%i" == "!" (
        call :export_svn_file %%i %%j
    )
)

goto :end

::-----------------------------------------------------------------------------

:copy_new_file
    set status=%1
    set file=%2
    call :substr %~dp2 %wc_len%
    set dst_path=%new_path%\%substr%
    
    echo Copy   [%status%] %file% to result\new ...
    if not exist %dst_path% mkdir %dst_path%
    copy %file% %dst_path% 1>nul
    goto :eof

::-----------------------------------------------------------------------------

:export_svn_file
    set status=%1
    set file=%2
    call :substr %~dp2 %wc_len%
    set dst_path=%old_path%\%substr%
    call :substr %2 %wc_len%
    set abs_file=%substr:\=/%
    
    echo Export [%status%] %file% to result\old ...
    if not exist %dst_path% mkdir %dst_path%
    svn export %url_path%/%abs_file% %dst_path% 1>nul
    goto :eof
    
::-----------------------------------------------------------------------------    
    
:strlen
    set input=%1
    for /l %%i in (0,1,1000) do if "!input:~%%i,1!"=="" set strlen=%%i && goto :end_for_strlen
    :end_for_strlen
    goto :eof    

::-----------------------------------------------------------------------------

:substr
    set substr=%1
    set /a loop=%2
:substr_loop
    set substr=%substr:~1%
    set /a loop=%loop%-1
    if %loop% neq 0 goto :substr_loop
    goto :eof

::-----------------------------------------------------------------------------
   
:end    
    
:: 获取当前路径
:: for /F %%i IN ('cd') do set cur_path=%%i

::echo %cur_path%
endlocal