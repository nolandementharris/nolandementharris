#include <iostream>
#include "hash.hpp"
#include "PriorityQueue.hpp"
#include <vector>
#include <fstream>
#include <cstdlib>
#include <ctime>
#include <chrono>

using namespace std;
using namespace std::chrono;

void displayMenu() // do not modify
{
    cout << "------------------" << endl;
    cout << "1: Build the data structure (execute this option one time)" << endl;
    cout << "2: Add a review" << endl;
    cout << "3: Retrieve most recent review for a restaurant" << endl;
    cout << "4: Pop most recent review for a restaurant" << endl;
    cout << "5: Print reviews for a restaurant" << endl;
    cout << "6: Display number of collisions" << endl;
    cout << "7: Display table results" << endl;
    cout << "8: Exit" << endl;
    cout << "------------------" << endl;
}

int main(int argc, char* argv[])
{
    if (argc <3)
    {
        cout<<"need correct number of arguments"<<endl;
    }
	
    string fname = argv[1];
    int tableSize = stoi(argv[2]);
    int ch = 0;
    string chs;
    HashTable ht(5);
    int flag = 0;
	
    while(ch!=8)
    {
        displayMenu();
        cout << "Enter your choice >>";
        getline(cin, chs);
        ch = stoi(chs);
        switch (ch)
        {
            case 1:
			{
                if(flag > 0) {
                    cout << "Cannot setup table multiple times." << endl;
                    break;
                }
				ht.setup(fname);
                flag++;
				break;
            }
            case 2:
			{
                ReviewInfo *newReview = new ReviewInfo;
                string time;
                cin.clear();
                cout << "Restaurant Name: ";
                cin >> newReview->restaurantName;
                cin.ignore(numeric_limits<streamsize>::max(), '\n'); 
                cout << "Customer: ";
                cin >> newReview->customer;
                cin.ignore(numeric_limits<streamsize>::max(), '\n'); 
                cout << "Review: ";
                cin >> newReview->review;
                cin.ignore(numeric_limits<streamsize>::max(), '\n');                 
                cout << "Time: ";
                cin >> newReview->time;
                cin.clear();
                cin.ignore(numeric_limits<streamsize>::max(), '\n');

                node* node = ht.searchItem(newReview->restaurantName);
                
                
                if(node != nullptr) ht.insertItem(*newReview);
                else if(node == nullptr) {
                    cout << "Restaurant not found." << endl;
                }
				break;
            }
            case 3:
			{
                string restaurantName;
                cout << "Restaurant Name: ";
                cin >> restaurantName;
                cin.clear();
                cin.ignore(numeric_limits<streamsize>::max(), '\n');
                node* node = ht.searchItem(restaurantName);
                if(node != nullptr) {
                    node->pq.peek();
                }
				break;
            }
            case 4:
			{
                string restaurantName;
                cout << "Restaurant Name: ";
                cin >> restaurantName;
                cin.clear();
                cin.ignore(numeric_limits<streamsize>::max(), '\n');
                node* node = ht.searchItem(restaurantName);
                if(node != nullptr) {
                    node->pq.pop();
                }
                else {
                    cout << "No record found." << endl;
                }
				break;
            }
            case 5:
			{
				string restaurantName;
                cout << "Restaurant Name: ";
                cin >> restaurantName;
                cin.clear();
                cin.ignore(numeric_limits<streamsize>::max(), '\n');
                node* node = ht.searchItem(restaurantName);
                if(node != nullptr) {
                    node->pq.print();
                }
                else {
                    cout << "No record found." << endl;
                }
				break;
			}
            case 6:
                cout << "Number of Collisions: " << ht.getNumCollision() << endl;
                break;
            case 7:
                ht.displayTable();
                break;
            case 8:
                
				break;
            default:
                cout << "Enter a valid option." << endl;
                break;
        }
    }
}
