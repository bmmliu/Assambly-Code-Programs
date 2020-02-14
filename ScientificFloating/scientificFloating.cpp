#include <iostream>
#include <math.h>
#include <deque>
#include <stdio.h>


int main() {
    float float_num;
    int above_one;
    int remain;
    int float_remain;
    char sign = 'p';
    std::deque<int> head;
    std::deque<int> tail;
    std::cout << "Please enter a float: ";
    std::cin >> float_num;
    if (float_num == 0){
        std::cout << "0E0";
        return 0;
    }
    if (float_num < 0){
        sign = 'n';
        float_num = 0 - float_num;
    }
    above_one = (int) float_num;
    float_num = float_num - above_one;
    while(above_one > 0){
        remain = above_one % 2;
        above_one = above_one/2;
        head.push_front(remain);
    }
    unsigned int num_of_e = head.size() - 1;
    
    
    
    while(float_num > 0){
        float_num = float_num * 2;
        float_remain = (int) float_num;
        tail.push_back(float_remain);
        float_num = float_num - float_remain;
    }
    
    if(sign == 'n'){
        std::cout << '-';
    }
    std::cout << head[0] << '.';
    
    for(unsigned int i = 1; i < head.size();i++){
        std::cout << head[i];
    }
    
    for(unsigned int i = 0; i < tail.size();i++){
        std::cout << tail[i];
    }
    
    std::cout << 'E' << num_of_e;
    
    
    return 0;
}
