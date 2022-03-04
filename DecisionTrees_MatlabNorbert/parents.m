% funkcja "ojcowie(D)" zwraca wektor o tej samej dlugoœci co 
% liczba wezlow, przypisujac kazdemu wezlowi numer wezla bedacego
% jego przodkiem, tylko dla korzeni zwraca wartosc 0 - brak przodka 

function tablica_ojcow = parents(D)

[liczba_wierszy liczba_wezlow] = size(D);			
tablica_ojcow = zeros(1,liczba_wezlow);
for i=1:liczba_wezlow
  if sum(D(1:end-1,i)) > 0 		%jesli wezel i nie jest lisciem (ma dzieci)
    for j=1:liczba_wierszy-1
      if D(j,i) > 0 
        tablica_ojcow(D(j,i)) = i;	%jego dzieciom przypisz odpowiedni numer ojca
      end
    end
  end
end
