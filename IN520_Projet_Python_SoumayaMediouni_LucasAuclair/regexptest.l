/*Le fichier sert à tester les tokens et débugger, pour vérifier que le lexer marche comme prévu*/

%{


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

[a-z]               { printf("LETTER\n"); }

"E"                 { printf("EPSILON\n"); }
"O"                 { printf("EMPTYSET\n"); }

"+"                 { printf("+\n"); }
"."                 { printf(".\n"); }
"*"                 { printf("*\n"); }

"("                 { printf("PAR_OPEN\n"); }
")"                 { printf("PAR_CLOSE\n"); }

\n                  { printf("EOL\n"); }

.|\t                { /* ignorer les autres caractères */ }

%%

/*lecture et reconnaissance des différents tokens*/

int main () {
    while (yylex());
    return 0;
}
