%{
#include "stdio.h"
#include "stdlib.h"

%}
/* -------------definition starting-------------*/
/* ------- identifier ------- */
ID [a-zA-Z_][a-zA-Z_0-9]*

/* ------- keyword ------- */
TYPE int|float
STRUCT struct
RETURN return
IF if
ELSE else 
WHILE while
BREAK break

/* ------- separator ------- */
SEMI_COLON [;]
COMMA [,]
LP \(
RP \)
LB \[
RB \]
LC \{
RC \}

/* ------- operator ------- */
ASSIGNOP [=]
RELOP [>]|[<]|[>][=]|[<][=]|[=][=]|[!][=](^[=])
PLUS [+]
MINUS [-]
STAR [*]
DIV [/]
AND [&][&]
OR [|][|]
DOT [.]
NOT [!]

/* ------- literal ------- */
INT_DEX [1-9][0-9]*|[0]
INT_HEX [0][Xx]([1-9][0-9]*|[0])
INT_OCT [0][0-7]
FLOAT [0-9]*[.][0-9]+([eE][+-]?[0-9]*|[0])?f?
TRUE true

/* ------- drop this part ------- */
SPACE [ \n\t]

/* -------------definition ending-------------*/

%%

{TYPE} |
{STRUCT} |
{RETURN} |
{IF} |
{ELSE} |
{WHILE} |
{BREAK} {
  /* ------- keyword ------- */
    printf("<keyword, %s>\n", yytext);
}



{SEMI_COLON} |
{COMMA} |
{LP} |
{RP} |
{LB} |
{RB} |
{LC} |
{RC} {
  /* ------- separator ------- */
    printf("<separator, %s>\n", yytext);
}


{ASSIGNOP} |
{RELOP} |
{PLUS} | 
{MINUS} |
{STAR} |
{DIV} |
{AND} |
{OR} |
{DOT} |
{NOT} {
  /* ------- operator ------- */
    printf("<operator, %s>\n", yytext);
}


{INT_DEX} |
{INT_HEX} |
{INT_OCT} |
{FLOAT} |
{TRUE} {
  /* ------- literal -------*/
    printf("<literal, %s>\n", yytext);
}


{ID} {
  /* ------- identifier ------- */
    printf("<identifier, %s>\n", yytext);
}



{SPACE} {
    /* ------- drop this part ------- */
}


%%
int yywrap() {
  return 1;
}

int main(int argc, char** argv) {
   if (argc > 1) {
       if (!(yyin = fopen(argv[1], "r"))) {   
           perror(argv[1]);
           return 1;
       }
   }

   while (yylex());
   return 0;
 }