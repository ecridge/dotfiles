/*
 * Name:     Perceptual average calculator for PPM images
 * Author:   Joe Cridge <joe.cridge@me.com>
 * URL:      https://gist.github.com/joecridge/d0ecf785d8a12eaac2353e02b4d8c9b7
 * License:  Unlicense
 * Created:  2016-07-31
 * Modified: 2016-07-31
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX(x, y) (((x) > (y)) ? (x) : (y))
#define MIN(x, y) (((x) < (y)) ? (x) : (y))

#define MAX3(x, y, z) MAX(MAX(x, y), z)
#define MIN3(x, y, z) MIN(MIN(x, y), z)

static inline int close_image(FILE *f, char *name);
static inline int parse_header(FILE *f);

int main(int argc, char **argv)
{
        int i, numel;
        int red, green, blue, chroma;
        int red_mean, green_mean, blue_mean, luma_mean;
        long red_sum, green_sum, blue_sum, chroma_sum, luma_sum;
        FILE *f;

        if (argc != 2) {
                printf("Usage: %s filename.ppm\n", argv[0]);
                return -1;
        }

        if ((f = fopen(argv[1], "r")) == NULL) {
                printf("Could not open file: %s\n", argv[1]);
                return -1;
        }

        if ((numel = parse_header(f)) == 0) {
                printf("File is not in binary PPM format: %s\n", argv[1]);
                close_image(f, argv[1]);
                return -1;
        }

        red_sum = green_sum = blue_sum = chroma_sum = luma_sum = 0;
        for (i = 0; i < numel; ++i) {
                if ((red = fgetc(f)) == EOF || (green = fgetc(f)) == EOF ||
                                (blue = fgetc(f)) == EOF) {
                        printf("PPM file is corrupted: %s\n", argv[1]);
                        return -1;
                }

                chroma = MAX3(red, green, blue) - MIN3(red, green, blue);
                chroma_sum += chroma;

                luma_sum += (54 * red) + (184 * green) + (18 * blue);

                red_sum += chroma * red;
                green_sum += chroma * green;
                blue_sum += chroma * blue;
        }

        red_mean = red_sum / chroma_sum;
        green_mean = green_sum / chroma_sum;
        blue_mean = blue_sum / chroma_sum;

        printf("Neutral colour: #%02x%02x%02x\n", red_mean, green_mean,
                        blue_mean);

        luma_mean = (100 * luma_sum / numel) >> 16;

        printf("Perceptual lightness: %i%%\n", luma_mean);

        if (close_image(f, argv[1]) != 0)
                return -1;

        return 0;
}

static inline int close_image(FILE *f, char *name)
{
        if (fclose(f) != 0) {
                printf("Could not close file: %s\n", name);
                return -1;
        }

        return 0;
}

static inline int parse_header(FILE *f)
{
        int c, i, j, numel;
        char strbuf[10];

        if (fgets(strbuf, 3, f) == NULL || strncmp(strbuf, "P6", 3) != 0)
                return 0;

        numel = 1;
        fgetc(f);
        for (j = 0; j < 2; ++j) {
                for (i = 0; i < 9; ++i)
                        strbuf[i] = ' ';

                i = 0;
                c = fgetc(f);
                while (c >= '0' && c <= '9') {
                        strbuf[i++] = c;
                        c = fgetc(f);
                }
                strbuf[9] = '\0';
                numel *= atoi(strbuf);
        }

        if (fgets(strbuf, 4, f) == NULL || strncmp(strbuf, "255", 4) != 0)
                return 0;

        fgetc(f);

        return numel;
}
