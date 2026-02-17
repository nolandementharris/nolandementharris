#include <iostream>
#include <cstdlib>
#include <iostream>
#include "Register.hpp"


using namespace std;

Register::Register(){
   top = 0;
}

/*
 * If the register is full or not
 * @returns 
 */
bool Register::isFull(){
   
   bool x = false;

//Find if customer orders has met max capacity
   if(top == SIZE)
   {
      x = true;
   }
   return x;
}

/*
 * Adds money to stack.
 * @param money: the type of pancake's price times the quantity
 */
void Register::push( int money ){

//Determine if register is full
   bool x;
   x = isFull();
//If stack is not full, push new money
   if(x == false)
   {
      top = top+1;
      a[top] = money;
   }
   else
   {
      cout << "Stack overflow: " << endl;
   }
}


/*
 * Checks if stack is full. 
 * @returns a bool
 */
bool Register::isEmpty(){

   return(top < 1);
}

/*
 * Looping through the stack array to display amounts
 */
void Register::disp(){

//Display top element
   cout << "top = " << top << endl;

//print stack
   for(int i = top-1; i > 0; i--)
   {
      cout << a[i] << endl;
   }
}

int Register::pop(){

//Determine if stack is empty
   if(isEmpty())
   {
   //If stack is empty, return error message
      cout << "Stack empty, cannot pop an item!" << endl;
      return -1;
   }

//find top
   int y = a[top];
   a[top] = 0;
   top = top-1;

   return y;
}