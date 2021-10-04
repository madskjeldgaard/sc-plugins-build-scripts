INSTALL_LOCATION="$HOME/Library/Application Support/SuperCollider/Extensions"
SC_LOCATION="../supercollider"
SCRIPTS_HOME="$(pwd)"
PROJECT_DIR="guttersynth-sc"

echo "Building $PROJECT_DIR"
cd $PROJECT_DIR
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DSC_PATH="$SC_LOCATION" -DCMAKE_INSTALL_PREFIX="$INSTALL_LOCATION" && \
	cmake --build . --config Release && \
	cmake --build . --config Release --target install && \
	echo "Succesfully built $PROJECT_DIR"

cd $SCRIPTS_HOME
