using namespace std;
#include <iostream>
#include <vector>

int main(){
	int tests;
	cin>>tests;
	
	for (int t=0; t<tests; t++){
		int num_cars;
		cin>>num_cars;
		
		int car_numbers[num_cars];
		
		for (int car = 0; car<num_cars; car++){
			int car_number;
			cin>>car_number;
			car_numbers[car] = car_number;
		}
		
		std::vector<int> branch_queue;  
		int current_wanted = 1;
		
		
		for (int i = num_cars-1; i>=0; i--){
			int car_number = car_numbers[i];
			
			//Move it
			if (car_number == current_wanted){
				current_wanted ++; // moved to river
			}else{
				branch_queue.push_back(car_number); // moved to branch
			}
			
			//Move any items wanted from the branch
			while (true){
				if (!branch_queue.empty() && current_wanted == branch_queue.back()){
					branch_queue.pop_back();
					current_wanted ++;
				}else{
					break;
				}
			}
		}
		
		if (current_wanted > num_cars){
			cout << "Y" << endl;
		} else{
			cout << "N" << endl;
		}
		
		
	}
	
	return 0;
}
