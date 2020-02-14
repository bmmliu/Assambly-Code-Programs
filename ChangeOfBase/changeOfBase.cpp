#include <iostream>
#include <math.h>
#include <deque>

/*
 * Please enter the number's base: 10
 Please enter the number: 25
 Please enter the new base: 2
 25 base 10 is 11001 base 2
 */
int main() {
    int base_before;
    int base_after;
    int arr_before[100];
    std::deque<int> arr_after;
    int tenbase_num = 0;
    int remain;
    std::string input_num;
    std::string output_num;
    std::cout << "Please enter the number's base: ";
    std::cin >> base_before;
    std::cout << "Please enter the number: ";
    std::cin >>input_num;
    std::cout << "Please enter the new base: ";
    std::cin >> base_after;

    for(unsigned int i = 0; i < input_num.size(); i++){
        if(input_num[i] > 64){
            arr_before[i] = input_num[i] - 55;
        } else{
            arr_before[i] = input_num[i] - 48;
        }
    }
    
    for(unsigned int i = 0; i < input_num.size(); i++){
        tenbase_num = tenbase_num + arr_before[i] * pow(base_before, input_num.size() - 1 - i);
    }
    
    int index = 0;
    while(tenbase_num >= base_after){
        remain = tenbase_num % base_after;
        tenbase_num = tenbase_num/base_after;
        arr_after.push_front(remain);
        index = index + 1;
    }
    
    if (tenbase_num != 0){
        arr_after.push_front(tenbase_num);
    }
    
    std::cout << input_num <<" base "<< base_before<< " is ";
    for(unsigned int i = 0; i < arr_after.size();i++){
        if(arr_after[i] >= 10){
            std::cout << (char) (arr_after[i]+55);
        } else{
            std::cout << arr_after[i];
        }
    }
    
    std::cout << " base " << base_after << std::endl;
    return 0;
}
