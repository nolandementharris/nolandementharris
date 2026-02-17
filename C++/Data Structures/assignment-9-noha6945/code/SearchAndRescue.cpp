#include "SearchAndRescue.hpp"
#include <vector>
#include <stack>
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

using namespace std;


SearchAndRescue::SearchAndRescue(string fileName)
{
    terrain = new int*[4];
    string line;
    ifstream infile(fileName);
    if (infile.is_open())
    {
        for(int i = 0; getline(infile, line); i++)
        {   
            terrain[i] = new int[4];
            stringstream ss(line);
            string s;
            for (int j = 0; getline(ss, s, ' '); j++)
            {
                terrain[i][j] = stoi(s);
            }
        }
    }
    path = vector<State*>();
}


SearchAndRescue::~SearchAndRescue()
{
    State* to_del = path.back();
    delete to_del;
    path.pop_back();

    for (int i = 0; i < 4; i++)
    {
        delete terrain[i];
    }
    delete terrain;
}


void SearchAndRescue::possibleActions(State* current)
{
//Determine if current state is within bounds
    if(current->y < 3) current->possible_actions.push_back("up");
    if(current->y > 0) current->possible_actions.push_back("down");
    if(current->x > 0) current->possible_actions.push_back("left");
    if(current->x < 3) current->possible_actions.push_back("right");
}


State* SearchAndRescue::result(State* current, string action)
{

    State* newState = new State{current->x, current->y, current->saved_people, action, vector<string>()};

//Determine which action and iterate corresponding coordinate
    if(action == "up" && current->y < 3) {
        newState->y++;
        newState->prev_action = "up";
    }
    if(action == "down" && current->y > 0) {
        newState->y--;
        newState->prev_action = "down";
    }
    if(action == "left" && current->x > 0) {
        newState->x--;
        newState->prev_action = "left";
    }
    if(action == "right" && current->x < 3) {
        newState->x++;
        newState->prev_action = "right";
    }

    return newState;
}


vector<State*> SearchAndRescue::expand(State* current)
{
//Declare Variables
    vector<State*> expansion = vector<State*>();
    vector<string>::iterator actions;
    vector<State*>::iterator iter;
    possibleActions(current);

    for(actions = current->possible_actions.begin(); actions != current->possible_actions.end(); actions++) {
        expansion.push_back(result(current, *actions));
    }
    return expansion;
}


bool SearchAndRescue::iterativeDeepeningWrapper(State* start)
{
//Declare variables
    int depth = STARTING_DEPTH;
    bool found = false;
    if(start != NULL) {
        path.push_back(start);
    //Loop until end is found
        while(!found) {
            found = iterativeDeepeningSearch(start, depth);
            if(found == true) return true;
            else depth++;
            if(depth == 20) return false;
        }
    }
    return found;
}


bool SearchAndRescue::iterativeDeepeningSearch(State* current, int depth_limit)
{
    if(depth_limit <= 0) return false;
    if(isGoal(current)) {
        //path.push_back(current);
        return true;
    }

    if(terrain[current->x][current->y] != 1 && terrain[current->x][current->y] != 2 && terrain[current->x][current->y] != 3) return false;

    bool saved = false;

    if(terrain[current->x][current->y] == 2) {
        current->saved_people++;
        saved = true;
        terrain[current->x][current->y] = 1;
    }
    
    vector<State*> expansion = expand(current);

    if(terrain[current->x][current->y] == 1 || terrain[current->x][current->y] == 2) {

    vector<State*>::iterator iter;

    for(iter = expansion.begin(); iter != expansion.end(); iter++) {

        path.push_back(*iter);
        (*iter)->saved_people = current->saved_people;
        if(iterativeDeepeningSearch(*iter,depth_limit-1)) {
            return true;
        }
        else {
            State* tmp = (*iter);
            path.pop_back();
            delete tmp;
        }
    }
    }
    if(saved == true) {
        current->saved_people--;
        terrain[current->x][current->y] = 2;
    }
    return false;
}

void SearchAndRescue::printPath()
{
    vector<State*>::iterator state;
    for(state = path.begin(); state != path.end(); state++) {
        cout << "x: " << (*state)->x << "\ty: " << (*state)->y << "\tprev_action: " << (*state)->prev_action << "\n";
    }

}


bool SearchAndRescue::isGoal(State* current)
{
    //Determine if number of people saved is true and if the goal is the current tile
    if(terrain[current->x][current->y] == 3 && current->saved_people == PEOPLE_TO_SAVE) return true;
    else return false;
}


void SearchAndRescue::printTerrain()
{
    int i = 0;
    int j = 0;
    for(i = 3; i > -1; i--) {
        for(j = 0; j < 4; j++) {
            cout << terrain[j][i] << " ";
        }
        cout << endl;
    }
}
