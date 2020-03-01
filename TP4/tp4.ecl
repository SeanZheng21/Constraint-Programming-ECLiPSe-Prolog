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
twiceInArray(Array,Res):-
	dim(Array,Dim),
	D is Dim[1],
	D2 is D-1,
	(for(I,1,D2),
	param(Array,D,Res)
	do
		K is I+1,
		(for(J,K,D),
		param(I,Array),
		fromto([],In,Out,Res)
		do
			V1 is Array[I],
			(V1 is Array[J]) -> (Out = [V1|Res])
			
		)
	).

/*
pasMemePartenaires(T,NbEquipes,NbConf):-
	dim(T,Dim),
	D1 is Dim[1],
	D2 is Dim[2,1],
	(for(J,1,D2),
	param(T)
	do
	*/	
	


solve(T):-
	getData(TailleEquipes,NbEquipes,CapaBateaux,NbBateaux,NbConf),
	defineVars(T,NbEquipes,NbConf,NbBateaux),
	pasMemeBateau(T),
	getVarList(T,L),
	labeling(L).

