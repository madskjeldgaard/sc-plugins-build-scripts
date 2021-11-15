INSTALL_LOCATION="$HOME/Library/Application Support/SuperCollider/Extensions"
SC_LOCATION="../../supercollider"
SCRIPTS_HOME="$(pwd)"
PROJECT_DIR="mi-UGens"
OSX_ARCH=$1

if [ -z "$OSX_ARCH" ]; then
	echo "No target architecture chosen. Run the script again with either x86_64 or arm as the argument: ./script.sh x86_64" && exit 1;
fi

echo "Building $PROJECT_DIR for architecture $OSX_ARCH"

######
#
# Build all projects
# Usage: build.sh <SUPERCOLLIDER SOURCE>
#
FOLDERS=(MiBraids MiClouds MiElements MiMu MiOmi MiPlaits MiRings MiRipples MiTides MiVerb MiWarps)
MI_UGENS=build/mi-UGens

cd $PROJECT_DIR

mkdir -p $MI_UGENS

# MiBraids depends on libsamplerate, let's build that first
cd MiBraids/libsamplerate
echo "Building libsamplerate"
mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DLIBSAMPLERATE_EXAMPLES=OFF -DBUILD_TESTING=OFF -DCMAKE_OSX_ARCHITECTURES="$OSX_ARCH"  ..
make
cd ../../..

for FOLDER in "${FOLDERS[@]}"
do
	cd $FOLDER

	echo "Building $FOLDER"

	# # Build folder
	mkdir -p build
	cd build

	# # Build
	cmake -DSC_PATH=$SC_LOCATION -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$INSTALL_LOCATION" -DCMAKE_OSX_ARCHITECTURES="$OSX_ARCH" ..
	cmake --build . --config Release

	# Copy binary
	cp $FOLDER.scx "$INSTALL_LOCATION"

	cd ../..
done

cp -r sc/* "$INSTALL_LOCATION"

cd $SCRIPTS_HOME
# cp -r sc/* $MI_UGENS
