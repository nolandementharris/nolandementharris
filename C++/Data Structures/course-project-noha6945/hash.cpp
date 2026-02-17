// CPP program to implement hashing with chaining
#include <iostream>
#include "hash.hpp"
#include <sstream>

using namespace std;

node* HashTable::createNode(string restaurantName, node* next)
{
    //Create a new node and store initial data
        node* newNode = new node{restaurantName,PriorityQ(50),next};
        return newNode;
}

HashTable::HashTable(int bsize)
{
    //Establish a new hashtable
        tableSize = bsize;
        table = new node*[tableSize];
        numCollision = 0;
        for(int i = 0; i <tableSize; i++) {
            table[i] = nullptr;
        }
}

HashTable::~HashTable()
{
    
    //Destructor to destory hashtable and deal with memory 
        node* index = nullptr;
        for(int i = 0; i < tableSize; i++) {
            index = table[i];
            while(index) {
                node* current = index;
                index = index->next;
                delete current;
            }
        }
        delete[] table;
}

void HashTable::displayTable()
{
    cout << "-----------------" << endl;
    for(int i = 0; i < tableSize; i++) {
        cout << i << " | ";
        node* current = table[i];
        if(current != nullptr) {
            cout << current->restaurantName << "-->";
            current = current->next;
            while(current != nullptr) {
                cout << current->restaurantName << "-->";
                current = current->next;
            }
        }
        cout << "NULL" << endl;
        cout << "-----------------" << endl;
    }
}

unsigned int HashTable::hashFunction(string restaurantName)
{
    int sum = 0;
    int key;
    for(char c : restaurantName) {
        sum += c;
    }
    key = sum % tableSize;
    return key;
}

node* HashTable::searchItem(string restaurantName)
{
    int key = hashFunction(restaurantName);
    if(key > tableSize || key < 0) return nullptr;
    node* current = table[key];
    if(current == nullptr) return nullptr;
    if(current != nullptr) {
        if(current->restaurantName == restaurantName) return current;
        node* temp = current->next;
        while(temp) {
            if(temp->restaurantName == restaurantName) return temp;
            temp = temp->next;
        }
    }
    return nullptr;
}

void HashTable::insertItem(ReviewInfo restaurant)
{
    node* current = searchItem(restaurant.restaurantName);
    if(current == nullptr){
        int key = hashFunction(restaurant.restaurantName);
        node* index = table[key];
        if(index) {
            numCollision++;
        }
            node* newNode = createNode(restaurant.restaurantName,index);
            table[key] = newNode;
            current = newNode;
    }
    current->pq.insertElement(restaurant);
}


void HashTable::setup(string fname)
{
    ifstream infile;
    infile.open(fname);
    string line;
    string tmp;
    if(infile.is_open()) {
        while (getline(infile,line)) {
            stringstream ss(line);
            ReviewInfo temp;
            getline(ss,temp.restaurantName,';');
            getline(ss,temp.review,';');
            getline(ss,temp.customer,';');
            getline(ss,tmp);
            stringstream (tmp) >> temp.time;
            insertItem(temp);
    }
    infile.close();
    } else {
        cout << "Error: Unable to open file" << endl;
    }
}