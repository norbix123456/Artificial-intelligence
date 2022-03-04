% r = rozklad(D,przykl,klasy)
%
%Przechodzenie drzewa decyzyjnego D w celu zapisania dla kazdego
%wezla liczby przykladow poszczegolnych klas,
%ktore do tego wezla docieraja
%r - tablica o wymiarach [liczba klas  liczbia wezlow] 
%r(i,j) - liczba obrazow klasy i w wezle j

function r = distribution(D,przykl,klasy)

liczbaprzykl = length(przykl(:,1));
liczba_klas = max(klasy);
liczba_wezlow=length(D);
r = zeros(liczba_klas,liczba_wezlow);

for i=1:liczbaprzykl
   prz = przykl(i,:);
   kl = klasy(i);
   kol = 1; 
   r(kl,kol) = r(kl,kol) + 1;		%zwieksz licznik obrazow danej klasy w korzeniu       
   while (kol>0) & (sum(D(1:end-1,kol)) > 0)	%przechodzenie drzewa az do liscia
      kol = D(prz(D(end,kol)),kol); 		
      if kol == 0 break;
      end
      r(kl,kol) = r(kl,kol) + 1; 	%zwieksz licznik obrazow danej klasy w tym wezle       
   end 
end  