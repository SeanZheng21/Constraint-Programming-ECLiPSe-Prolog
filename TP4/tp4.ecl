:-lib(ic).

/*Q4.1*/
getData(TailleEquipes,NbEquipes,CapaBateaux,NbBateaux,NbConf):-
    TailleEquipes = [](5,5,2,1),
    NbEquipes is 4,
    CapaBateaux = [](7,6,5),
    NbBateaux is 3,
    NbConf is 3.

/*Q4.2*/
defineVars(T,NbEquipes,NbConf,NbBateaux):-
	dim(T,[NbEquipes,NbConf]),
	T#::1..NbBateaux.

/*Q4.3*/
getVarList(T,List):-
    dim(T,Dim),
	D1 is Dim[1],
	D2 is Dim[2,1],
	(multifor([J,I],1,[D2,D1]),
	param(T),
	fromto([],In,Out,List2)
	do
		Var is T[I,J],
		Out = [Var|In]
	),
	reverse(List2,List).	

/*
[eclipse 25]: defineVars(T,4,3,3),getVarList(T,List).

T = []([](_443{1 .. 3}, _443, _443), [](_485{1 .. 3}, _485, _485), [](_527{1 .. 3}, _527, _527), [](_569{1 .. 3}, _569, _569))
List = [_569{1 .. 3}, _527{1 .. 3}, _485{1 .. 3}, _443{1 .. 3}]
Yes (0.00s cpu)
*/	

/*Q4.4
 solve(T).

T = []([](1, 1, 1), [](1, 1, 1), [](1, 1, 1), [](1, 1, 1))


*/


/*Q4.5*/
pasMemeBateau(T):-
	(foreacharg(Line,T)
	do
		alldifferent(Line)
	).
/*
[eclipse 112]: solve(T).

T = []([](1, 2, 3), [](1, 2, 3), [](1, 2, 3), [](1, 2, 3))
Yes (0.00s cpu, solution 1, maybe more) ? ;

T = []([](1, 2, 3), [](1, 2, 3), [](1, 2, 3), [](1, 3, 2))
Yes (0.00s cpu, solution 2, maybe more) ? ;

T = []([](1, 2, 3), [](1, 2, 3), [](1, 3, 2), [](1, 2, 3))
Yes (0.00s cpu, solution 3, maybe more) ? ;

T = []([](1, 2, 3), [](1, 2, 3), [](1, 3, 2), [](1, 3, 2))
Yes (0.00s cpu, solution 4, maybe more) ? ;

*/

/*Q4.6*/


pasMemePartenaires(T,NbEquipes,NbConf):-
	(for(I1,1,NbConf-1),
	param(T,NbConf,NbEquipes)
	do
		(for(I2,I1+1,NbConf),
		param(I1,NbConf,NbEquipes,T)
		do
			(for(J1,1,NbEquipes-1),
			param(I1,I2,NbConf,NbEquipes,T)
			do
				(for(J2,J1+1,NbEquipes),
				param(I1,I2,J1,NbConf,NbEquipes,T)
				do
					(T[J1,I1]#=T[J2,I1]) => (T[J1,I2] #\= T[J2,I2])
				)
			)
		)
	).

/*
[eclipse 9]: solve(T).

T = []([](1, 2, 3), [](1, 3, 2), [](2, 1, 3), [](2, 3, 1))
Yes (0.00s cpu, solution 1, maybe more) ? ;

T = []([](1, 2, 3), [](1, 3, 2), [](2, 3, 1), [](2, 1, 3))
Yes (0.00s cpu, solution 2, maybe more) ? ;

T = []([](1, 3, 2), [](1, 2, 3), [](2, 1, 3), [](2, 3, 1))
Yes (0.00s cpu, solution 3, maybe more) ? ;

T = []([](1, 3, 2), [](1, 2, 3), [](2, 3, 1), [](2, 1, 3))
Yes (0.00s cpu, solution 4, maybe more) ? ;

T = []([](1, 2, 3), [](1, 3, 2), [](2, 1, 3), [](3, 1, 2))
Yes (0.00s cpu, solution 5, maybe more) ? ;

T = []([](1, 2, 3), [](1, 3, 2), [](2, 1, 3), [](3, 2, 1))
Yes (0.00s cpu, solution 6, maybe more) ? ;

T = []([](1, 2, 3), [](1, 3, 2), [](2, 3, 1), [](3, 1, 2))
Yes (0.00s cpu, solution 7, maybe more) ? ;

T = []([](1, 2, 3), [](1, 3, 2), [](2, 3, 1), [](3, 2, 1))
Yes (0.00s cpu, solution 8, maybe more) ? ;
*/

/*Q4.7*/

capaBateaux(T,TailleEquipes,NbEquipes,CapaBateaux,NbBateaux,NbConf):-
	(for(B,1,NbBateaux),
	param(T,TailleEquipes,NbEquipes,CapaBateaux,NbConf)
	do
		(for(J,1,NbConf),
		param(T,B,TailleEquipes,CapaBateaux,NbEquipes)
		do
			equipesSurBateau(T,B,J,NbEquipes,Liste),
			sum_list(Liste,Total),
			Capa is CapaBateaux[B],
			Total#=<Capa
		)
	).


equipesSurBateau(T,Bateau,Conf,NbEquipes,Res):-
	(for(I,1,NbEquipes),
	param(T,Bateau,Conf),
	fromto([],In,Out,Res)
	do
		B is T[I,Conf],
		ifEquals(B,Bateau,[I],[],Temp),
		append(In,Temp,Out)
	).

ifEquals(A,B,Then,Else,Res):-
	(A = B 
	-> Res = Then
	; Res = Else
	).


sum_list([], 0).
sum_list([H|T], Sum) :-
   sum_list(T, Rest),
   Sum is H + Rest.


solve(T):-
	getData(TailleEquipes,NbEquipes,CapaBateaux,NbBateaux,NbConf),
	defineVars(T,NbEquipes,NbConf,NbBateaux),
	pasMemeBateau(T),
	pasMemePartenaires(T,NbEquipes,NbConf),
	capaBateaux(T,TailleEquipes,NbEquipes,CapaBateaux,NbBateaux,NbConf),
	getVarList(T,L),
	labeling(L).

