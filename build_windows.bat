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
rem - cmder lite installed at "%USERPROFILE%\Downloads\cmder"
rem
rem Target build:
rem - windows 64 bit
rem - cpu architecture etc on a g2.2xlarge ec2 box
rem
rem environment:
rem - jenkins slave
rem - running out of a job/workspace directory
rem - on C: drive, eg c:\jenkins\workspace\[job name]
rem - we are in a directory containing this (distro-win) already cloned, by virtue of the jenkins job bringing it down
rem - to simulate this enviornment, open a cmd, and run:
rem
rem     git clone --recursive https://github.com/hughperkins/distro -b distro-win torch
rem     cd torch

rem based heavily/entirely on what hiili wrote at https://github.com/torch/torch7/wiki/Windows#using-visual-studio

"C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"
set "PATH=%PATH%;C:\Program Files (x86)\CMake\bin"

set "BASE=%CD%"
echo BASE: %BASE%

echo luajit-rocks
git clone https://github.com/torch/luajit-rocks.git
cd luajit-rocks
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=%BASE%/install -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release
nmake
cmake -DCMAKE_INSTALL_PREFIX=%BASE%/install -G "NMake Makefiles" -P cmake_install.cmake -DCMAKE_BUILD_TYPE=Release
