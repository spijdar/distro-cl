rem This is very imperfect, since it assumes a lot of stuff is done by hand
rem But its a start

rem assumptions:
rem - ec2 windows 2012 r2 default box (eg ami-281ad849, or equivalent, in ec2, click 'Launch' and select
rem   'Microsoft Windows Server 2012 R2 Base', from 'Quick Start')
rem - visual studio 2015 community installed, in default location:
rem    C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat
rem    (includes nmake)
rem - cmake installed at C:\Program Files (x86)\CMake\bin\cmake.exe (3.2.2 x86?)
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

powershell Set-ExecutionPolicy unrestricted

rem install cmder
cd /d "%USERPROFILE%\Downloads"
powershell.exe -Command (new-object System.Net.WebClient).DownloadFile('https://github.com/cmderdev/cmder/releases/download/v1.3.0/cmder_mini.zip', 'cmder_mini.zip')
if errorlevel 1 exit /B 1
mkdir cmder
cd cmder
"c:\program files\7-Zip\7z.exe" x ..\cmder_mini.zip
if errorlevel 1 exit /B 1

