// le fichier regexFctPas.y dérive de regexp.y et est un essai pour aller plus loin dans le projet, néanmoins cet essai ne s'est pas concrétisé
// les commentaires n'ont pas été traduits comme il s'agit plus d'une démonstration de jusqu'où nous sommes allés qu'autre chose

%{
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#if YYBISON
int yylex();
int yyerror(char *s);
#endif

bool valid = true;  // Declare and initialize 'valid'

%}

%token LETTER E O PLUS DOT STAR PAR_OPEN PAR_CLOSE EOL

%union {
    char *word;
}

%token<word> WORD
%type<word> primary primary_result

%%

input: expression EOL test

expression: term
          | expression PLUS term {
              printf("Saw a PLUS token\n");
          }
          ;

term: factor
    | term DOT factor {
          printf("Saw a DOT token\n");
      }
    ;

factor: primary
      | factor STAR {
          printf("Saw a STAR token\n");
      }
      ;

primary: LETTER {
           printf("Saw a LETTER token\n");
           $$ = strdup(yytext); // Use $$ to represent the value of LETTER
       }
       | E {
           printf("Saw an EPSILON token\n");
           $$ = strdup("E"); // Use $$ to represent the value of E
       }
       | O {
           printf("Saw an EMPTYSET token\n");
           $$ = strdup("O"); // Use $$ to represent the value of O
       }
       | PAR_OPEN expression PAR_CLOSE {
           printf("Saw a parentheses expression\n");
           $$ = $2; // Use $$ to represent the value of the expression in parentheses
       }
       ;

test: /* empty */
    | test WORD EOL {
          printf("Saw a word to test: %s\n", $2);
      }
      ;

primary_result: primary {
    $$ = $1; // Return the value of primary
}
      | /* empty */ {
    $$ = NULL; // Return NULL when primary_result is empty
}
      ;

%%

int main()
{
    yyparse();
    if (valid) {
        printf("L'expression régulière est valide.\n");
    }
    return 0;
}

int yyerror(char *s)
{
    printf("Les mots d une lettre ne sont pas supportés.\n");
    valid = false;
    return 0;
}
