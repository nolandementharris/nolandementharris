/*************************************************************/
/*                BrowserHistory Definition                  */
/*************************************************************/
/* TODO: Implement the member functions of BrowserHistory    */
/*     This class uses a linked-list of WebPage structs to   */
/*     represent the schedule of web pages                   */
/*************************************************************/

#include "browserHistory.hpp"
#include <iostream>
#include <fstream>
#include <cstdlib>
#include <string>

using namespace std;

/*
 * Purpose: Constructor for empty linked list
 * @param none
 * @return none
 */
BrowserHistory::BrowserHistory() {
    /*
    DO NOT MODIFY THIS
    This constructor is already complete. 
    */
    head = nullptr;
}

/*
 * Purpose: Check if list is empty
 * @return true if empty; else false
 */
bool BrowserHistory::isEmpty() {
    /* finished. do not touch. */
    return (head == NULL);
}

/*
 * Purpose: prints the current list of pages 
 * in the given format.
 * [ID::1]-(URL::url1) -> ... -> NULL
 * @param none
 * @return none
 */
void BrowserHistory::displayHistory() {

//Check if list is empty
    bool empty;
    empty = isEmpty();

//Point initial pointer to head
    WebPage *tmp = head;

//Display current browser history
    if(empty == false)
    {
        cout << "== CURRENT BROWSER HISTORY ==" << endl;
        
        while(tmp != NULL)
        {
            cout  <<  "[ID:: "  <<  tmp->id  <<  "]-(URL::"  <<  tmp->url  <<  ") -> ";

            tmp = tmp->next;
        }
            cout  <<  "NULL\n===\n";
    }
    else
    {
        cout << "== CURRENT BROWSER HISTORY ==" << endl;
        cout << "Empty History" << endl;
        cout  <<  "NULL\n===\n";
    }
    }

/*
 * Purpose: Add a new webpage to the browser history LL
 *   between the previous and the page that follows it in the list.
 * @param previousPage, the show that comes before the new page
 * @param newPage, the webpage to be added. 
 * @return none
 */
void BrowserHistory::addWebPage(WebPage* previousPage, WebPage* newPage) {

//If loop to determine if previous page is null
    if(previousPage == NULL)
    {
    //Reassign pointers to insert at front of list
        WebPage *temp = head;
        head = newPage;
        head->next = temp;

    //Print new page location
        cout << "adding: " << "[" << newPage->id << "]-" << newPage->url << " (HEAD)\n";
    }
    else
    {
    //Reassign pointers to insert new web page into linked list
        newPage->next = previousPage->next;
        previousPage->next = newPage;

    //Print new page location
        cout << "adding: " << "[" << newPage->id << "]-" << newPage->url << " (prev: " << "[" << previousPage->id << "])\n";
    }
}

/*
 * Purpose: populates the BrowserHistory with the predetermined pages
 * @param none
 * @return none
 */
void BrowserHistory::buildBrowserHistory() {

//Initialize new webpages
    WebPage *newPage0 = new WebPage;
    WebPage *newPage1 = new WebPage;
    WebPage *newPage2 = new WebPage;
    WebPage *newPage3 = new WebPage;
    WebPage *newPage4 = new WebPage;

//Fill data
    newPage0->url = "https://www.colorado.edu/";
    newPage0->id = 10;
    newPage0->views = 0;
    newPage0->owner = "Empty string";
    addWebPage(NULL, newPage0);

    newPage1->url = "https://www.wikipedia.org/";
    newPage1->id = 11;
    newPage1->views = 0;
    newPage1->owner = "Empty string";
    addWebPage(newPage0, newPage1);

    newPage2->url = "https://brilliant.org/";
    newPage2->id = 12;
    newPage2->views = 0;
    newPage2->owner = "Empty string";
    addWebPage(newPage1, newPage2);

    newPage3->url = "https://www.khanacademy.org/";
    newPage3->id = 13;
    newPage3->views = 0;
    newPage3->owner = "Empty string";
    addWebPage(newPage2, newPage3);

    newPage4->url = "https://www.numberphile.com/";
    newPage4->id = 14;
    newPage4->views = 0;
    newPage4->owner = "Empty string";
    addWebPage(newPage3, newPage4);

}


/*
 * Purpose: Search the BrowserHistory for the specified 
 * web page by ID and return a pointer to that node.
 * @param int id - ID of the web page to look for in LL.
 * @return pointer to node of page, or NULL if not found
 *
 */
WebPage* BrowserHistory::searchPageByID(int id) {

//Declare temporary pointer
    WebPage* current = head;

//Use while loop to search BrowserHistory
    while(current != 0)
    {
        if(current->id == id)
        {
            return current;
        }

        current = current->next;
    }

    return nullptr;
}


/*
 * Purpose: Search the BrowserHistory for the specified 
 * web page by the URL and return a pointer to that node.
 * @param string url - url of the web page to look for in LL.
 * @return pointer to node of page, or NULL if not found
 *
 */
WebPage* BrowserHistory::searchPageByURL(std::string url) {

//Declare temporary pointer and array
    WebPage* current = head;

//Use while loop to search BrowserHistory
    while(current != 0)
    {
        if(current->url == url)
        {
            return current;
        }

        current = current->next;
    }

    return nullptr;
}

/*
 * Purpose: Give an owner to a web page.
 * @param receiver - name of the show that is receiving the rating
 * @param rating - the rating that is being given to a show
 * @return none
 */
void BrowserHistory::addOwner(std::string url, string owner) {
    
//Find entry that matches given URL
    WebPage* tmp = searchPageByURL(url);

    if(tmp != NULL)
    {
    //Store owner in found entry
        tmp->owner = owner;

    //print verification to user
        cout << "The owner (" << owner << ") has been added for the ID - "<< tmp->id << "\n";
    }
    else
    {
        cout << "Page not found" << endl;
    }
}

void BrowserHistory::updateViews(string url) {

 //Find entry that matches given URL
    WebPage* current = head;

//Loop through web history
    while(current != 0)
    {
        if(current->url == url)
        {
        //Add one view
            current->views++;
        }
    }
}
