%{

#include "regexp.tab.h"

/*définition des différents tokens, sert à rien comme bison va lui-même les définir*/

                    /*define LETTER     300*/
                    /*define DOT        311*/
                    /*define PLUS       312*/
                    /*define STAR       321*/

                    /*define PAR_OPEN   701*/
                    /*define PAR_CLOSE  702*/


                    /*define EMPTYSET   722*/
                    /*define EPSILON    723*/
                    /*define EOL        800*/ 

%}

%%

[a-z]               { yylval.word = strdup(yytext); return LETTER; }

"E"                 { return E; }
"O"                 { return O; }

"+"                 { return PLUS; }
"."                 { return DOT; }
"*"                 { return STAR; }

"("                 { return PAR_OPEN; }
")"                 { return PAR_CLOSE; }

[a-z]+              { yylval.word = strdup(yytext); return WORD; } /* Ajout pour reconnaître n'importe quel mot de plusieurs caractères */
                  
\n|\r               { return EOL; }
.|\t                { /* ignorer les autres caractères */ }

%%

int yywrap(void) {
    return 1;
}