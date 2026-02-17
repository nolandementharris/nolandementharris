
#include "BrowserHistory.hpp"

BrowserHistory::BrowserHistory()
{
    // No changes needed
}

BrowserHistory::~BrowserHistory()
{
    // No changes needed
}

/*
 * Purpose: Has to detect if a defect is present in the linkedlist pointed by head
 * @param none
 * @return integer length of defect if one exists. If defect not present return -1
 */
int BrowserHistory::findDefectLength(){

//Initialize fast and slow pointers
    WebPage *slow = head;
    WebPage *fast = head;
    int i = 1;

//Check if list is empty
    if(isEmpty() == true)
    {
        return -1;
    }

//While loop to find possible defect
    while(fast != nullptr && fast->next != nullptr)
    {
    //set fast and slow pointers to traverse list
        slow = slow->next;
        fast = fast->next->next;
    //Determine if loop exists
        if(slow == fast)
        {
            return i;
        }
        i++;
    }
    delete slow;
    delete fast;
    return -1;
}

/*
 * Purpose: Has to remove all the WebPage nodes from [start, end] inclusive.
 * Has to print appropriate messages on cout like below if the linkedlist is empty
 * or if the values of start/ end are improper
 * follow the same order for couts in the writeup - check empty list first, then check wrong start/end values
 * @param integers start and end (1 based indexing not 0 based)
 * @return none
 */
void BrowserHistory::removeWebPages(int start, int end){

//Declare Variables
    int i = start;
    int j = 1;
    int count = 0;
    WebPage *current = head;
    WebPage *temp = head;

//Find length of LL
    while(temp != NULL)
    {
        count++;
        temp = temp->next;
    }

//if loop to ensure arguments are within bounds
    if(head == nullptr)
    {
    //Print empty
        cout << "Browsing history is Empty" << endl;
        return;
    }
    else if(start < 1 || start > end || end > count)
    {
    //Print error
        cout << "Invalid start or end values" << endl;
        return;
    }

//While loop to delete elements
    while(current != nullptr)
    {
    //Determine where to delete inputs
        if(i == 1) //If first element to be deleted is the head, move head forward
        {
        //Delete first element
            WebPage *temp = nullptr;
            temp = current;
            head = current->next;
            current = current->next;
            delete temp;

        //Progress through list
            i++;
            j++;

            continue;
        }
        else if(j >= (start-1) && j <= (end-1) && start != 1) //If elements to be deleted will NOT affect the head
        {
        //Establish previous pointer
            WebPage *prev = current;
            current = current->next;

        //While current pointer is inside deletion bounds, delete element
            while(j <= end-1)
            {
                WebPage *temp = nullptr;
                temp = current;
                prev->next = current->next;
                delete temp;
                current = current->next;
                j++;
            }

        //Progress through list
            i++; 
            j++;

            continue;
        }
        else if (j >= (start-1) && j <= (end) && start == 1)
        {
           //Delete first element
            WebPage *temp = nullptr;
            temp = current;
            head = current->next;
            current = current->next;
            delete temp;

        //Progress through list
            i++;
            j++;

            continue; 
        }
        else{
        i++;
        j++;
        current = current->next;
        }
    }
}


/*
 * Purpose: Interweave the webpages alternatively into a new linkedlist 
 * starting with the first webpage in the list one
 * Assign the head of the new interweaved list to the head of this BrowserHistory
 * DO NOT create new nodes and copy the data, just use the same nodes from one and two and change pointers
 * If one of them runs out of length append the remaining of the other one at end
 * @param two linkedlist heads one and two
 * @return none
 */
void BrowserHistory::mergeTwoHistories(WebPage *headOne, WebPage * headTwo){

//Set current pointers
    WebPage *currentOne = headOne;
    WebPage *currentTwo = headTwo;

//Determine if either list is empty
    if(headOne == NULL)
    {
    //Set head to second list if first is empty
        head = headTwo;
    }
    else if(headTwo == NULL)
    {
    //Set head to first list if second is empty
        head = headOne;
    }

//If loop to merge histories
    while(currentOne != NULL && currentTwo != NULL)
    {
    //Declare temp
        WebPage *nextOne = nullptr;
        WebPage *nextTwo = nullptr;
    //Alternate each history
        nextOne = currentOne->next;
        nextTwo = currentTwo->next;

        currentOne->next = currentTwo;
        currentTwo->next = nextOne;

        currentOne = nextOne;
        currentTwo = nextTwo;

        headTwo = nextTwo;
    }

//Return list with new head
    head = headOne;
}
