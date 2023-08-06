%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>


extern int yylex();
extern int yyparse();
void yyerror(const char* s);
extern int yylineno;
typedef struct {
   char* name;
   int capacity;
} Var;

Var identifiers[100];
int numVars = 0;

void addNewVariable(int capacity, char* identifier);
void isIdentifierExists(char* identifier);
void IntToVar(int val, char* identifier);
void VarToVar(char* id1, char* id2);
int checkIdentifierIndex(char* varName);
%}

%union {int number; int capacity; char* name;}
%start program
%token <name> IDENTIFIER
%token <capacity> CAPACITY
%token <number> INTEGER
%token START
%token MAIN
%token END
%token MOVE
%token TO
%token ADD
%token INPUT
%token PRINT
%token SEMICOLON
%token STRING_LITERAL
%token LINE_TERMINATOR


%%
program		: start main end					        { printf("\nThis program is well-formed.\n"); exit(0); } 
		;
                    
start	: START LINE_TERMINATOR declarations			{ }
		;
                    
declarations	: declarations declaration				{ }
		| 							                    { } 
		;
                    
declaration	: CAPACITY IDENTIFIER LINE_TERMINATOR		{ addNewVariable($1, $2); }
		; 
                    
main		: MAIN LINE_TERMINATOR operations			{ }
		;
              	      
operations	: operations operation					    { }
		|							                    { }
		
                    
operation	: move | add | input | print				{ }
		;
                   
move		: MOVE IDENTIFIER TO IDENTIFIER LINE_TERMINATOR	{ VarToVar($2, $4); } 
		| MOVE INTEGER TO IDENTIFIER LINE_TERMINATOR		{ IntToVar($2, $4); }
		;
                    
add		: ADD IDENTIFIER TO IDENTIFIER LINE_TERMINATOR		{ VarToVar($2, $4); }
		| ADD INTEGER TO IDENTIFIER LINE_TERMINATOR		    { IntToVar($2, $4); }
		;
		
input		: INPUT input_statement					        { }
		;
                    
input_statement : IDENTIFIER SEMICOLON input_statement		{ isIdentifierExists($1); }
		| IDENTIFIER LINE_TERMINATOR				        { isIdentifierExists($1); }
		;
                    
print		: PRINT print_statement					        { }
		;
                    
print_statement : STRING_LITERAL SEMICOLON print_statement  { }
		| IDENTIFIER SEMICOLON print_statement			    { isIdentifierExists($1); }
		| STRING_LITERAL LINE_TERMINATOR			        { }
		| IDENTIFIER LINE_TERMINATOR				        { isIdentifierExists($1); }
		;
                                 
end		: END LINE_TERMINATOR					            { } 
		;

%%

int main(){
    while(1){
	printf("-------The Parser-------\n");
	printf("Please enter the program text:\n");
	printf(">>> \n");
	yyparse();
    }	
}

void addNewVariable(int capacity, char*  identifier){

    if(checkIdentifierIndex(identifier) != -1){
    	printf("\nThis Program is invalid.\n");
        fprintf(stderr, "Error on line %d: Variable %s already exists\n", yylineno, identifier);
        exit(0);
    }

    numVars++;

    Var var;
    char* temp = (char *) calloc(strlen(identifier)+1, sizeof(char));
    strcpy(temp, identifier);
    var.name = temp;
    var.capacity = capacity;
    identifiers[numVars - 1] = var; 
}

void isIdentifierExists(char* identifier){

    if(checkIdentifierIndex(identifier) == -1){
    	printf("\nThis Program is invalid.\n");
        fprintf(stderr, "Error on line %d: Variable %s does not exist\n", yylineno, identifier);
        exit(0);
    } 
}

void IntToVar(int val, char* identifier){
    int identifierIndex = checkIdentifierIndex(identifier);
    if(identifierIndex == -1){
    	printf("\nThis Program is invalid.\n");
        fprintf(stderr, "Error on line %d: variable %s does not exist\n", yylineno, identifier);
        exit(0);
    }
    else{
        int MaxCapacity = identifiers[identifierIndex].capacity;
        int temp = val;
        int numDigits = 0;
        while(temp != 0){
            temp /= 10;
            numDigits++;
        }
        if(numDigits > MaxCapacity){
        	printf("\nThis Program is invalid.\n");
            fprintf(stderr, "Warning on line %d: value %d is larger than variable %s of capacity %d\n", yylineno, val, identifier, MaxCapacity);
            exit(0);
        }
    }
}
void VarToVar(char* id1, char* id2){
    int varOneIndex = checkIdentifierIndex(id1);
    int varTwoIndex = checkIdentifierIndex(id2);
    
    if(varOneIndex == -1 && varTwoIndex != -1){
    	printf("\nThis Program is invalid.\n");
        fprintf(stderr, "Error on line %d: Variable %s does not exist\n", yylineno, id1);
        exit(0);
    }
    else if(varOneIndex != -1 && varTwoIndex == -1){
    	printf("\nThis Program is invalid.\n");
        fprintf(stderr, "Error on line %d: Variable %s does not exist\n", yylineno, id2);
        exit(0);
    }
    else if(varOneIndex == -1 && varTwoIndex == -1){
    	printf("\nThis Program is invalid.\n");
        fprintf(stderr, "Error on line %d: Variable %s and Variable %s do not exist\n", yylineno, id1, id2);
        exit(0);
    }
    else{
        int varOneSize = identifiers[varOneIndex].capacity;
        int varTwoSize = identifiers[varTwoIndex].capacity;
        
        if(varOneSize > varTwoSize){
        	printf("\nThis Program is invalid.\n");
            fprintf(stderr, "Warning on line %d: variable %s of capacity %d is larger than variable %s of capacity %d\n", yylineno, id1, varOneSize, id2, varTwoSize);
            exit(0);
        }
    }
}


void yyerror(const char *s) {
	printf("\nThis program is invalid.\n");
    fprintf(stderr, "Error one line %d: %s\n", yylineno, s);
}

int checkIdentifierIndex(char * varName){
    
    int i;
    for(i = 0; i < numVars; i++){
        if(identifiers[i].name != NULL){
            if(strcmp(identifiers[i].name, varName) == 0){
                return i;
            }
        }
    }    
    
    return -1;
}
