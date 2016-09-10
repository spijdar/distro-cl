rem This is very imperfect, since it assumes a lot of stuff is done by hand
rem But its a start
rem based heavily on hiili's instructions at https://github.com/torch/torch7/wiki/Windows#using-visual-studio

rem assumptions:
rem - ec2 windows 2012 r2 default box (eg ami-281ad849, or equivalent, in ec2, click 'Launch' and select
rem   'Microsoft Windows Server 2012 R2 Base', from 'Quick Start')
rem - visual studio 2015 community installed, in default location:
rem    C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat
rem    (includes nmake)
rem - cmake installed at C:\Program Files\CMake\bin\cmake.exe (cmake-3.6.2-win64-x64)
rem - msys git available at C:\Program Files\Git (git-2.9.2 64-bit?)
rem     (seems to be added to PATH)
rem - python 3.5 is available at c:\py35-64 (python 3.5.2-amd64)
rem - cygwin64 available at c:\cygwin64
rem - 7zip available at C:\Program Files\7-Zip\7z.exe (7z920-x64 ?)
rem - powershell available
rem
rem Target build:
rem - windows 64 bit
rem - cpu architecture etc on a g2.2xlarge ec2 box

"C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"
set "PATH=%PATH%;C:\Program Files\CMake\bin"

powershell Set-ExecutionPolicy unrestricted

mkdir C:\Downloads
set DOWNLOADS=C:\Downloads

rem install cmder
cd /d "%DOWNLOADS%"
powershell.exe -Command (new-object System.Net.WebClient).DownloadFile('https://github.com/cmderdev/cmder/releases/download/v1.3.0/cmder_mini.zip', 'cmder_mini.zip')
if errorlevel 1 exit /B 1
mkdir cmder
cd cmder
"c:\program files\7-Zip\7z.exe" x ..\cmder_mini.zip
if errorlevel 1 exit /B 1

rem install msys2 x64
cd /d "%DOWNLOADS%"
powershell.exe -Command (new-object System.Net.WebClient).DownloadFile('https://sourceforge.net/projects/msys2/files/Base/x86_64/msys2-base-x86_64-20160205.tar.xz/download', 'msys2-base-x86_64-20160205.tar.xz')
if errorlevel 1 exit /B 1
"c:\program files\7-Zip\7z.exe" x msys2-base-x86_64-20160205.tar.xz
if errorlevel 1 exit /B 1
"c:\program files\7-Zip\7z.exe" x msys2-base-x86_64-20160205.tar >nul
if errorlevel 1 exit /B 1
cd msys64
cmd /c msys2_shell.bat -c "exit"
rem poor man's sleep:
ping -n 20 127.0.0.1
rem really we should someone monitor the process thats running, and wait for it to finish
cmd /c msys2_shell -c "pacman -Sy pacman --noconfirm"
ping -n 20 127.0.0.1
cmd /c msys2_shell -c "pacman -Syu pacman --noconfirm"
ping -n 20 127.0.0.1
cmd /c msys2_shell -c "pacman -Sy git tar make mingw-w64-x86_64-gcc mingw-w64-x86_64-gcc-fortran --noconfirm"
ping -n 60 127.0.0.1
ping -n 60 127.0.0.1
