echo SOFT $SOFT
echo BASE $BASE
echo DOWNLOADS $DOWNLOADS

PATH=/mingw64/bin:/usr/bin

cd "${SOFT}"
cd lapack-3.6.1
mkdir build
cd build
mkdir -p "${BASE}/install/lua/5.1"
"C:\Program Files (x86)\CMake\bin\cmake" "-DCMAKE_INSTALL_PREFIX=${BASE}/install" -G "MSYS Makefiles" -DBUILD_SHARED_LIBS=1 -DCMAKE_GNUtoMS=1 "-DCMAKE_GNUtoMS_VCVARS=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" -DCMAKE_Fortran_COMPILER=/mingw64/bin/x86_64-w64-mingw32-gfortran.exe ..
make -j 8
make install

pushd /mingw64/bin
cp libgcc_s_seh-1.dll libgfortran-3.dll libquadmath-0.dll libwinpthread-1.dll "${BASE}/install/bin"
popd

# touch "${SOFT}/lapack_done.flg"
