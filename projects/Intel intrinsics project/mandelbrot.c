// Include SSE intrinsics
#if defined(_MSC_VER)
#include <intrin.h>
#elif defined(__GNUC__) && (defined(__x86_64__) || defined(__i386__))
#include <immintrin.h>
#include <x86intrin.h>
#endif

// Include OpenMP
#include <omp.h>

#include "mandelbrot.h"
#include "parameters.h"


uint32_t lameiterations(struct parameters params, double complex point) {
    double complex z = 0;
    for (int i = 1; i <= params.maxiters; i++) {
        z = z * z + point;
        if (creal(z) * creal(z) + cimag(z) * cimag(z) >= params.threshold * params.threshold) {
            return i;
        }
    }
    return 0;
}

uint32_t iterations(struct parameters params, double * points) {
    //double complex z = 0;
    double holdThresh = params.threshold * params.threshold;
   // double 
    //sets the crs ( cr3, cr2, cr1,cr0)
    double setZeros[4] = {0.0,0.0,0.0,0.0};
    double cmpsArray[4] = {0.0,0.0,0.0,0.0};
    double testupdate[4] = {0.0,0.0,0.0,0.0};
    __m256d crs = _mm256_loadu_pd(points);
    __m256d cis = _mm256_loadu_pd(&points[4]);
    __m256d zrs = _mm256_set_pd(0, 0, 0, 0);
    __m256d zis = _mm256_set_pd(0, 0, 0, 0);
    __m256d twos = _mm256_set_pd(2, 2, 2, 2);
 //   __m256d mask = _mm256_set_pd(0xFFFFFFFFFFFFFFFF, 0xFFFFFFFFFFFFFFFF,0xFFFFFFFFFFFFFFFF, 0xFFFFFFFFFFFFFFFF);
   // __m256d mask = _mm256_set_pd(0, 0, 0, 0);

    //__m256d twos = _mm256_set_pd(2, 2, 2, 2);
   // __m256d tide = twos;
   // _mm256_storeu_pd(cmpsArray, tide);
    
   //for (int l = 0; l < 4; l++) {
   //     printf("%f \n", cmpsArray[l]);
    // }
    //return 0;
    __m256d thresh = _mm256_set_pd(holdThresh, holdThresh, holdThresh, holdThresh);
    

    for (int i = 1; i <= params.maxiters; i++) {
        __m256d updatezrs = _mm256_add_pd(_mm256_sub_pd(_mm256_mul_pd(zrs, zrs), _mm256_mul_pd(zis, zis)), crs);
        _mm256_storeu_pd(testupdate, updatezrs);
              //  for (int l = 0; l < 4; l++) {
            //printf("%f \n", testupdate[l]);
     //  }
        __m256d updatezis = _mm256_add_pd(_mm256_mul_pd(_mm256_mul_pd(zrs, zis), twos), cis);
        __m256d cmp = _mm256_cmp_pd(_mm256_add_pd(_mm256_mul_pd(updatezrs, updatezrs), _mm256_mul_pd(updatezis, updatezis)), thresh, 1);//_mm256_cmp_pd (__m256d a, __m256d b, 29);
         
        _mm256_storeu_pd(cmpsArray, cmp);
         //   for (int l = 0; l < 4; l++) {
           // printf("%f \n", cmpsArray[l]);
      //  }
          for (int k = 0; k < 4; k++) {
              if (cmpsArray[k] == 0x0000000000000000){
                  setZeros[k] = 1;
                  
                 // printf("hey");
              }
          }
          if (setZeros[0] == 1 && setZeros[1] == 1  && setZeros[2] == 1  && setZeros[3] == 1)
          {
              break;
          }
          
          
          zrs = updatezrs;
          zis = updatezis;
        /*z = z * z + point;
        if (creal(z) * creal(z) + cimag(z) * cimag(z) >= holdThresh) {
            return i;
        }*/
    }
    return 4 - (setZeros[0] + setZeros[1] + setZeros[2] + setZeros[3]);
}

void mandelbrot(struct parameters params, double scale, int32_t *num_pixels_in_set) {
    uint32_t num_zero_pixels = 0;
    //omp_set_num_threads(32); // Use 4 threads for all consecutive parallel regions
    //#pragma omp parallel for private(num_zero_pixels)
    for (int i = params.resolution; i >= -params.resolution; i--) {
        //#pragma omp parallel for reduction(+: num_zero_pixels)
        for (int j = -params.resolution; j < (params.resolution)/4*4; j+=4) {
            double points[8];
            points[0] = creal(params.center) + j * scale / params.resolution;
            points[4] = cimag(params.center) + i * scale / params.resolution;
            points[1] = creal(params.center) + (j+1) * scale / params.resolution;
            points[5] = cimag(params.center) + (i) * scale / params.resolution;
            points[2] = creal(params.center) + (j+2) * scale / params.resolution;
            points[6] = cimag(params.center) + (i) * scale / params.resolution;
            points[3] = creal(params.center) + (j+3) * scale / params.resolution;
            points[7] = cimag(params.center) + (i) * scale / params.resolution;
            

           /* double complex point1 = (params.center +
                    j * scale / params.resolution +
                    i * scale / params.resolution * I);
                    
            double complex point2 = (params.center +
                    (j+1) * scale / params.resolution +
                    (i-1) * scale / params.resolution * I);

            double complex point3 = (params.center +
                    (j+2) * scale / params.resolution +
                    (i-2) * scale / params.resolution * I);

            double complex point4 = (params.center +
                    (j+3) * scale / params.resolution +
                    (i-3) * scale / params.resolution * I);       
                    */
           //double complex points[4] = {point1,point2, point3, point4};
                num_zero_pixels += iterations(params, points);
         
        }
        for (int j = (params.resolution)/4*4; j <= params.resolution; j++) {
                      double complex point = (params.center +
                    j * scale / params.resolution +
                    i * scale / params.resolution * I);
            if (lameiterations(params, point) == 0) {
                num_zero_pixels++;
            }
        }
    }
    *num_pixels_in_set = num_zero_pixels;
}
