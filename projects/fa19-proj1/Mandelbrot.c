/*******************
**  Mandelbrot fractal
** clang -Xpreprocessor -fopenmp -lomp -o Mandelbrot Mandelbrot.c
** by Dan Garcia <ddgarcia@cs.berkeley.edu>
** Modified for this class by Justin Yokota and Chenyu Shi
**********************/

#include <stdio.h>
#include <stdlib.h>
#include "ComplexNumber.h"
#include "Mandelbrot.h"

/*
This function returns the number of iterations before the initial point >= the threshold.
If the threshold is not exceeded after maxiters, the function returns 0.
*/
u_int64_t MandelbrotIterations(u_int64_t maxiters, ComplexNumber * point, double threshold)
{
  u_int64_t count = 0;
  //if (threshold == 0) {return 0;}  
  double real = Re(point);
  double imaginary = Im(point);
  ComplexNumber * hold = newComplexNumber(real, imaginary);
  ComplexNumber * init = newComplexNumber(0, 0);
  ComplexNumber * holdProduct = ComplexProduct(init, init);
  point = ComplexSum(holdProduct, hold);
  freeComplexNumber(holdProduct);
  freeComplexNumber(init);
  while (count <= maxiters) {
       count++;
       //printf("after iter Re: %f Im: %f \n", Re(point), Im(point));
      if (ComplexAbs(point) >= threshold) {
          freeComplexNumber(point);
          freeComplexNumber(hold);
          return count;
      }
      
      ComplexNumber*freePoint = point;
      ComplexNumber*product = ComplexProduct(point, point);
      point = ComplexSum(product, hold);
      freeComplexNumber(product);
      freeComplexNumber(freePoint);
  }
   freeComplexNumber(point);
   freeComplexNumber(hold);
  return 0;
}

/*
This function calculates the Mandelbrot plot and stores the result in output.
The number of pixels in the image is resolution * 2 + 1 in one row/column. It's a square image.
Scale is the the distance between center and the top pixel in one dimension.
*/
void Mandelbrot(double threshold, u_int64_t max_iterations, ComplexNumber* center, double scale, u_int64_t resolution, u_int64_t * output){
    if (resolution == 0) {output[0] = MandelbrotIterations(max_iterations, center, threshold); return;}    
//u_int64_t grid[2*resolution+1][2*resolution+1];
   int iterz = 0; 
   //int x = 0;
   //int y = 0; 
    //double i = Re(center) - (scale);
    //double j = Im(center) + (scale);
    for (double i = Re(center) - (scale), x = 0; i <= Re(center) + (scale) + (scale/(double)resolution); i = Re(center) - (scale) + (x+1)*((double)(scale/((double)resolution))),++x)
    {

        for (double j = Im(center) + (scale), y = 0; j >= Im(center) - scale - (scale/(double)resolution); j = Im(center) + (scale) - (y+1)*((double)(scale/((double)resolution))),++y)
        {
         if (x <= 2*resolution && y <= 2*resolution){ 
         iterz++;
         //   printf("\n i: %f j: %f \n",i,j);
         //printf("\n x: %d y: %d \n",x,y);
         ComplexNumber * newComp = newComplexNumber(i, j);
        /*grid[x][y]*/output[(int) ((int)y*(2*(int)resolution+1) + (int)x)] = MandelbrotIterations(max_iterations, newComp, threshold);
        freeComplexNumber(newComp);
        //rintf("\n For size %d graph On X: %u Y: %u \n",((resolution*2+1)*(resolution*2+1)), y, x);
           }
        }

    }
   //printf("\n ITERZ %d\n", iterz);
}


