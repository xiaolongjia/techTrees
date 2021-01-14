using namespace std;

#include <iostream>
#include <map>


int main(){
	int num_shirts; 
	int num_plrs;
	cin>>num_shirts;
	cin>>num_plrs;
	
	int shirts[num_shirts];
	std::map<char,int> size_translation;
  size_translation['S'] = 1, size_translation['M']=2, size_translation['L']=3; 
	
	for (int shirt=0; shirt<num_shirts; shirt ++ ){
		char wanted_size;
		cin>>wanted_size;
		shirts[shirt] = size_translation[wanted_size];
	}
	
	int max_shirts = 0;
	std::map<int,int> slots_taken;
	
	for (int plr=0; plr<num_plrs;plr++){
		char wanted_size;
		int wanted_num;
		cin>>wanted_size;
		cin>>wanted_num;
		wanted_num--;
	    if ( slots_taken.count(wanted_num) == 0 && shirts[wanted_num] >= size_translation[wanted_size]){
	    	slots_taken[wanted_num] = 1;
	    	max_shirts++;
		} 
	}
	
	cout<<max_shirts<<endl;
	return 0;
}

