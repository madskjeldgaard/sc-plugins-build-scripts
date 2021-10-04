INSTALL_LOCATION="$HOME/Library/Application Support/SuperCollider/Extensions"
SC_LOCATION="../supercollider"
SCRIPTS_HOME="$(pwd)"
PROJECT_DIR="portedplugins"
OSX_ARCH=$1

if [ -z "$OSX_ARCH" ]; then
	echo "No target architecture chosen. Run the script again with either x86_64 or arm as the argument: ./script.sh x86_64" && exit 1;
fi

echo "Building $PROJECT_DIR for architecture $OSX_ARCH"
cd $PROJECT_DIR

git submodule update --init --recursive

if [ -d build ]; then
	rm -rf build
else
	mkdir build
fi

cd build

cmake .. -DCMAKE_BUILD_TYPE=Release -DSC_PATH="$SC_LOCATION" -DCMAKE_INSTALL_PREFIX="$INSTALL_LOCATION" -DCMAKE_OSX_ARCHITECTURES="$OSX_ARCH" && \
	cmake --build . --config Release && \
	cmake --build . --config Release --target install && \
	cd .. && \
	rm -rf build && \
	echo "Succesfully built and installed $PROJECT_DIR"

cd $SCRIPTS_HOME
