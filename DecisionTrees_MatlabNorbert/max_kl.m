%funkcja zwraca numer klasy najliczniej reprezentowanej w wezle w

function etykieta = max_klasa(roz,w)

[liczba_klas liczba_wezlow] = size(roz);
max_liczba_przyk = max(roz(:,w));	%max liczba przykladow pewnej klasy w danym wezle w
for i = 1:liczba_klas
  if roz(i, w) == max_liczba_przyk
    etykieta = i;			%najliczniej reprezentowana klasa w danym wezle
  end
end
