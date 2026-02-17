#include <iostream>
#include <fstream>
#include "../code/fundamentals.hpp"
#include <sstream>
#include <string>

using namespace std;

int main(int argc, char* argv[]) {

    ifstream infile;
    infile.open(argv[1]);

    ofstream out_file;
    out_file.open(argv[2]);


    int index = 0;
    int x = 0;
    int i = 0;
    double stock_prices_arr[5];
    string line, company_name;
    string temp;
    stockInfo stocks[5];
    stockInfo stock;

    if (infile.is_open()) 
    {
        while (getline(infile, line))
        {

            stringstream ss(line);
            
            for (i=0; i<6; i++)
            {
                getline(ss,temp,',');

                if (i==0)
                {
                    company_name = temp;
                }

                else
                {                
                    stringstream (temp) >> stock_prices_arr[i-1];
                }
            }

            insertStockInfo( stocks,  company_name,  stock_prices_arr,  index);
            displaySortedStocks( stocks[index], out_file);

            index++;
        }
    }
    else
    {
        cout << 'file does not open' << endl;

        return 1;
    }
    
    infile.close();
    out_file.close();


    return 0;
}