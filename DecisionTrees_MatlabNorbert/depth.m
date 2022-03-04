% funkcja zwraca informacje o glebokosci poszczegolnych wezlow drzewa D
% po wywolaniu  "glebokosc(D)"

function tablica_glebokosci = depth(D,ojciec)

if nargin < 2 % brak tablicy ojciec
   ojciec = parents(D);
end

lw = length(D);
tablica_glebokosci = zeros(1,lw);
for i=lw:-1:2
  g = 0;  
  ojc = ojciec(i);
  while ojc > 0 
    g = g + 1;
    ojc=ojciec(ojc);
  end
  tablica_glebokosci(i) = g;
end

