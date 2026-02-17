#include "ShowCatalog.hpp"
#include <iostream>
#include <string>
#include <fstream>
#include <sstream>

using namespace std;

/* Completed functions. DO NOT MODIFY*/
ShowCatalog::ShowCatalog()
{
    root = nullptr;
}

/* Completed functions. DO NOT MODIFY*/
void destroyNode(ShowItem *current)
{
    if (current != nullptr)
    {
        destroyNode(current->left);
        destroyNode(current->right);

        delete current;
        current = nullptr;
    }
}

/* Completed functions. DO NOT MODIFY*/
ShowCatalog::~ShowCatalog()
{
    destroyNode(root);
}

/* Completed functions. DO NOT MODIFY*/
void printShowHelper(ShowItem *m)
{
    if (m != nullptr)
    {
        cout << "Show: " << m->title << " " << m->userRating << endl;
        printShowHelper(m->left);
        printShowHelper(m->right);
    }
}

/* Completed functions. DO NOT MODIFY*/
void ShowCatalog::printShowCatalog()
{
    if (root == nullptr)
    {
        cout << "Tree is Empty. Cannot print" << endl;
        return;
    }
    printShowHelper(root);
}

/* Completed functions. DO NOT MODIFY*/
ShowItem *getShowHelper(ShowItem *current, string title)
{
    if (current == NULL)
        return NULL;

    if (current->title == title)
        return current;

    if (current->title > title)
        return getShowHelper(current->left, title);

    return getShowHelper(current->right, title);
}

/* Completed functions. DO NOT MODIFY*/
void ShowCatalog::getShow(string title)
{
    ShowItem *node = getShowHelper(root, title);
    if (node != nullptr)
    {
        cout << "Show Info:" << endl;
        cout << "==================" << endl;
        cout << "Title :" << node->title << endl;
        cout << "Year :" << node->year << endl;
        cout << "Show Rating :" << node->showRating << endl;
        cout << "User Rating :" << node->userRating << endl;
        return;
    }

    cout << "Show not found." << endl;
}

/* Completed functions. DO NOT MODIFY*/
ShowItem *addNodeHelper(ShowItem *current, ShowItem *newNode)
{
    if (current == nullptr)
    {
        return newNode;
    }

    if (current->title > newNode->title)
    {
        current->left = addNodeHelper(current->left, newNode);
    }
    else
    {
        current->right = addNodeHelper(current->right, newNode);
    }

    return current;
}

/* Completed functions. DO NOT MODIFY*/
void ShowCatalog::addShowItem(string title, int year, string showRating, float userRating)
{
    if (root == nullptr)
    {
        root = new ShowItem(title, year, showRating, userRating);
        return;
    }

    root = addNodeHelper(root, new ShowItem(title, year, showRating, userRating));
}

ShowItem* removeShowHelper(ShowItem* current, string title) {

//Determine if current node is NULL
    if(current == NULL)
        return current;

//Determine if current title comes before or after desired title
    if(current->title > title) {
        current->left = removeShowHelper(current->left, title);
        //return current;
    }
    else if(current->title < title) {
        current->right = removeShowHelper(current->right, title);
        //return current;
    }

    if(current->title == title) {
//Determine how many children the node has
    //No children
    if(current->left == NULL && current->right == NULL) {
        delete current;
        return NULL;
    } 
    //One child on right
    if(current->left == NULL) {
        ShowItem* tmp = current->right;
        delete current;
        return tmp;
    }
    //One child on left
    else if(current->right == NULL) {
        ShowItem* tmp = current->left;
        delete current;
        return tmp;
    }
    //If the current node still has two children
    else {

    //Declare parent
        ShowItem* parent = current;
        ShowItem* next = current->right;

    //Find the next node to replace 
        while(next->left != NULL) {
            parent = next;
            next = next->left;
        }
        
        if(parent != current) {
            parent->left = next->right;
        }
        else if(parent == current) {
            parent->right = next->right;
        }

        current->showRating = next->showRating;
        current->title = next->title;
        current->userRating = next->userRating;
        current->year = next->year;

        delete next;
    }
    }
    return current;
}

void ShowCatalog::removeShow(std::string title)
{

//Determine if root is node to be deleted 
    if(root != NULL && root->title == title) {
        ShowItem* tmp = NULL;
        tmp = root;
        root = NULL;
        delete tmp;
        return;
    }
    else if(root != nullptr) {
    //Call remove show helper
        removeShowHelper(root, title);
    }
}

/*Diagram for BST trees for reference

                X
               / \
              a   Y
                 / \
                b   c
*/

ShowItem* findNode(ShowItem* node, string title) {

//Traverse tree to find desired node
    if(node == NULL || node->title == title) return(node);
    else if(node->title > title) return (findNode(node->left, title));
    else if( node->title < title) return(findNode(node->right, title));
    else return NULL;
}

ShowItem* findParentNode(ShowItem* current, string title) {

//Check current children for desired value
    if(current == NULL) return(current);
    else if(!current->left && !current->right) return(NULL);
    else if(current->left && current->left->title == title) return(current);
    else if(current->right && current->right->title == title) return(current);

//Call recursive function to continue traversal
    if(current->title > title) return(findParentNode(current->left, title));
    else if(current->title < title) return(findParentNode(current->right, title));
    else return NULL;
}

void ShowCatalog::rightRotate(std::string title)
{
//Determine if bst is empty
    if(root == NULL) return;

//Call findNode and findParentNode function to find desired node to rotate on
    ShowItem* node = findNode(root, title);
    ShowItem* parent = findParentNode(root, title);

//Define initial pointers
    ShowItem* x = node->left;
    ShowItem* y = node;
    ShowItem* x_p = y;
    ShowItem* y_p = parent;

//Determine if y has a left child or not
    if(!y->left) return;

//Re-sort BST by rotating left
    y->left = x->right;     //Set y's left child equal to x's right child
    x->right = y;           //Set x's right child equal to y
    if(parent == NULL) {    //Determine if rotating node is the root
        root = x;
        x_p = NULL;
    }
    //Determine which child the node is relative to the parent
        else if(parent->left == node) {
            parent->left = x;
            x_p = parent;
        }
        else if(parent->right == node) {
            parent->right = x;
            x_p = parent;
        }
    y_p = x; // Set the y parent equal to x
}

/* TODO */
void ShowCatalog::leftRotate(std::string title)
{
//Determine if bst is empty
    if(root == NULL) return;

//Call findNode and findParentNode function to find desired node to rotate on
    ShowItem* node = findNode(root, title);
    ShowItem* parent = findParentNode(root, title);

//Define initial pointers
    ShowItem* x = node;
    ShowItem* y = node->right;
    ShowItem* x_p = parent;
    ShowItem* y_p = x;

//Determine if x has no right child
    if(!x->right) return;

//Re-sort BST by rotating left
    x->right = y->left;     //Set x's right child equal to y's left child
    y->left = x;            //Set y's left child equal to x
    if(parent == NULL) {    //Determine if the roatating node is the root
        root = y;
        y_p = NULL;
    }
    //Determine if the node is the right or left child relative to the parent node
        else if(parent->left == node) {
            parent->left = y;
            y_p = parent;
        }
        else if(parent->right == node) {
            parent->right = y;
            y_p = parent;
        }
    x_p = y; //Set x's parent equal to y 
}
