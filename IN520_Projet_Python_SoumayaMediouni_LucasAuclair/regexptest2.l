/*Le fichier sert à tester les tokens et débugger, pour vérifier que le lexer marche comme prévu*/
/*Il remplace le regexp.l afin de tester pour les mots (à faire manuellement )*/

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

[a-z]               { yylval.word = strdup(yytext); printf("LETTER: %s\n", yytext); return LETTER; }

"E"                 { printf("E\n"); return E; }
"O"                 { printf("O\n"); return O; }

"+"                 { printf("PLUS\n"); return PLUS; }
"."                 { printf("DOT\n"); return DOT; }
"*"                 { printf("STAR\n"); return STAR; }

"("                 { printf("PAR_OPEN\n"); return PAR_OPEN; }
")"                 { printf("PAR_CLOSE\n"); return PAR_CLOSE; }

[a-z]+              { yylval.word = strdup(yytext); printf("WORD: %s\n", yytext); return WORD; }

\n|\r               { printf("EOL\n"); return EOL; }
.|\t               { printf("Ignored: %s\n", yytext); /* Ignorer les autres caractères */ }


%%

/*lecture et reconnaissance des différents tokens*/

int main () {
    while (yylex());
    return 0;
}
