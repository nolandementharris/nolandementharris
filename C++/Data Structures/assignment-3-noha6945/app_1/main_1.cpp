#include <iostream>
#include <fstream>
#include <cstdlib>
#include <string>
#include "../code_1/browserHistory.hpp"

using namespace std;

void displayMenu();

int main(int argc, char* argv[]) {

    // DO NOT MODIFY THIS.
    if(argc>1) 
    {
        freopen(argv[1],"r",stdin);
    }
    // DO NOT MODIFY ABOVE.

//Declare argument variable for user menu input
    int argument = 0;

//Implement Class for nodes
    BrowserHistory *browserHistory = new BrowserHistory;

while(argument >= 0 && argument <7)
{
    //Display Options
        displayMenu();

    //Receive menu choice
        cin >> argument;

    //Option 1: Build Browser History
        if(argument == 1)
        {
        //Call buildBrowserHistory and displayHistory functions
            browserHistory->buildBrowserHistory();
            browserHistory->displayHistory();
        }

    //Option 2: Display History
        else if(argument == 2)
        {
        //Display Browser History
            browserHistory->displayHistory();
        }

    //Option 3: Add web page
        else if(argument == 3)
        {

        //Declare Variables
            string url;
            WebPage* newPage = new WebPage;
            WebPage* prevPage = new WebPage;
            WebPage* temp;

        //Prompt user for input
            cout << "Enter the new web page's url:" << endl;
            cin >> newPage->url;
            cout << "Enter the new web page's id:" << endl;
            cin >> newPage->id;

        //Check if id is in the browser history
            temp = browserHistory->searchPageByID(newPage->id);

        //If the webpage returned is already in the browser history, loop until valid input is given
            while(temp != NULL)
            {
                cout << "This ID already exists. Try again." << endl;
                cout << "Enter the new web page's id:" << endl;
                cin >> newPage->id;
                temp = browserHistory->searchPageByID(newPage->id);
            }


        //Prompt user for input
            cout << "Enter the previous page's url (or First):" << endl;
            cin >> url;

        //Search for a webpage that has the previous page's url
            prevPage = browserHistory->searchPageByURL(url);

        //if previous page input is invalid, prompt user for new input
            while(prevPage == NULL && url != "First")
            {
                cout << "INVALID(previous page url)... Please enter a VALID previous page url!" << endl;
                cout << "Enter the previous page's url (or First):" << endl;
                cin >> url;

            //Search for given url
                prevPage = browserHistory->searchPageByURL(url);
            }


            if(url == "First")
            {
                prevPage = NULL;

                //Call addwebpage 
                    browserHistory->addWebPage(prevPage,newPage);
            }
            else if(prevPage != NULL)
            {
                //Call addwebpage 
                    browserHistory->addWebPage(prevPage,newPage);
            }

        }

    //Option 4: Add owner
        else if(argument == 4)
        {
        
        //Declare variables
            string url;
            string owner;
            WebPage* temp = NULL;

        //Prompt user for input
            cout << "Enter url of the web page to add the owner:" << endl;
            cin >> url;
            temp = browserHistory->searchPageByURL(url);

        //Determine if input is in browser history
            while(temp == NULL)
            {
                cout << "Page not found. Try again." << endl;
                cout << "Enter url of the web page to add the owner:" << endl;
                cin >> url;
                temp = browserHistory->searchPageByURL(url);
            }

        //Receive input for owner
            cout << "Enter the owner:";
            cin.ignore();
            getline(cin,owner);

        //Call addOwner function
            browserHistory->addOwner(url,owner);
        }

    //Option 5: View count for web page
        else if(argument == 5)
        {

        //Declare Variables
            string url;
            WebPage* page;
            
        //Prompt User for URL
            cout << "Enter url of the web page to check the view count: " << endl;
            cin >> url;

        //Search browser history for URL
            page = browserHistory->searchPageByURL(url);

        //Determine if url is in browser history
            if(page == NULL)
            {

            //Print error
                cout << "Page not found. Try again." << endl;

            //Prompt User for URL
                cout << "Enter url of the web page to check the view count: " << endl;
                cin >> url;

            //Search browser history for URL
                page = browserHistory->searchPageByURL(url);

            }

        //Display view count
            cout << "View count for URL - " << page->url << " is " << page->views << endl;

        }

    //Option 6: Quit
        else if(argument == 6)
        {
        //Print exit message
            cout << "Quitting...Goodbye!\n";

            return 1;
        }
}
    return 0;
}




/************************************************
           Definitions for main_1.cpp
************************************************/
void displayMenu()
{
    // COMPLETE: You DO NOT need to edit this
    cout << "Select a numerical option:" << endl;
    cout << "+=====Main Menu=========+" << endl;
    cout << " 1. Build history " << endl;
    cout << " 2. Display history " << endl;
    cout << " 3. Add web page " << endl;
    cout << " 4. Add owner" << endl;
    cout << " 5. View count for a web page" << endl;
    cout << " 6. Quit " << endl;
    cout << "+-----------------------+" << endl;
    cout << "#> ";
}
