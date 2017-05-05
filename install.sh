#!/usr/bin/env bash


sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y build-essential cmake pkg-config libjpeg8-dev \
libtiff5-dev libjasper-dev libpng12-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev \
libgtk-3-dev \
libatlas-base-dev gfortran \
python3-dev \
python-pip

mkdir opencv
cd opencv
# source: http://opencv.org/releases.html
wget -O opencv.zip https://github.com/opencv/opencv/archive/3.2.0.zip
unzip opencv.zip

# source: https://github.com/opencv/opencv_contrib/tree/3.2.0
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.2.0.zip
unzip opencv_contrib.zip

sudo pip install virtualenv
virtualenv -p /usr/bin/python3 python3
source python3/bin/activate


pip install numpy

cd opencv-3.2.0
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D INSTALL_C_EXAMPLES=OFF \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv/opencv_contrib-3.2.0/modules \
    -D PYTHON_EXECUTABLE=~/opencv/python3/bin/python \
    -D BUILD_EXAMPLES=ON ..

make -j3
make clean
make

sudo make install
sudo ldconfig

cd ~/opencv/python3/lib/python3.5/site-packages/
ln -s /usr/local/lib/python3.5/site-packages/cv2.cpython-35m-x86_64-linux-gnu.so cv2.so
cd ~/opencv

python -c 'import cv2; print(cv2.__version__)
