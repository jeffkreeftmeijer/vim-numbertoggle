palette:
	ffmpeg -start_number 126 -i png/%3d.png -vf palettegen palette.png
gif:
	ffmpeg -f concat -i input.txt -i palette.png -lavfi paletteuse toggle.gif
