using namespace std;

#include <iostream>
#include <list>
#include <map>
#include <vector>

int main(){
	int num_windows;
	cin>> num_windows;
	
	int tint_wanted;
	cin>> tint_wanted;
	
	std::list<int> xDimensions, yDimensions; 
	int windows[num_windows][5];
	
	//recording the window dimensions
	for (int window = 0; window<num_windows;window++){
		int x1,y1,x2,y2,t;
		cin>>x1>>y1>>x2>>y2>>t;
		windows[window][0] = x1;
		windows[window][1] = y1;
		windows[window][2] = x2;
		windows[window][3] = y2;
		windows[window][4] = t;
		
		xDimensions.push_back(x1);
		xDimensions.push_back(x2);
		yDimensions.push_back(y1);
		yDimensions.push_back(y2);
	} 
	
	//compress the cordinates to simulate a smaller grid
	xDimensions.sort();
	xDimensions.unique();
	yDimensions.sort();
	yDimensions.unique();
	
	//Saving search speed at the cost of memory
	std::map<int, int> xReferences, yReferences, RevX, RevY;
	int counter = 0;
	for(int x : xDimensions){
		xReferences[x] = counter;
		RevX[counter] = x;
		counter++;
	}
	
	counter = 0;
	for(int y : yDimensions){
		yReferences[y] = counter;
		RevY[counter] = y;
		counter++;
	}
	
	//simulating grid with 2D DA
	int grid[xDimensions.size()][yDimensions.size()] = {};
	for (auto& test: windows){ // [x1, y1, x2, y2, t]
		int x1 = xReferences[test[0]], y1 = yReferences[test[1]], x2 = xReferences[test[2]], y2 = yReferences[test[3]], t = test[4];
		grid[x1][y1] += t;
		grid[x2][y2] += t;
		grid[x1][y2] -= t;
		grid[x2][y1] -= t;
	}
	
	
	//turning the grid into the correct format
	for (int x = 0; x<xDimensions.size(); x++){
		for (int y = 0; y<yDimensions.size(); y++){
			if (x>0){
				grid[x][y] += grid[x-1][y];
			}
		}
	}
	for (int x = 0; x<xDimensions.size(); x++){
		for (int y = 0; y<yDimensions.size(); y++){
			if (y>0){
				grid[x][y] += grid[x][y-1];
				
			}
		}
	}
	
	//Counting up the grids with that much
	int total = 0;
	for (int y=0; y<yDimensions.size(); y++){
		for (int x=0; x<xDimensions.size(); x++){
			if (grid[x][y] >= tint_wanted){
				int x_length = RevX[x+1] - RevX[x];
				int y_length = RevY[y+1] - RevY[y];
				total += x_length*y_length;
				if (x_length*y_length <0){
					cout<<"A spot has negative area?"<<endl;
				}
			}
		}
	}
	cout<<total<<endl;
	
	return 0;
}
