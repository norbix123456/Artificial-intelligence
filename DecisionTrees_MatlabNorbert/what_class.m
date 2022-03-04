% [klasy droga] = jakaklasa(D,przykl)
%
% Przechodzenie drzewa decyzyjnego D klasyfikujac zbior
% przykladow przykl.
% D - tablica, w ktorej kolumnami sa wezly w kolejnosci 
%   przechodzenia wglab, wierszami numery kolumn wezlow 
%   odpowiadajacym kolejnym wartoscia atrybutu + ostatni
%   wiersz, ktory przechowuje numer atrybutu w wezle lub
%   numer klasy gdy wezlem jest lisc.
% przykl - tablica dyskretnych wartosci atrybutow, 
%   przyklady w wierszach, atrybuty w kolumnach
% klasy - wektor wyznaczonych klas dla podanych przykladow
% droga - sciezka kolejno sprawdzanych atrybutow do klasyfikacji
%   tablica: wiersze-przyklady, kolumny przechodzone atrybuty 
%   dopelnione zerami
function [klasy, droga] = what_class(D,przykl)

liczbaprzykl = length(przykl(:,1));
[liczbaprzykl liczbapar] = size(przykl);
klasy = zeros(1,liczbaprzykl);
droga = zeros(liczbaprzykl,liczbapar);
for i=1:liczbaprzykl
   prz = przykl(i,:);
   pa = D(end,1);
   kol = 1; 
   % kol moze=0 dla przykladow testowych (atrybut ma wartosc,
   % ktorej nie mial zaden przyklad do nauki)
   k=1;
   while (kol>0) & (sum(D(1:end-1,kol))>0) %przechodzenie drzewa az do liscia - 
      droga(i,k)=D(end,kol);
      k = k+1;
      wart_atr = prz(D(end,kol));
      if wart_atr > length(D(:,1))-1 kol=0; break; % wartosc wieksza od liczby wartosci atr. w tablicy D
      end
      kol = D(wart_atr,kol);        %gdy zera we wszystkich wierszach-{ostatni}  
      if kol == 0 break;
      end	
   end
   if kol == 0			                      %brak galezi dla danej wartosci atrybutu (nie dotrze do liscia)
      klasy(i) = 0;                        %nie jest klasyfikowany
   else				                         %przyklad dotarl do liscia   
      klasy(i) = D(end,kol);               %w ostatnim numer klasy
   end   
end
 