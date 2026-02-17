#include "ShopQueue.hpp"
#include <iostream>

using namespace std;

ShopQueue::ShopQueue() {
//Initialize Queue pointers
   queueEnd = nullptr;
   queueFront = nullptr;
}

ShopQueue::~ShopQueue() {
while(!isEmpty())
{
   dequeue();
}
}

/**
 * Checks if the shopqueue is empty or not
 * @returns Whether its empty or not
 */ 
bool ShopQueue::isEmpty() {

if (queueEnd == NULL && queueFront == NULL)
   return true;
else
   return false;
}

/**
 * Looks at the shopqueue and returns the most 'urgent' order on the queue. No elements should be removed.
 * @return A customer order
 */
CustomerOrder* ShopQueue::peek() {

//Print error if queue is empty
   if(isEmpty())
   {
      cout << "Queue empty, cannot peek!" << endl;
      return nullptr;
   }
   else{
      return queueFront;
   }
}

/**
 * Adds the customers to the queue.
 * @param name The name of the customer to add.
 * @param num_pancakes The number of pancakes to add
 * @param type_of_pancake The type of pancake to add. 
 * 
 */
void ShopQueue::enqueue(string name, int num_pancakes, int type_of_pancake) {

//Initialize new order and temp pointers
   CustomerOrder *newOrder = new CustomerOrder;

//Initialize new values into the order
   newOrder->name = name;
   newOrder->number_of_pancakes = num_pancakes;
   newOrder->type_of_pancakes = type_of_pancake;
   newOrder->next = NULL;

//queue is empty, set end and front pointers to new node, otherwise change end pointer
   if(isEmpty())
   {
      queueEnd = newOrder;
      queueFront = newOrder;
      return;
   }
      queueEnd->next = newOrder;  
      queueEnd = newOrder;
}

void ShopQueue::dequeue() {

//Determine if queue is empty
   if(isEmpty())
   {
   //If queue is empty, print error
      cout << "Queue empty, cannot dequeue!" << endl;
      return;
   }
   
//If only one element in array, delete and set pointers to NULL
   if(queueEnd == queueFront)
   {
      CustomerOrder *temp = queueFront;
      queueEnd = queueFront = NULL;
      delete temp;
      return;
   }

//Delete front element
   CustomerOrder *temp = queueFront;
   queueFront = queueFront->next;
   delete temp;

//If front is now null, change rear as well
   if(queueFront == NULL)
   {
      queueEnd = NULL;
   }
}

/**
 * Should return the total number of customers in the queue. 
 * @returns The total number of elements
 */
int ShopQueue::queueSize(){
   
//Declare variables
   int count = 0;
   CustomerOrder *current = nullptr;
   current = queueFront;

//While loop to find size
   while(current != nullptr)
   {
      current = current->next;
      count++;
   }
   return count;
}

/**
 * Just returns the end of the queue. Used for testing. Do not touch! :)
 */ 
CustomerOrder* ShopQueue::getQueueEnd(){
   return queueEnd;
}