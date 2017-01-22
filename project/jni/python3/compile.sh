#!/bin/sh

#ARCH_LIST="arm64-v8a x86 mips armeabi-v7a armeabi"

#ARCH_LIST="arm x86 mips"
ARCH_LIST="arm"

mkdir -p build

build() {
	export 	ANDROID_PLATFORM=$1

	pushd python3-android
	make
	popd
}

PIDS=""
for ARCH in $ARCH_LIST; do
	build $ARCH &
	PIDS="$PIDS $!"
done

for PID in $PIDS; do
	wait $PID || exit 1
done

# Provide includes for the to be built apps
rm include
rm lib
ln -s python3-android/build/13b-23-arm-linux-androideabi-4.9/include include 
ln -s python3-android/build/13b-23-arm-linux-androideabi-4.9/lib lib
#cp -r -L build/armeabi-v7a/include ./ || exit 1
