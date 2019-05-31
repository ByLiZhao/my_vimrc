#!/bin/bash
#install boost
#run as root
boost_url=https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.tar.bz2
# create .temp if not existed already
cd ~
if [ -d "$HOME/.temp" ]
then
echo ".temp already exists."
else
mkdir .temp
fi
#
cd ~/.temp
wget "$boost_url"
tar --bzip2 -xf boost_1_67_0.tar.bz2
cd boost_1_67_0/
#./bootstrap.sh
./bootstrap.sh --with-icu -with-toolset=gcc --prefix=/usr/local --with-python=/usr/local/bin/python3 --with-python-root=/usr/local
./b2 -j12 toolset=gcc variant=release link=shared threading=multi address-model=64 cxxflags=-std=c++17 install
exit
cd ~/.temp
rm -rf boost_1_67_0/
cd ~
