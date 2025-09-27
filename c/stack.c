#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdbool.h>

#include "stack.h"

//INIT

Vulnerability initializeVulnerability(int line, char* function, char* VulnerabilityType, char* solutions){
    Vulnerability newInfo;
    newInfo.line = line;
    newInfo.function = strdup(function);
    newInfo.VulnerabilityType = strdup(VulnerabilityType);
    newInfo.solutions = strdup(solutions);
    return newInfo;
}


Stack* createStack(){
    Stack* newStack = (Stack*)malloc(sizeof(Stack));
    if(!newStack){
        perror("Error creating Stack");
        exit(EXIT_FAILURE);
    }

    newStack -> data =(Vulnerability*)malloc(sizeof(Vulnerability));
    if(!newStack -> data){
        perror("Error Allocating Memory for stack data");
        exit(EXIT_FAILURE);
    }
    newStack -> top = -1;

    return newStack;
}

//PUSH AND POP

//EMPTY
bool isEmpty(Stack *stack){
    return ( stack == NULL || stack -> top == -1 );
}

//DISPLAY
void displayStack(Stack* stack){
    printf("Oui");
}


//CLEAR
void clearStack(Stack* stack){
    if(stack == NULL ){
        printf("We don't have stack ( Value = NULL )");
        return;
    }else{
        for(int i = stack -> top; i >= 0 ; i--){
            free(stack ->data[i].function);
            free(stack ->data[i].VulnerabilityType);
            free(stack ->data[i].solutions);
        }
        free(stack -> data);
        free(stack);
    }
}


int main(){
    return 0;
}