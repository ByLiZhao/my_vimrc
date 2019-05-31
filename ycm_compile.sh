#!/bin/bash
#compile ycm with llvm support
#
ycm_dir=$HOME/.vim/plugged/YouCompleteMe
# create .temp if not existed already
cd ~
if [ -d "$HOME/.temp" ]
then
echo ".temp already exists."
else
mkdir .temp
fi
#
#update YouCompleteMe
cd "$ycm_dir"
git submodule update --init --recursive 
# compile ycm with boost and ycm support
cd ~/.temp
mkdir ycm_build
cd ycm_build
#produce makefile
cmake -G "Unix Makefiles" -DUSE_PYTHON2=OFF \
-DPYTHON_LIBRARY=/usr/local/lib/python3.7/config-3.7m-x86_64-linux-gnu/libpython3.7m.a \
-DPYTHON_INCLUDE_DIR=/usr/local/include/python3.7m \
-DPYTHON_EXECUTABLE=/usr/local/bin/python3 \
-DUSE_SYSTEM_LIBCLANG=ON \
. $ycm_dir/third_party/ycmd/cpp

#compile, --config Release is specific for windows, ignored on Linux
cmake --build . --target ycm_core --config Release
# compile regex support
cd ~/.temp
mkdir regex_build
cd regex_build
cmake -G "Unix Makefiles" -DUSE_PYTHON2=OFF \
-DPYTHON_LIBRARY=/usr/local/lib/python3.7/config-3.7m-x86_64-linux-gnu/libpython3.7m.a \
-DPYTHON_INCLUDE_DIR=/usr/local/include/python3.7m \
-DPYTHON_EXECUTABLE=/usr/local/bin/python3 \
. $ycm_dir/third_party/ycmd/third_party/cregex
cmake --build . --target _regex --config Release
#
cd ~/.temp
rm -rf ycm_temp
rm -rf ycm_build
rm -rf regex_build
cd ~
#
#add rust support
cd ~/.vim/plugged/YouCompleteMe/third_party/ycmd/third_party/racerd
cargo build --release
