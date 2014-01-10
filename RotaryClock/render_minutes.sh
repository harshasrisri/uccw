#!/bin/bash
#script to render minutes as circles for UCCW clock

if [ ! $# -eq 5 ];
then
	echo "$0 <name> <color> <canvas_side> <x_adjust> <y_adjust>"
	exit
fi

name=$1
color=$2
side=$3
x_adjust=$4
y_adjust=$5

minutes=({00..59});
xs=( $(./coords $side x) )
ys=( $(./coords $side y) )
fonts=( $(convert -list font | grep Font: | awk '{print $2;}') )
font="Anna"

rad=$((side/12))
text_size=$((rad * 8 / 5))

# Orange
big_ring="#333300" 
# small_fill="#CC9900" 
small_fill=$color

# Extras
small_ring=$big_ring
text_fill=$big_ring
text_stroke=$text_fill

mkdir -p $name
cd $name

for i in {0..59}; do
	min=${minutes[$i]};
	x=${xs[$i]};
	y=${ys[$i]};

	convert -size ${side}x${side} \
		canvas:none \
		-fill $small_fill -stroke $small_ring -strokewidth $((side/90)) \
		-draw "circle $x,$y $((x+rad)),$((y+rad))" \
		-fill $text_fill -stroke $text_stroke -strokewidth 0 \
		-font $font -pointsize $text_size \
		-draw "text $((x-text_size/2-x_adjust)),$((y+text_size/4+y_adjust)) '$min'" \
		${min}.png
done
