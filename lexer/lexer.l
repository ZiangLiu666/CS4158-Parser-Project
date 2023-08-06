%{

#include <string.h>
#include <stdlib.h>

void printCAPACITY(char* str, char* yytext);

%}

%option noyywrap
%option caseless

%%
[\t ]+ 			/* Ignore whitespace */ ;
[\n]+ 			/* Ignore whitespace */ ;			
START	    |	        
MAIN     	|          
END      	|          
MOVE     	|         
ADD      	|  
TO	 	    |       
INPUT    	|      
PRINT			{ printf("Current %s is a valid KEYWORD\n", yytext); }      
[Ss]+			{ printCAPACITY("Current INPUT is", yytext); }
(-)?[0-9]+		{ printf("Current %s is an INTEGER\n", yytext); }
[_\A-Za-z][\-A-Za-z0-9]*	{ printf("Current %s is an IDENTIFIER\n", yytext);}
\"(\\.|[^"\\])*\"	{ printf("Current %s is a STRING\n", yytext); }
;			{ printf("Current %s is a SEMICOLON\n", yytext); }
\.			{ printf("Current %s is a LINE_TERMINATOR\n", yytext); }
.			{ printf("Current %s is an Invalid Syntax\n", yytext); }
%%

int main(){
    yylex();
}

void printCAPACITY(char* str, char* yytext){
	long int MaxNum = 9;
	int length = strlen(yytext);
	for(int i = 1; i < length; i++)      
	{
		MaxNum = (MaxNum * 10) + 9;
	}
    	printf("%s: %s. The range of integers that can be declared is 0 - %ld\n", str, yytext, MaxNum);
}