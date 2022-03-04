% budowa drzewa decyzyjnego w oparciu o podane obrazy (w wierszach) i numery klas 

function [D] = build_tree(obrazy,klasy)
 
%budowa drzewa
pnum = 1:length(obrazy(1,:));
max_par = max(max(obrazy));

[D,col] = addnode([],max_par,obrazy,klasy,pnum);



