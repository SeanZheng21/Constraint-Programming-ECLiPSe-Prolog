:-lib(ic).
:-lib(branch_and_bound).
/*Question 1*/
getData(VecNbTech, VecJour, VecProfit, VecFab):-
    vecNbTech(VecNbTech),
    vecJour(VecJour),
    vecProfit(VecProfit),
    vecFab(VecFab).
vecNbTech([](5, 7, 2, 6, 9, 3, 7, 5, 3)).
vecJour([](140,130,60,95,70,85,100,30,45)).
vecProfit([](4, 5, 8, 5, 6, 4, 7, 10, 11)).

vecFab(Fab):-
    dim(Fab, [9]),
    Fab #:: 0..1.

/*Test*/
/*
vecNbTech(NbT).
vecJour(J).
vecProfit(Pr).
vecFab(Fab).
getData(VecNbTech, VecJour, VecProfit, VecFab).*/
/*======================*/

/*Question 2*/
vecProduct(V1, V2, VRes):- 
    dim(V1,[D]),
    dim(V2,[D]),
    dim(VRes,[D]),
    (foreacharg(Elt1,V1), foreacharg(Elt2,V2), foreacharg(EltRes,VRes) do
        EltRes #= Elt1 * Elt2
    ).

vecSum(Vec,Sum):-(
    foreacharg(Elt,Vec), fromto(0,In,Out,Sum) do
        Out #= In + Elt
    ).

vecDotProduct(V1, V2, S):-
    vecProduct(V1, V2, TmpVec),
    vecSum(TmpVec, S).
/*Test*/
/*
vecProduct([](1,2,3),[](4,5,6), Res).
Res = [](4, 10, 18)
vecSum([](4, 10, 18), Sum).
Sum = 32

[eclipse 38]: vecDotProduct([](1,2,3),[](4,5,6), Sum).
Sum = 32
[eclipse 42]: vecDotProduct([](1,2,3),[](4,5,6,7), Sum).
No (0.00s cpu)
*/

sumNbTech(VecFab, SumTech):-
    vecNbTech(VecNbTech),
    vecDotProduct(VecNbTech, VecFab, SumTech).

sumProfit(VecFab, SumProfit):-
    vecProfit(VecProfit),
    vecDotProduct(VecProfit, VecFab, SumProfit).

vecProfitSum(VecFab, SumProfit):-
    vecProfit(VecProfit),
    vecProduct(VecProfit, VecFab, SumProfit).

/* Test */
/* 
[eclipse 47]: sumNbTech([](1,1,1,0,0,0,0,0,0),S).
S = 14
[eclipse 49]: sumProfit([](1,1,1,0,0,0,0,0,0),S).
S = 17
[eclipse 52]: vecProfitSum([](1,1,1,0,0,0,0,0,0),S).
S = [](4, 5, 8, 0, 0, 0, 0, 0, 0)
*/
/*======================*/

/*Question 3 */
poseConstraints(Fab,NbTechTotal, Profit):-
    vecFab(Fab),
    sumNbTech(Fab,NbTechTotal),
    NbTechTotal #=<22,
    sumProfit(Fab, Profit),
    labeling(Fab).
/*Test*/
/*[eclipse 57]: poseConstraints(Fab,NbTechTotal, Profit).
*/
/*======================*/

/*Question 4*/

generateX(X):-
    [X,Y,Z,W]#::[0..10], 
    X #= Z+Y+2*W, 
    X #\= Z+Y+W,
    labeling([X,Y,Z,W]).

generateMinX(XMin):-
    minimize(generateX(XMin), XMin).
    

/*Test*/
/*
[eclipse 62]: generateX(X).
[eclipse 4]: generateMinX(Minn).
*/
/*======================*/

/*Question 5*/

poseConstraintsMin(Profitt):-
    minimize(poseConstraints(_Fab, _NbTechTotal, Profitt), 1000 - Profitt).
/*Test*/
/*poseConstraintsMin(Profitt).*/
/*======================*/