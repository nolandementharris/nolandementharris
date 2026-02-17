#include <stdio.h>
#include "cs1300bmp.h"
#include <iostream>
#include <fstream>
#include <stdlib.h>
#include "Filter.h"
#include <stdint.h>

#include <omp.h>

using namespace std;

#include "rdtsc.h"

//
// Forward declare the functions
//
Filter * readFilter(string filename);
double applyFilter(Filter *filter, cs1300bmp *input, cs1300bmp *output);

int
main(int argc, char **argv)
{

  if ( argc < 2) {
    fprintf(stderr,"Usage: %s filter inputfile1 inputfile2 .... \n", argv[0]);
  }

  //
  // Convert to C++ strings to simplify manipulation
  //
  string filtername = argv[1];

  //
  // remove any ".filter" in the filtername
  //
  string filterOutputName = filtername;
  string::size_type loc = filterOutputName.find(".filter");
  if (loc != string::npos) {
    //
    // Remove the ".filter" name, which should occur on all the provided filters
    //
    filterOutputName = filtername.substr(0, loc);
  }

  Filter *filter = readFilter(filtername);

  double sum = 0.0;
  int samples = 0;

  for (int inNum = 2; inNum < argc; inNum++) {
    string inputFilename = argv[inNum];
    string outputFilename = "filtered-" + filterOutputName + "-" + inputFilename;
    struct cs1300bmp *input = new struct cs1300bmp;
    struct cs1300bmp *output = new struct cs1300bmp;
    int ok = cs1300bmp_readfile( (char *) inputFilename.c_str(), input);

    if ( ok ) {
      double sample = applyFilter(filter, input, output);
      sum += sample;
      samples++;
      cs1300bmp_writefile((char *) outputFilename.c_str(), output);
    }
    delete input;
    delete output;
  }
  fprintf(stdout, "Average cycles per sample is %f\n", sum / samples);

}

class Filter *
readFilter(string filename)
{
  ifstream input(filename.c_str());

  if ( ! input.bad() ) {
    int size = 0;
    input >> size;
    Filter *filter = new Filter(size);
    int div;
    input >> div;
    filter -> setDivisor(div);
    for (int i=0; i < size; i++) {
      for (int j=0; j < size; j++) {
	int value;
	input >> value;
	filter -> set(i,j,value);
      }
    }
    return filter;
  } else {
    cerr << "Bad input in readFilter:" << filename << endl;
    exit(-1);
  }
}



double
applyFilter(class Filter *filter, cs1300bmp *input, cs1300bmp *output)
{

  long long cycStart, cycStop;

  cycStart = rdtscll();


  uint8_t f_size = filter -> getSize();
  uint8_t div = filter -> getDivisor();
  int height = input->height - 1;
  int width = input->width - 1;
  output -> width = width + 1;
  output -> height = height + 1;
  
  #pragma omp parallel for
      for(int row = 1; row < (height); row += 1) {
      for(int col = 1; col < (width); col += 1) {

	      int A[3] = {0};
        int rN = row - 1;
        int cN = col - 1;

        for (int j = 0; j < f_size; j++) {
          int colN = cN + j;
            for (int i = 0; i < f_size; i++) {	
            int f1 = filter->get(i, j);
            int rowN = rN + i;
            A[0] += (input->color[0][rowN][colN] * f1);
            A[1] += (input->color[1][rowN][colN] * f1);
            A[2] += (input->color[2][rowN][colN] * f1);
        }
        }

	A[0] /= div;
  A[1] /= div;
  A[2] /= div;

	if ( A[0] < 0 ) {A[0] = 0;};
  if ( A[1] < 0 ) {A[1] = 0;};
  if ( A[2] < 0 ) {A[2] = 0;};

	if ( A[0] > 255 ) { A[0] = 255;}
  if ( A[1] > 255 ) { A[1] = 255;}
  if ( A[2] > 255 ) { A[2] = 255;}

  output -> color[0][row][col] = A[0];
  output -> color[1][row][col] = A[1];
  output -> color[2][row][col] = A[2];

      }
    }


  cycStop = rdtscll();
  double diff = cycStop - cycStart;
  double diffPerPixel = diff / (output -> width * output -> height);
  fprintf(stderr, "Took %f cycles to process, or %f cycles per pixel\n",
	  diff, diff / (output -> width * output -> height));
  return diffPerPixel;
}
