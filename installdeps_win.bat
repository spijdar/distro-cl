rem This is very imperfect, since it assumes a lot of stuff is done by hand
rem But its a start
rem based heavily on hiili's instructions at https://github.com/torch/torch7/wiki/Windows#using-visual-studio

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

"C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"
set "PATH=%PATH%;C:\Program Files (x86)\CMake\bin"

powershell Set-ExecutionPolicy unrestricted

rem install cmder
cd /d "%USERPROFILE%\Downloads"
powershell.exe -Command (new-object System.Net.WebClient).DownloadFile('https://github.com/cmderdev/cmder/releases/download/v1.3.0/cmder_mini.zip', 'cmder_mini.zip')
if errorlevel 1 exit /B 1
mkdir cmder
cd cmder
"c:\program files\7-Zip\7z.exe" x ..\cmder_mini.zip
if errorlevel 1 exit /B 1

rem install msys2 x64
cd /d "%USERPROFILE%\Downloads"
powershell.exe -Command (new-object System.Net.WebClient).DownloadFile('https://sourceforge.net/projects/msys2/files/Base/x86_64/msys2-base-x86_64-20160205.tar.xz/download', 'msys2-base-x86_64-20160205.tar.xz')
if errorlevel 1 exit /B 1
"c:\program files\7-Zip\7z.exe" x msys2-base-x86_64-20160205.tar.xz
if errorlevel 1 exit /B 1
"c:\program files\7-Zip\7z.exe" x msys2-base-x86_64-20160205.tar
if errorlevel 1 exit /B 1
cd msys64
start "msyssetup" msys2_shell.bat
rem this will spawn a window, and lazily leave it open.  Not sure if there's a way to give the shell an 'exit' command?
rem -c "exit"   ?
start "msyssetup" msys2_shell.bat -c "pacman -Sy git tar make mingw-w64-x86_64-gcc mingw-w64-x86_64-gcc-fortran"
rem this will ask you to confirm with 'y' for now.  not sure if there is a way of suppressing this question?

rem install lapack
cd /d "%USERPROFILE%\Downloads"
powershell.exe -Command (new-object System.Net.WebClient).DownloadFile('http://www.netlib.org/lapack/lapack-3.6.1.tgz', 'lapack-3.6.1.tgz')
if errorlevel 1 exit /B 1
"c:\program files\7-Zip\7z.exe" x lapack-3.6.1.tgz
if errorlevel 1 exit /B 1
"c:\program files\7-Zip\7z.exe" x lapack-3.6.1.tar
if errorlevel 1 exit /B 1

rem rem this bit differs from hilli's build, because it uses msvc, rather than msys.  not sure if this is a good idea or
rem rem not???
rem cd lapack-3.6.1
rem mkdir build
rem cd build
rem cmake .. -G "Visual Studio 14 2015 Win64" -DCMAKE_INSTALL_PREFIX=%USERPROFILE%\Downloads\lapack-3.6.1\dist
rem rem oh I see, needs fortran compiler :-P


