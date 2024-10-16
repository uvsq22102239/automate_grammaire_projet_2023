// Fichier yacc/bison comprenant ce qui marche

%{

// Fichier d'en-tête pour les fonctions de manipulation de chaînes de caractères
#include <string.h>

// Fichier d'en-tête pour les fonctions d'entrée/sortie standard                                         
#include <stdio.h>

// Fichier d'en-tête pour les fonctions d'allocation de mémoire                                              
#include <stdlib.h>

// Fichier d'en-tête pour le support du type de données booléen                                             
#include <stdbool.h>                                            


#if YYBISON
int yylex();
int yyerror(char *s);
#endif

// Declarer et initialiser 'valid' afin de gérer les erreurs
bool valid = true;                                              

%}

%token LETTER E O PLUS DOT STAR PAR_OPEN PAR_CLOSE EOL

%union {
    char *word;
}

// définir token et les informations qui y sont liées
%token<word> WORD                                               

%%

// cette grammaire ne renvoie rien aux fichiers python, n'ayant pas réussi à tout reconnaître/ à mettre cela en place sans erreurs
// le fichier regexFctPas.y dérive de celui-ci et est un essai pour aller plus loin dans le projet, néanmoins cet essai ne s'est pas concrétisé

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
       }
       | E {
           printf("Saw an EPSILON token\n");
       }
       | O {
           printf("Saw an EMPTYSET token\n");
       }
       | PAR_OPEN expression PAR_CLOSE {
           printf("Saw a parentheses expression\n");
       }
       ;

test: 
    | test WORD EOL {
          printf("Saw a word to test: %s\n", $2);
      }
    // Essai pour reconnaître un mot d'une lettre avec notre configuration, échec à mettre en place sans erreurs  
    //| test LETTER EOL {
    //      printf("Saw a word to test: %c\n", *$2);
    //      free($2);                
    //  }
      ;

                                    

%%

int main()
{
    yyparse();
    if (valid) {
        printf("L'expression régulière est valide ou en tout cas ce qui est reconnu ne produit aucune erreur.\n");
    }
    return 0;
}

int yyerror(char *s)
{
    printf("Les mots d'une lettre ne sont pas supporté ou quelque chose d'autre produit une erreur.\n");
    valid = false;
    return 0;
}
