#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define PI (3.141592653589793)

int main (int argc, char **argv) {
	if (argc != 3) {
		fprintf (stderr, "usage : %s <canvas_size> <x/y coordinates>\n", argv[0]);
		exit (-1);
	}

	double angle;
	int x,y,
		canvas_size = atoi(argv[1]),
		rad = canvas_size * 3 / 8;
	char coord = argv[2][0];

	for (angle = 180.0; angle > -180.0; angle -= 6.0) {
		x = rad * sin(angle / 180.0 * PI) + (canvas_size / 2);
		y = rad * cos(angle / 180.0 * PI) + (canvas_size / 2);
		printf ("%d ", (coord == 'x') ? x : y);
	}
	exit (0);
}
