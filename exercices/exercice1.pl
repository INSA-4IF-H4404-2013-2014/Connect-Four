personne(pjeanmarie,h).
personne(mmathieu,h).
personne(mscuturici,f).
personne(mroland,h).
personne(schristine,f).
personne(rjeannine,f).
personne(brumpler,f).
personne(wmartin,h).
personne(aguillaume,h).

parent(aguillaume,mscuturici).
parent(aguillaume,schristine).
parent(wmartin,mmathieu).
parent(wmartin,mscuturici).
parent(mmathieu,brumpler).
parent(mmathieu,pjeanmarie).
parent(mroland,brumpler).
parent(mroland,pjeanmarie).

parents(X) :- parent(X,Y).

demifrere(X,Y) :- parent(Z,P1), parent(X,P1), not(X = Z).
frere(X,Z) :-
    parent(Z,P1), parent(X,P1), parent(X,P2),
    parent(Z,P2), not(P1 = P2), not(X = Z).

ascendance(X,Y) :- parent(X,Y).
ascendance(X,Y) :- parent(X,Z),ascendance(Z,Y).

oncleDeX(X,Y) :- parent(X,Z),frere(Z,Y).
