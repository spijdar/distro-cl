env

cd "${SOFT}"

cd lapack-3.6.1
mkdir build
cd build
"C:\Program Files (x86)\CMake\bin\cmake" .. "-DCMAKE_INSTALL_PREFIX=${BASE}/lapack" -G "MSYS Makefiles" -DBUILD_SHARED_LIBS=1 -DCMAKE_GNUtoMS=1 1 -DCMAKE_Fortran_COMPILER=/mingw64/bin/x86_64-w64-mingw32-gfortran.exe
make
make install

touch "${SOFT}/lapack_done.flg"
