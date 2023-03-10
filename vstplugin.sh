INSTALL_LOCATION="$HOME/Library/Application Support/SuperCollider/Extensions"
SCRIPTS_HOME="$(pwd)"
SC_LOCATION="${SCRIPTS_HOME}/supercollider"
PROJECT_DIR="vstplugin"
OSX_ARCH=$1

cd $SCRIPTS_HOME

if [ -z "$OSX_ARCH" ]; then
	echo "No target architecture chosen. Run the script again with either x86_64 or arm as the argument: ./script.sh x86_64" && exit 1;
fi

echo "Building $PROJECT_DIR for architecture $OSX_ARCH"
cd $PROJECT_DIR

git submodule update --init --recursive

if [ -d build ]; then
	rm -rf build
	mkdir build
else
	mkdir build
fi

cd ./vstplugin

# Get VST2
./.git-ci/get_vst2.sh

# Get VST3
./.git-ci/get_vst3.sh

cd ..

cd build;

cmake -DCMAKE_OSX_ARCHITECTURES="$OSX_ARCH" -DSC=ON -DPD=OFF -DVST2=ON -DVST3=ON -DBUILD_HOST=ON -DBUILD_HOST32=ON -DBUILD_HOST_AMD64=ON -DBUILD_WINE=OFF -DWINE=OFF -DBRIDGE=ON -DSUPERNOVA=ON -DSC_INCLUDEDIR="$SC_LOCATION" -DCMAKE_BUILD_TYPE=RELEASE -DSC_INSTALLDIR="$INSTALL_LOCATION" .. && \
cmake --build . -j -v && \
cmake --build . -v -t install && \
cd .. && \
rm -rf build && \
echo "Succesfully built and installed $PROJECT_DIR"

cd $SCRIPTS_HOME
