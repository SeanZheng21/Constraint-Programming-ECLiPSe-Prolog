:-lib(ic).
:-lib(ic_symbolic).

:-local domain(personne(ron,zoe,jim,lou,luc,dan,ted,tom,max,kim,empty1,empty2,empty3,empty4,empty5,empty6)).


balancoire([](poids(G8,_),poids(G7,_),poids(G6,_),poids(G5,_),poids(G4,_),poids(G3,_),poids(G2,_),poids(G1,_),poids(D1,_),poids(D2,_),poids(D3,_),poids(D4,_),poids(D5,_),poids(D6,_),poids(D7,_),poids(D8,_))):-
    G8&::personne,
    G7&::personne,
    G6&::personne,
    G5&::personne,
    G4&::personne,
    G3&::personne,
    G2&::personne,
    G1&::personne,
    D1&::personne,
    D2&::personne,
    D3&::personne,
    D4&::personne,
    D5&::personne,
    D6&::personne,
    D7&::personne,
    D8&::personne,
    alldifferent([G8,G7,G6,G5,G4,G3,G2,G1,D1,D2,D3,D4,D5,D6,D7,D8]).
    
positions([](-8,-7,-6,-5,-4,-3,-2,-1,1,2,3,4,5,6,7,8)).
poids(ron,24).
poids(zoe,39).
poids(jim,85).
poids(lou,60).
poids(luc,165).
poids(dan,6).
poids(ted,32).
poids(tom,123).
poids(max,7).
poids(kim,14).
poids(empty1,0).
poids(empty2,0).
poids(empty3,0).
poids(empty4,0).
poids(empty5,0).
poids(empty6,0).



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

