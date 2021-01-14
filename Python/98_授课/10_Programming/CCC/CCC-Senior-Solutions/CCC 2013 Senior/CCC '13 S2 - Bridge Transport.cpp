using namespace std;

# include <iostream>

int main(){
	int max_mass, num_cars, num_possible;
	cin>>max_mass>>num_cars;
	
	int last_four[4] = {};
	for (int car =0; car<num_cars; car++){
		int mass;
		cin>>mass;
		last_four[car%4] = mass;
		if (last_four[0] + last_four[1] + last_four[2] + last_four[3] > max_mass){
			break;
		}
		num_possible ++;
	}
	
	cout<<num_possible<<endl;
	return 0;
}
