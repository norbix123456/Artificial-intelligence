%funkcja zwraca tablice, w ktorej w wierszu i kolumnie j jest 
%liczba obrazow klasy i zaklasyfikowanych do klasy j
%na przekatnej sa policzone obrazy klasyfikowane poprawnie

function error = test(D, przykl, klasy)
  ile_klas = max(klasy);
  error = zeros(ile_klas,ile_klas);
  odpowiedzi = jakaklasa(D, przykl);
  for i = 1:length(przykl(:,1))
    if odpowiedzi(i) > 0
      error(klasy(i), odpowiedzi(i)) = error(klasy(i), odpowiedzi(i)) + 1;
    end
  end