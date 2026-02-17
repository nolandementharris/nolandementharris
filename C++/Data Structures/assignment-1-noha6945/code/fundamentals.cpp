#include "fundamentals.hpp"

void insertStockInfo(stockInfo stocks[], string company_name, double stock_prices_arr[], int index) {
    
    stocks[index].company_name = company_name;
    int x = 0;

    while (x<5) 
    {
    stocks[index].stock_prices_arr[x] = stock_prices_arr[x];
    x++;
    }
    
    double average = 0;    
    double temp = 0;
    double sum = 0;
    int i = 0;

    for (i = 0; i < 5; i++)
    {
        temp = stocks[index].stock_prices_arr[i];
        sum = sum + temp;
    }
    
    average = sum/5;
    stocks[index].average = average;

    return;
}

void displaySortedStocks(stockInfo stock, ofstream& file){

    int j = 0;
    int i = 0;
    double temp = 0;

    for (i = 0; i<5;i++)
    {
        for (j = i+1; j<5; j++)
        {

            if (stock.stock_prices_arr[j] < stock.stock_prices_arr[i])
            {
                temp = stock.stock_prices_arr[i];
                stock.stock_prices_arr[i] = stock.stock_prices_arr[j];
                stock.stock_prices_arr[j] = temp;
            }
        }
    }

    file << stock.company_name << "," << stock.average << "," << stock.stock_prices_arr[0] << "," <<  stock.stock_prices_arr[1] << "," <<  stock.stock_prices_arr[2] << "," <<  stock.stock_prices_arr[3] << "," <<  stock.stock_prices_arr[4] << endl;
    cout << stock.company_name << "," << stock.average << "," << stock.stock_prices_arr[0] << "," <<  stock.stock_prices_arr[1] << "," <<  stock.stock_prices_arr[2] << "," <<  stock.stock_prices_arr[3] << "," <<  stock.stock_prices_arr[4] << endl;
    return;
}
