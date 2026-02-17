#include "ShowCatalog.hpp"
#include <iostream>
#include <string>
#include <fstream>
#include <sstream>

using namespace std;

void deleteTreeHelper(ShowItem* node);
void printHelper(ShowItem* node);
ShowItem* getShowHelper(ShowItem* current, string title);
ShowItem* addShowHelper(ShowItem* newNode, ShowItem* current);
void searchShowsHelper(ShowItem* current, char titleChar);
void printLeafHelper(ShowItem* current);
void ratingHelper(ShowItem* current, int &count, string showRating);

ShowCatalog::ShowCatalog() {

//Initialize root pointer
    root = NULL;
}

void deleteTreeHelper(ShowItem* node){

//Determine if node is null
    if(node == NULL) return;

//Delete left and right nodes
    deleteTreeHelper(node->left);
    deleteTreeHelper(node->right);

//Delete current node
    delete node;

}

ShowCatalog::~ShowCatalog() {

//Call deleteTree helper function
    deleteTreeHelper(root);

}

void ShowCatalog::printShowCatalog() {

//Determine if catalog is empty
    if(root == nullptr) {
        cout <<"Tree is Empty. Cannot print" << endl;
        return;
    }

//Call printHelper function 
    printHelper(root);

}

void printHelper(ShowItem* node) {

//If node is null, return
    if(node == NULL) return;

//print current show
    cout << "Show: " << node->title << " " << node->userRating << endl;

//Traverse BST to print all node using preorder method
    printHelper(node->left);
    printHelper(node->right);

}

ShowItem* getShowHelper(ShowItem* current, string title) {

//Determine if current node is null
    if(current == NULL || current->title == title) return(current);

//Otherwise traverse through nodes by alphabet
    if(current->title < title) {
        return(getShowHelper(current->right, title));
    }
    else if(current->title > title) {
        return(getShowHelper(current->left,title));
    }
}

void ShowCatalog::getShow(string title) {

//Call getShowHelper
    ShowItem* node = getShowHelper(root, title);

//Print error
    if(node == NULL) cout << "Show not found." << endl;

//Print found show
    if(node != NULL) {

    //Print show info
        cout << "Show Info:" << endl;
        cout << "==================" << endl;
        cout << "Title :" << node->title << endl;
        cout << "Year :" << node->year << endl;
        cout << "Show Rating :" << node->showRating << endl;
        cout << "User Rating :" << node->userRating << endl;
    }
}

void ShowCatalog::addShowItem(string title, int year, string showRating, float userRating) {

//Initialize new node
    ShowItem* newNode = new ShowItem(title,year,showRating,userRating);

//Determine if root is NULL
    if(root == NULL) {

    //Set root equal to new node
        root = newNode;
    }
    else{

    //Call addShowHelper function
        addShowHelper(newNode, root);
    }
}

ShowItem* addShowHelper(ShowItem* newNode, ShowItem* current) {

//Determine if current node is NULL
    if(current == NULL) {
        return(newNode);
    } 

//Determine if current data is greater or less than new data
    if(newNode->title > current->title) {
    
    //Check right node
        current->right = addShowHelper(newNode, current->right);
    }
    else if(newNode->title < current->title) {

    //Check left node
        current->left = addShowHelper(newNode, current->left);
    }
    return current;
}

void printLeafHelper(ShowItem* current) {

//Determine if node is empty
    if(current == NULL) return;

//If both left and right nodes are null, print
    if(current->left == NULL && current->right == NULL) {

    //Print title
        cout << current->title << endl;
        return;
    }
    else {

    //Recursively check left and right subtrees
        printLeafHelper(current->left);
        printLeafHelper(current->right);
    }

}

void ShowCatalog::printLeafNodes() {

//Call printLeafHelper
    printLeafHelper(root);
}

void searchShowsHelper(ShowItem* current, char titleChar) {

//Determine if current node is null
    if(current == NULL) return;

//Variable declaration
    string charTitle = current->title;

//Determine if shows matches title character
    if(charTitle[0] == titleChar) {
        cout << current->title << "(" << current->year << ") " << current->userRating << endl;
    }
    
//Traverse the next search trees
    searchShowsHelper(current->left, titleChar);
    searchShowsHelper(current->right, titleChar);

}

void ShowCatalog::searchShows(char titleChar) {

//Determine if tree is empty
    if(root == NULL) {
    cout << "Tree is empty. Cannot search Shows" << endl;
    return;
    }

//Print intro message
        cout << "Shows that starts with " << titleChar << ":" << endl;

    //Call searchShowsHelper function
        searchShowsHelper(root, titleChar);
}

void ratingHelper(ShowItem* current, int &count, string showRating) {

//Determine if node is null
    if(current == NULL) return;

//Determine if current has the correct show rating
    if(current->showRating == showRating) count++;

//traverse through rest of tree to look at all the nodes
    ratingHelper(current->left, count, showRating);
    ratingHelper(current->right, count, showRating);
}
void ShowCatalog::displayNumShowRating(int &count, string showRating) {

//Call ratingHelper
    ratingHelper(root, count, showRating);
}
