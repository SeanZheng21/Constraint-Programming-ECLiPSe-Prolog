/**http://eclipseclp.org/doc/tutorial/tutorial025.html*/

:-lib(ic).
:-lib(ic_symbolic).

:-local domain(machine(m1,m2)).


/**Q3.1*/
taches(Taches):-
	Taches = [](tache(3, [],m1, _),
	tache(8, [],m1, _),
	tache(8, [4,5],  m1, _),
	tache(6, [],m2, _),
	tache(3, [1],m2, _),
	tache(4, [1,7],  m1, _),
	tache(8, [3,5],  m1, _),
	tache(6, [4],m2, _),
	tache(6, [6,7],  m2, _),
	tache(6, [9,12], m2, _),
	tache(3, [1],m2, _),
	tache(6, [7,8],  m2, _)).
/*
taches(Taches).
*/

/**Q3.2*/	
ecrit_taches(Taches):-
	dim(Taches,Dim),
	D is Dim[1],
	(for(I,1,D),
	param(Taches)
	do
		Var is Taches[I],
		writeln(Var)
	).
/*
taches(Taches),ecrit_taches(Taches).
*/

/**Q3.3*/
domaines(Taches,Fin):-
	dim(Taches,Dim),
	D is Dim[1],
	(for(I,1,D),
	param(Taches,Fin)
	do
		tache(S, _ ,M, D) is Taches[I],
		M&::machine,
		D#>=0,
		Fin#>=S+D
	).
/**
taches(Taches),domaines(Taches,5).
*/

/**Q3.4*/
getVarList(Taches,Fin,[Fin|Liste]):-
    dim(Taches,Dim),
	D is Dim[1],
	(for(I,1,D),
	param(Taches),
	fromto([],In,Out,Liste)
	do
		tache(_, _, _, Debut) is Taches[I],
		Out = [Debut|In]
	).
/**
taches(Taches),domaines(Taches,5),getVarList(Taches,5,List).
*/

/**Q3.5*/
solve(Taches,Fin):-
	taches(Taches),
	domaines(Taches,Fin),
	precedences(Taches),
	conflicts(Taches),
	getVarList(Taches,Fin,Liste),
	labeling(Liste),
	ecrit_taches(Taches).

/**
solve(Taches,Fin).
*/

/*Q3.6*/
precedences(Taches):-
	dim(Taches,Dim),
	D is Dim[1],
	(for(I,1,D),
	param(Taches)
	do
		tache(_, Noms,_, Debut) is Taches[I],
		(foreach(Nom,Noms),
		param(Taches,Debut)
		do
			tache(DureePrec, _, _, DebutPrec) is Taches[Nom],
			Debut#>= DureePrec+DebutPrec
		)
	).
/**
taches(Taches),solve(Taches,Fin).
*/

/**Q3.7*/
conflicts(Taches):-
	dim(Taches,Dim),
	D is Dim[1],
	(for(I,1,D-1),
	param(Taches,D)
	do
		tache(Duree, _, Machine, Debut) is Taches[I],
		I2 is I+1,
		(for(J,I2,D),
		param(Taches,Debut,Duree,Machine)
		do
			tache(Duree2, _, Machine2, Debut2) is Taches[J],
			((Debut2 #>= Debut) and (Debut2 #< (Debut + Duree))) => (Machine &\=Machine2),
			((Debut #>= Debut2) and (Debut #< (Debut2 + Duree2))) => (Machine &\=Machine2)
		)
	).


