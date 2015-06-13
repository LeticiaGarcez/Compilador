all: 	
		clear
		lex lexica.l
		yacc -d sintatica.y
		g++ -o exe y.tab.c -lfl

		./exe < exemplo.lule
