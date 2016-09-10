set "PATH=%PATH%;C:\Program Files (x86)\CMake\bin"

if %1 == -E  (
cmake.exe  %* 
) else (
cmake.exe -G "NMake Makefiles" -DCMAKE_LINK_FLAGS:implib=libluajit.lib -DLUALIB=libluajit %*
)
