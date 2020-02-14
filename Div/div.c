#include <stdio.h>
#include<stdlib.h>

int main(int argc, char *argv[]) {
    
    unsigned long int dividend = atol(argv[1]);
    unsigned long int copy = dividend;
    unsigned long int divisor = atol(argv[2]);
    unsigned int quotient = 0;
    unsigned int i = 1;
    
    while (divisor <= dividend) {
        divisor <<= 1;
        i <<= 1;
    }
    
    while (i > 1) {
        
        divisor >>= 1;
        i >>= 1;
        
        if (divisor <= dividend) {
            quotient = quotient + i;
            dividend = dividend - divisor;
        }
    }
    
    
    printf("%ld / %ld = %d R %ld",copy, divisor, quotient, dividend);
    
    return 0;
}
