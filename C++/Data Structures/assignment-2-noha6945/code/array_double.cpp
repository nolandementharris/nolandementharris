#include "array_double.hpp"
#include <sstream>

void parseFile(ifstream& input, string queryParams[], AirlinePassenger *&passengers, int &arrCapacity, int &recordIdx, int &doublingCounter) {

//Declare Variables
    string line;
    string temp[4];
    string desired_Airline = queryParams[0];
    string desired_Location = queryParams[1];
    int startAge;
    int endAge;
    stringstream (queryParams[2]) >> startAge;
    stringstream (queryParams[3]) >> endAge;
    AirlinePassenger passenger;


//Read Passengers from list
    while (getline(input,line))
    {
        stringstream ss(line);

    //Parse each line into four different values
        for(int i = 0; i<4; i++)
        {
            getline(ss,temp[i],',');
        }

    //Store each line in passenger struct
        passenger.name = temp[0];
        passenger.airline = temp[1];
        passenger.location = temp[2];
        stringstream (temp[3]) >> passenger.age;

    //Call function to determine validity of passenger
        bool query = isPassengerQueried(passenger, desired_Location, desired_Airline, startAge, endAge);

    //Keep or throw out passenger info based on query
        if(query == true)
        {
        //Add passenger to array
            addPassenger(passengers, passenger, arrCapacity, recordIdx, doublingCounter);

        }
    }

}

bool isPassengerQueried(AirlinePassenger passenger, string queryLocation, string queryAirline, int startAge, int endAge) {
    
//Compare indexed line of file to quer inputs
    if(passenger.airline == queryAirline && passenger.location == queryLocation && startAge <= passenger.age && passenger.age <= endAge)
        {
            return true;
        }
    else
        {
            return false;
        }
}

/**
 * Takes in a reference to an array of structs (passengers) 
 * and the current arrayCapacity. It doubles the size 
 * of the array by making a new array of size the current
 * size and copying the elements of the old one. 
 */
void resizeArr(AirlinePassenger *&passengers, int *arraySize) {

//Declare new array size
    int newSize = *arraySize * 2;
cout << "New size: " << newSize << endl;
cout << "Intiial Size: " << *arraySize << endl;
//Declare new array with new array size
    AirlinePassenger *newPassengers;
    newPassengers = new AirlinePassenger[newSize];
    
//Store old array values in new array
    for(int i = 0; i < *arraySize; i++)
    {
        newPassengers[i] = passengers[i];
    }

//Set new array size as standard 
    *arraySize = newSize;

//Delete old array and store new array's address in old pointer
    delete [] passengers;
    passengers = newPassengers;

} 

/**
 * Append the new record to the passengers array. Here we double the 
 * array capacity whenever it is full. Assuming that the passenger to
 * be added is already checked if it satisfies the query params.
 */
void addPassenger(AirlinePassenger *&passengers, AirlinePassenger airlinePassenger, int &arrCapacity, int &recordIdx, int &doublingCounter) {

int *ptr = &arrCapacity;

//Check if array needs resizing
    if(recordIdx==arrCapacity)
    {
        resizeArr(passengers, ptr);

        doublingCounter++;
    }

//Append new passenger to passengers array
    passengers[recordIdx].age = airlinePassenger.age;
    passengers[recordIdx].name = airlinePassenger.name;
    passengers[recordIdx].airline = airlinePassenger.airline;
    passengers[recordIdx].location = airlinePassenger.location;

//Advance Index
    recordIdx++;

}

/**
 * Sorting the array of structs in descending order of age.
 * Tie breaker: Alphabetical order of names.
 */
void sortPassengers(AirlinePassenger *passengers, int length) {
    
AirlinePassenger temp;

//Bubble sorting for loop
for(int i = 0; i<length; i++)
{
    for(int j = i+1; j<length; j++)
    {
        if(passengers[i].age < passengers[j].age)
        {
            temp = passengers[j];
            passengers[j] = passengers[i];
            passengers[i] = temp;
        }

        else if (passengers[i].age == passengers[j].age && passengers[i].name > passengers[j].name)
        {
            temp = passengers[j];
            passengers[j] = passengers[i];
            passengers[i] = temp;        
        }
    }
}


}

/**
 * Call the sortPassenger function and print the name and the age of the passenger.
 */
void printQueriedPassengers(AirlinePassenger *passengers, int numOfRecords) {

//Call sortPassenger function
    sortPassengers(passengers, numOfRecords);

//Print header
    cout << "Queried Passengers\n---------------------------------------" << endl;

//Print passengers
    for(int i = 0; i < numOfRecords; i++)
    {
        cout << passengers[i].name << " " << passengers[i].age << endl;
    }
}
