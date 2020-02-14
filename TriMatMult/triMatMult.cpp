#include <iostream>
#include <math.h>
#include <deque>
#include <stdio.h>
#include <fstream>
#include <vector>


int main(int argc, char *argv[]) {
    int mat_size;
    std::ifstream mat1, mat2;
    mat1.open(argv[1]);
    mat2.open(argv[2]);
    mat1 >> mat_size;
    mat2 >> mat_size;
    std::deque<int> m1;
    std::deque<int> m2;
    int** m1double;
    int** m2double;
    int** m3;
    
    
    while(!mat1.eof()){
        int temp;
        mat1 >> temp;
        m1.push_back(temp);
    }
    
    while(!mat2.eof()){
        int temp;
        mat2 >> temp;
        m2.push_back(temp);
    }
    
    m3 = (int**)malloc(mat_size * sizeof(int*));
    for(int i = 0; i < mat_size; i++) {
        m3[i] = (int *) calloc((mat_size - i), sizeof(int));
    }
    
    m1double = (int**)malloc(mat_size * sizeof(int*));
    for(int i = 0; i < mat_size; i++){
        m1double[i] =(int*) malloc((mat_size - i) * sizeof(int));
        for(int j = 0; j < (mat_size - i);j++){
            m1double[i][j] = m1.front();
            m1.pop_front();
        }
    }
    
    m2double = (int**)malloc(mat_size * sizeof(int*));
    for(int i = 0; i < mat_size; i++){
        m2double[i] =(int*) malloc((mat_size - i) * sizeof(int));
        for(int j = 0; j < (mat_size - i);j++){
            m2double[i][j] = m2.front();
            m2.pop_front();
        }
    }
    
    
    for (int i = 0; i < mat_size; i++){
        for (int j = 0; j < mat_size - i; j++){
            for (int k = 0; k < j + 1; k++){
                m3[i][j] += m1double[i][k] * m2double[k + i][j - k];
            }
        }
    }
    
    for(int i = 0; i < mat_size; i++){
        for(int j = 0; j < mat_size - i; j++){
            std::cout << m3[i][j]<< " ";
        }
    }
    
    free(m1double);
    free(m2double);
    free(m3);
    
    return 0;
}

