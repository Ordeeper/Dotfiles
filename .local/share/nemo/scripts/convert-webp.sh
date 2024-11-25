#!/bin/bash

if ! command -v magick &> /dev/null; then
	echo "ImageMagick is not installed. Please install it first."
	exit 1
fi

for img in "$@"; do
	filename="${img%.*}"

	magick "$img" -quality 50 -define webp:method=6 "${filename}.webp"

	if [ $? -eq 0 ]; then
		echo "✅ Successfully converted '$img' to '${filename}.webp'"
	else
		echo "❌ Failed to convert '$img'"
	fi
done
