/*********************
**  Color Map generator
** Skeleton by Justin Yokota
**********************/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <string.h>
#include "ColorMapInput.h"


/**************
**This function reads in a file name colorfile.
**It then uses the information in colorfile to create a color array, with each color represented by an int[3].
***************/
uint8_t** FileToColorMap(char* colorfile, int* colorcount)
{   FILE *fp;
    
    fp = fopen(colorfile, "r");
	if (fp == NULL) {
        //printf("%s", "yup");
        fclose(fp);
        free(colorcount);
        uint8_t** val = NULL;
        return val;
    }
    fscanf(fp, "%d", colorcount);
    /*if (*colorcount == 384) {
        printf("%s", "suc");
    }*/
   uint8_t ** colors = malloc(sizeof(uint8_t*)*(*colorcount));
    int count = 0;
    
    for (int i = 0; i < *colorcount; i++) {
         colors[i] = malloc(sizeof(uint8_t)*3);
    }
         
   while (count < *colorcount) {
        if (!feof(fp)) {
        fscanf(fp, "%hhu", colors[count]);
        fscanf(fp, "%hhu", 1+colors[count]);
        fscanf(fp, "%hhu", 2+colors[count]);
        count++;
       }
        else {
       break;
       }
   }
     for (int i = 0; i < *colorcount; i++) {
     for (int j = 0; j < 3; j++) {
     //    printf("%hhu\n", colors[i][j]);
     }
     //printf("\n");
     }
     fclose(fp);
     //free(colorcount);

   //  return colors;
     return NULL;
}
/*int main() {
    char * tide = "defaultcolormap.txt";
    int * s = malloc(sizeof(int));
    FileToColorMap(tide, s);
}*/


