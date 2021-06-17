palette:
	ffmpeg -start_number 126 -i png/%3d.png -vf palettegen palette.png
