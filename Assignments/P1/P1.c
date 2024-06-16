//P! Assignment
// Author: Ryan Blocker
// Date:   8/25/2021
// Class:  CS270
// Email:  rblocker@colostate.edu

// Include files
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

double input[5];

double *output[4];

// example of a global array
int exampleGlobalArray[2];

// this function can be used as a guide for the funtions you will implement


void computeSphere(double radius,double *addressOfVolumeS)
{
	//compute volume
	double result2 = (4.0/3.0)* 3.141593*radius*radius*radius;
	//result pointer
	*addressOfVolumeS = result2;
} 

void computeCube(double  side, double *addressOfVolumeC)
{
	//compute volume
	double result3 = side*side*side;
	//result pointer
	*addressOfVolumeC = result3;
}

void computeTetrahedron(double side, double *addressOfVolumeT)
{
	//compute volume
	double result4 = 0.117851*side*side*side;
	//result pointer
	*addressOfVolumeT = result4;
}

void computeCylinder(double radius, double height, double *addressOfVolumeCL)
{
	//compute volume
	double result5 = 3.141593*radius*radius*height;
	//result pointer
	*addressOfVolumeCL = result5;
}

int main(int argc, char *argv[])
{
    // Check number of arguments
    if (argc <= 5) {
        printf("usage: ./P1 <double> <double> <double> <double> <double>");
        return EXIT_FAILURE;
	}

	//parse arguments
	input[0] = atof(argv[1]);
	input[1] = atof(argv[2]);
	input[2] = atof(argv[3]);
	input[3] = atof(argv[4]);
	input[4] = atof(argv[5]);

double volume1;
double volume2;
double volume3;
double volume4;


	//pass in input, and output
	computeSphere(input[0], &volume1);
	computeCube(input[1], &volume2);
	computeTetrahedron(input[2], &volume3);
	computeCylinder(input[3], input[4], &volume4);

    // Local variable
   // double area;

    // Print area
    printf("SPHERE, radius = %.5f , volume = %.5f.\n", input[0], volume1);
    printf("CUBE, side = %.5f , volume = %.5f.\n", input[1], volume2);
    printf("TETRAHEDRON, side = %.5f , volume = %.5f.\n", input[2], volume3);
    printf("CYLINDER, radius = %.5f, height = %.5f, volume = %.5f.\n", input[3], input[4], volume4);


    // Return success
    return EXIT_SUCCESS;
}
