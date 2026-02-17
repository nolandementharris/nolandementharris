#include <iostream>
#include <cmath>
#include <cstdlib>
#include <fstream>
#include <sstream>
#include <iomanip>
#include "../code/array_double.hpp"

using namespace std;


int main(int argc, char* argv[])
{

//File Input
    ifstream infile;
    infile.open(argv[1]);

//Ensure correct number of arguments
    if (argc < 6)
    {
        cout << "Usage: ./run_app <inputfilename> <Query_Location> <Query_Airline> <Query_Start_Age> <Query_End_Age>" << endl;
    }

//Ensure file opened correctly
    if (infile.is_open()) {

//Store arguments into query paramaters array
    string queryParams[4];
    string queryLocation = argv[2];
    string queryAirline = argv[3];
    string startAge = argv[4];
    string endAge = argv[5];

    queryParams[0] = queryAirline;
    queryParams[1] = queryLocation;
    queryParams[2] = startAge;
    queryParams[3] = endAge;

//Declare structure object and variables for function arguments
    int arrCapacity = 10;
    AirlinePassenger *passengers = new AirlinePassenger[arrCapacity];
    int recordIdx = 0;
    int doublingCounter = 0;

//Call parseFile function to read passengers into struct
    parseFile(infile, queryParams, passengers, arrCapacity, recordIdx, doublingCounter);

//Print doubling counter and total passengers
    cout << "Array doubled: " << doublingCounter << endl;
    cout << "Total number of passengers returned after the query: " << recordIdx << endl;

//Print passenger name and age in descending order/alphabetically
    printQueriedPassengers(passengers,recordIdx);

    }
    else
    {
        cout << "File does not open" << endl; 
    }

    infile.close();

    return 0;
}
