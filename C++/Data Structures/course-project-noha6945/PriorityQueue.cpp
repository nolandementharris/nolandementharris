#include "PriorityQueue.hpp"
#include <limits.h>
#include <cmath>

using namespace std;

void swap(ReviewInfo *a, ReviewInfo *b)
{
    ReviewInfo temp = *a;
    *a = *b;
    *b = temp;
}

/*
Constructor for our MinHeap implementation
*/
PriorityQ::PriorityQ(int cap)
{
    capacity = cap;
    currentSize = 0;
    heapArr = new ReviewInfo[cap];
}

/*
Destructor
*/
PriorityQ::~PriorityQ()
{
    if(heapArr != nullptr)
        delete[] heapArr;
        heapArr = nullptr;
}

/*
Finds the parent of a node, given its index.
*/
int PriorityQ::parent(int index)
{
    int parent = (index-1)/2;
    return(parent);
}

/*
Returns the left child of a node.
*/
int PriorityQ::leftChild(int index)
{
    int left = (2 * index) + 1;
    return(left);
}

/*
Returns the right child of a node.
*/
int PriorityQ::rightChild(int index)
{
    int right = (2 * index) + 2;
    return(right);
}

void PriorityQ::peek()
{
    if(isEmpty()) cout << "no record found" << endl;
    else {
        ReviewInfo rw = heapArr[0];
        cout << "Restaurant: "<< rw.restaurantName << endl;
        cout << "Customer: " << rw.customer << endl;
        cout << "Review: " << rw.review << endl;
        cout << "Time: " << rw.time << endl;
    }
}

void PriorityQ::heapify(int i)
{
    int min = i;
    int left = leftChild(i);
    int right = rightChild(i);

    if(left < currentSize && heapArr[left].time < heapArr[min].time) {
        min = left;
    }
    if(right < currentSize && heapArr[right].time < heapArr[min].time) {
        min = right;
    }
    if(min != i) {
        swap(&heapArr[i],&heapArr[min]);
        heapify(min);
    }
}

void PriorityQ::insertElement(ReviewInfo restaurant)
{
    if(currentSize == capacity) {
        cout << "Maximum heap size reached. Cannot insert anymore reviews." << endl;
        return;
    }
    else {
        heapArr[currentSize] = restaurant;
        currentSize++;
        heapify(0);
    }
}

/*
Prints the elements in the heap
*/
void PriorityQ::print()
{
    for(int i = 0; i < currentSize; i++) {
    cout << "\t" << "Customer: " << heapArr[i].customer << endl;
    cout << "\t" << "Review: " << heapArr[i].review << endl;
    cout << "\t" << "Time: " << heapArr[i].time << endl;
    cout << "\t" << "=====" << endl;
    }
}

// Method to remove minimum element (or root) from min heap
void PriorityQ::pop()
{
    if(!isEmpty()) {
        heapArr[0] = heapArr[currentSize-1];
        currentSize--;
        heapify(0);
    }
}
