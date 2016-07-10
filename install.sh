#!/usr/bin/env bash

# GCC install script for Ubuntu
# (inspired by mininet install.sh)

# Fail on error
set -e 

# Fail on unset var usage
set -o nounset

# Define install
install = ./configure && make && make check && sudo make install

# Dependency install
echo "Install dependent packages ..."
sudo apt-get install build-essential
sudo apt-get install libgmp-dev libmpfr-dev libmpc-dev libc6-dev
sudo apt-get install m4
sudo apt-get install make g++

libgmp_so="/usr/lib/x86_64-linux-gnu/libgmp.so.10"

cwd="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"
if [ -d $libgmp_so]
    libgmp_version="$( python $cwd/get_gmp_version.py)"
else
    echo "Can not detect the version of libgmp"
    exit 1
fi

# Install GMP
echo "Install gmp ..."
wget https://gmplib.org/download/gmp/gmp-$libgmp_version.tar.bz2
bzip2 -d gmp-$libgmp_version.tar.bz2
tar -xvf gmp-$libgmp_version.tar
rm gmp-$libgmp_version.tar
cd gmp-$libgmp_version

$install

cd ..

# Install MPFR
echo "Install mpfr ..."
sudo apt-get install texinfo
sudo apt-get install autotools-dev
sudo apt-get install automake
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
wget http://www.mpfr.org/mpfr-current/mpfr-3.1.4.tar.bz2
bzip2 -d mpfr-3.1.4.tar.bz2
tar -xvf mpfr-3.1.4.tar 
rm mpfr-3.1.4.tar
cd mpfr-3.1.4

$install

# Install MPC
echo "Install mpc ..."
wget ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz
tar -zxvf mpc-1.0.3.tar.gz
rm mpc-1.0.3.tar.gz
cd mpc-1.0.3/

$install

# Install GCC
echo "Install gcc ..."
wget http://www.netgull.com/gcc/releases/gcc-5.4.0/gcc-5.4.0.tar.bz2
sudo apt-get install zlib1g-dev
bzip2 -d gcc-5.4.0.tar.bz2 
tar -xvf gcc-5.4.0.tar
rm gcc-5.4.0.tar
cd gcc-5.4.0/
./configure --enable-languages=c,c++ --disable-multilib --with-system-zlib prefix=/usr/bin/gcc-5.4
make
sudo make install
cd ..






