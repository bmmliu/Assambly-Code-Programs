#include <iostream>
#include <math.h>
#include <deque>
#include <string>
#include <vector>
#include <stdio.h>

/*
 * Please enter the number's base: 10
 Please enter the number: 25
 Please enter the new base: 2
 25 base 10 is 11001 base 2
 */

int main(int argc, char *argv[]) {
    int input_num[50];
    for(int i1 = 1; i1 < argc; i1++){
        input_num[i1-1] = atoi(argv[i1]) ;
    }
    
    std::string output;
    
    for (int j = 0; j < argc - 1 ; ++j) {
        int sign = 0;
        int index = 0;
        if( input_num[j] & (1 << 26 )){
            sign = 1;
        } else{
            sign = 0;
        }
        for (int i = 0; i < 26; ++i) {
            if( input_num[j] & (1 << i)){
                if(sign == 0){
                    index = i + 97;
                } else{
                    index = i + 65;
                }
            }
        }
        output.push_back((char) index);
        
    }
    
    std::cout << "You entered the word: " << output;
    std::cout << '\n';
    
    
    
    return 0;
}
