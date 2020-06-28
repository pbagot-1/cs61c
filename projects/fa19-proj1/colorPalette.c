/*********************
**  Color Palette generator
** Skeleton by Justin Yokota
**********************/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <string.h>
#include "ColorMapInput.h"

//You don't need to call this function but it helps you understand how the arguments are passed in 
void usage(char* argv[])
{
	printf("Incorrect usage: Expected arguments are %s <inputfile> <outputfolder> <width> <heightpercolor>", argv[0]);
}

//Creates a color palette image for the given colorfile in outputfile. Width and heightpercolor dictates the dimensions of each color. Output should be in P3 format
int P3colorpalette(char* colorfile, int width, int heightpercolor, char* outputfile)
{ if (heightpercolor < 1) {
    return 1;
    }
    int colorcount = 0;
	FILE *fp;
    fp = fopen(colorfile, "r");
    if (fp == NULL) {
        return 1;
    }
    FILE *outputp3;
    //strncat(char *dest, const char *src, size_t n);
    outputp3 = fopen(outputfile, "w");
    fscanf(fp, "%d", &colorcount);
    char buffer[1024];
    snprintf(buffer, sizeof(buffer), "P3 %d %d %d \n", width, colorcount*heightpercolor, 255);
    fputs(buffer,outputp3);
    uint8_t * hold = malloc(sizeof(uint8_t)); 
    uint8_t *reset = hold;
    
    
     uint8_t color1;
     uint8_t color2;
     uint8_t color3;
    for (int outer = 0; outer < colorcount*heightpercolor; outer++) {
      
    if (outer % heightpercolor == 0) {
    fscanf(fp, "%hhu", hold);
    color1 = *reset;
    hold = reset;
 
    fscanf(fp, "%hhu", hold);    
    color2 = *reset;//*hold;
      hold = reset;
    fscanf(fp, "%hhu", hold);    
    color3 = *reset;//*hold;
      hold = reset;
    }
    
    for (int i = 0; i < width; i++)
    {
        if (i == width - 1) {
        snprintf(buffer, sizeof(buffer), "%hhu %hhu %hhu\n", color1, color2, color3);
        fputs(buffer,outputp3);  
        }
        else{
        snprintf(buffer, sizeof(buffer), "%hhu %hhu %hhu ", color1, color2, color3);
        fputs(buffer,outputp3);
        }
    }

    
    }
    fclose(outputp3);
    fclose(fp);
    
	return 0;
}

//Same as above, but with P6 format
int P6colorpalette(char* colorfile, int width, int heightpercolor, char* outputfile)
{
	if (heightpercolor < 1) {
    return 1;
    }
    int colorcount = 0;
	FILE *fp;
    fp = fopen(colorfile, "r");
    if (fp == NULL) {
        return 1;
    }
    FILE *outputp3;
    //strncat(char *dest, const char *src, size_t n);
    outputp3 = fopen(outputfile, "w");
    fscanf(fp, "%d", &colorcount);
    char buffer[1024];
    snprintf(buffer, sizeof(buffer), "P6 %d %d %d \n", width, colorcount*heightpercolor, 255);
    fputs(buffer,outputp3);
    uint8_t * hold = malloc(sizeof(uint8_t)); 
    uint8_t *reset = hold;
    
    
     uint8_t color1;
     uint8_t color2;
     uint8_t color3;
    for (int outer = 0; outer < colorcount*heightpercolor; outer++) {
      
    if (outer % heightpercolor == 0) {
    fscanf(fp, "%hhu", hold);
    color1 = *reset;
    hold = reset;
 
    fscanf(fp, "%hhu", hold);    
    color2 = *reset;//*hold;
      hold = reset;
    fscanf(fp, "%hhu", hold);    
    color3 = *reset;//*hold;
      hold = reset;
    }
    
    for (int i = 0; i < width; i++)
    {
        snprintf(buffer, sizeof(buffer), "%c%c%c", color1, color2, color3);
        fputs(buffer,outputp3);
    }

    
    }
    fclose(outputp3);
    fclose(fp);
    
	return 0;
}


//The one piece of c code you don't have to read or understand. Still, might as well read it, if you have time.
int main(int argc, char* argv[])
{
	if (argc != 5)
	{
		usage(argv);
		return 1;
	}
	int width = atoi(argv[3]);
	int height = atoi(argv[4]);
	char* P3end = "/colorpaletteP3.ppm";
	char* P6end = "/colorpaletteP6.ppm";
	char buffer[strlen(argv[2]) + strlen(P3end)];
	sprintf(buffer, "%s%s", argv[2], P3end);
	int failed = P3colorpalette(argv[1], width, height, buffer);
	if (failed)
	{
		printf("Error in making P3colorpalette");
		return 1;
	}
	sprintf(buffer, "%s%s", argv[2], P6end);
	failed = P6colorpalette(argv[1], width, height, buffer);
	if (failed)
	{
		printf("Error in making P6colorpalette");
		return 1;
	}
	printf("P3colorpalette and P6colorpalette ran without error, output should be stored in %s%s, %s%s", argv[2], P3end, argv[2], P6end);
	return 0;
    
   /* P3colorpalette("minicolormap.txt",4, 2, "liloutput.txt");
        P6colorpalette("minicolormap.txt",4, 2, "liloutput2.txt"); */
}




