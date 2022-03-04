% funkcja zwraca liczbe wezlow drzewa (nie bedacych liscmi)

function L = number_of_nodes(D)

L = length(find(sum(D(1:end-1,:))));