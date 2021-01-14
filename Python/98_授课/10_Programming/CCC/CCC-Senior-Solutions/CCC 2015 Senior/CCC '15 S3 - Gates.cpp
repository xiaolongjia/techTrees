using namespace std;

#include <iostream>
#include <map>

int main(){
	cin.sync_with_stdio(false);
    cin.tie(0);
	int num_gates;
	cin>>num_gates;
	
	int gates_taken[num_gates + 2] = {};
	
	int num_planes;
	cin>>num_planes;
	
	int best_num = 0;
	for (int plane=0;plane<num_planes;plane ++){
		//We are starting at 2, because 1 would redirect to 0
		int wanted_gate;
		cin>>wanted_gate;
		wanted_gate ++;
		
		bool works = false;
		
		while (wanted_gate>1){
			if (gates_taken[wanted_gate] == 0){ // not taken, take the spot and make it point to the one under it
				gates_taken[wanted_gate] = wanted_gate - 1;
				works = true;
				break;
			}else{ //spot was taken, use the suggested redirection
				int suggested_gate = gates_taken[wanted_gate];
				gates_taken[wanted_gate] = suggested_gate - 1; // we know next one will be either already taken or will become, so skip it next time
				wanted_gate = suggested_gate; 
				
			}
		}
		
		if (!works){ //didn't work or last plane to go
			cout<<plane<<endl;
			break;
		} else if (plane == num_planes-1){
			cout<<num_planes<<endl;
		}
	}
	
	return 0;
}
