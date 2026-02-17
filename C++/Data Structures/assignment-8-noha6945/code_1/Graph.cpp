#include "Graph.hpp"
#include <vector>
#include <queue>
#include <iostream>
#include <stdlib.h>
#include <bits/stdc++.h>

using namespace std;

vertex* findVertex(string name, vector<vertex*> vertices){

//traverse vertex vector
    vector<vertex*>::iterator vert;
    for(vert = vertices.begin(); vert != vertices.end(); vert++) {
            if( (*vert)->name == name) {
                return (*vert);
            }
        }
}


void Graph::addVertex(string name){

//Declare new vertex
    vertex* newVertex = new vertex;
    newVertex->name = name;
    vertices.push_back(newVertex);
}

void Graph::addEdge(string v1, string v2){

//call findVertex function
    vertex* vertex_1 = NULL;
    vertex* vertex_2 = NULL;
    vertex_1 = findVertex(v1, vertices);
    vertex_2 = findVertex(v2, vertices);
    if (vertex_1 == NULL || vertex_2 == NULL) return;
    adjVertex* adj_1 = new adjVertex;
    adjVertex* adj_2 = new adjVertex;
    adj_1->v = vertex_2;
    adj_2->v = vertex_1;

//Add edge to both adjacency vectors
    vertex_1->adj.push_back(*adj_1);
    vertex_2->adj.push_back(*adj_2);

}

void Graph::displayEdges(){

//Declare iterator to iterate through vertices and then adjacency vector
    vector<vertex*>::iterator vert;
    vector<adjVertex>::iterator iter;

    for(vert = vertices.begin(); vert != vertices.end(); vert++) {

        cout << (*vert)->name << " --> ";

        for(iter = (*vert)->adj.begin(); iter != (*vert)->adj.end(); iter++) {
            cout << iter->v->name << " ";
        }

        cout << endl;
    }
}

void Graph::breadthFirstTraverse(string sourceVertex){

//Declare queue for visited vertices
    queue<vertex*> queue;

//Find sourceVertex
    vertex* vStart= findVertex(sourceVertex, vertices);
    queue.push(vStart);
    vStart->visited = true;
    int distance = 0;

//While loop to search
    while (!queue.empty()) {

    //Declare variables 
        vertex* vertex;
        vertex = queue.front();
        queue.pop();
        vertex->visited = true;
        distance = vertex->distance;

    //See if current vertex is the beginning
        if(vertex == vStart) {
            cout << "Starting vertex (root): " << vertex->name << "-> ";
        }

    //For other vertex traversed from source vertex with distance
        else {
            cout << vertex->name << "(" << vertex->distance << ")" << " ";
        }
    
    //Determine if node has no edges or if the nodes have all been visited
        vector<adjVertex>::iterator temp;
        bool x = true;
        for( temp = vertex->adj.begin(); temp != vertex->adj.end(); temp++) {
            if( temp->v->visited != true) {
                x = false;
                break;
            }
        }

    //Traverse adjacent vertices
    if(!vertex->adj.empty() && x == false) {
        vector<adjVertex>::iterator iter;
        for( iter = vertex->adj.begin(); iter != vertex->adj.end(); iter++) {
            if(iter->v->visited == false && iter->v->distance == 0) {
                iter->v->visited = true;
                queue.push(iter->v);
                queue.back()->distance = distance + 1;
            }
        }
    }
    }

    cout << endl << endl;
}

/*
string::source : source vertex (starting city)
int::k : distance that you can travel from source city with remaining fuel
*/
vector<string> Graph::findReachableCitiesWithinDistanceK(string source, int k){

//Find source node
    vertex* vStart = findVertex(source, vertices);

//Declare variables
    vector<string> cities;
    queue<vertex*> queue;
    queue.push(vStart);
    vStart->visited = true;
    int distance;
    vertex* vertex = vStart;

//While loop to search
    while (!queue.empty()) {

    //Declare variables 
        vertex = queue.front();
        queue.pop();
        //vertex->visited = true;
        distance = vertex->distance;

    //If city distance is within set distance, add to vector
            if(vertex->distance == k && distance != 0) cities.push_back(vertex->name);
    
    //Determine if node has no edges or if the nodes have all been visited
        vector<adjVertex>::iterator temp;
        bool x = true;
        for( temp = vertex->adj.begin(); temp != vertex->adj.end(); temp++) {
            if( temp->v->visited != true) {
                x = false;
                break;
            }
        }

    //Traverse adjacent vertices
    if(!vertex->adj.empty() && x == false) {
        vector<adjVertex>::iterator iter;
        for( iter = vertex->adj.begin(); iter != vertex->adj.end(); iter++) {
            if(iter->v->visited == false && iter->v->distance == 0) {
                iter->v->visited = true;
                queue.push(iter->v);
                queue.back()->distance = distance + 1;
            }
        }
    }
    }
    
    reverse(cities.begin(), cities.end());
    return (cities);
}
