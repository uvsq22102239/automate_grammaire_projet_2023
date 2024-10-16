######
#variables, constantes et chemins

LDFLAGS="-L/usr/local/opt/flex/lib"

#pour tester les tokens avec lex, on pourrait aussi juste mettre $@ mais c'est bien pour débugger d'avoir 1 fichier précis
EXECUTABLE = my_test 
######

## L'organisation des fichiers est la suivant
# 
# regexp.l -- flex --> regexp.yy.c
# regexp.y -- bison --> regexp.tab.c
# 
# regexp.yy.c + regexp.tab.c -- gcc --> regexp
# 
# test.1 -- regexp --> main.py
# 
# 
# Finalement c'est l'exécution de pyhton3 main.py qui fait ce qui est demandé
# 

run: main.py
	python3 main.py

new_test: regexp test.1
	./regexp < test.1

###### pour tester les tokens avec lex et vérifier que le lexer fonctionne comme voulu
test: lex.yy.c
	gcc -o $(EXECUTABLE) lex.yy.c -lfl
	./$(EXECUTABLE) < test.1

lex.yy.c: regexptest.l
	#Le fichier sert à tester les tokens et débugger, pour vérifier que le lexer marche comme prévu
	flex regexptest.l
######

main.py: regexp test.1
	./regexp < test.1

# Commenter deux des trois lignes en fonction de l'ordi
# La deuxième et la troisième est normalement pour les MAC
# La première pour les autres systèmes
# il faut éventuelleme,nt remplacer -ll par -lfl
regexp: regexp.yy.c regexp.tab.c
	gcc -o $@ $^ -ly -ll
#	gcc -o $@ $^ ${LDFLAGS} -ly -lfl
#	gcc -mmacosx-version-min=13.1 -o $@ $^ ${LDFLAGS} -ly -lfl

regexp.tab.c: regexp.y
	bison -d --report=all $^
#	bison -d -v -g $^
# -d pour générer le fichier exo01.tab.h
# -v pour générer le fichier exo01.output
# -g pour générer le fichier exo01.vcg

regexp.yy.c: regexp.l
	flex -o $@ $^



# plus besoin
#install:
	#sudo apt-get install -y libbison-dev


clean:
	# Ce qui est généré par bison
	rm -f regexp.yy.c	rm -f regexp.output regexp.tab.c regexp.tab.h
	# Ce qui est généré par flex
	rm -f regexp.yy.c
	# L'exécutanle regexp
	rm -f regexp
	# Le programme main.py
	#rm -f main.py
	rm -f *.zip
	# ce qui est généré pour tester les tokens avec lex
	rm -f lex.yy.c my_test
	# ce que python compile, __pycache__
	rm -R __pycache__
	# pour lister tous les d'elt ainsi que la taille totale
	ls -als

### cibles modifiiées pour zipper tout ce qu'on a fait
LADIR="IN520_Projet_Python_SoumayaMediouni_LucasAuclair"
zip_etud:
	rm -rf ${LADIR}
	mkdir ${LADIR}
# On ne recopie pas la solution
#	cp regexp.l regexp.y ${LADIR}
	cp Makefile automate.py main.py test.1 regexp.y regexp.l regexptest.l regexptest2.l regexpFctPas.y ${LADIR}
	rm -f ${LADIR}.zip
	zip -r ${LADIR}.zip ${LADIR}
	rm -rf ${LADIR}


#LADIRcorr="IN520_Projet_Python_correction"
#zip_corr:
#	rm -rf ${LADIRcorr}
#	mkdir ${LADIRcorr}
#	On recopie la solution
#	cp regexp.l regexp.y ${LADIRcorr}
#	cp Makefile automate.py main.1.py test.1 ${LADIRcorr}
#	rm -f ${LADIRcorr}.zip
#	zip -r ${LADIRcorr}.zip ${LADIRcorr}
#	rm -rf ${LADIRcorr}


