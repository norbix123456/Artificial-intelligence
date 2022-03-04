% Zamienia liczbe/wektor na wektor/macierz wartosci binarnych
%   [bin] = num2bin(num,roz)
%   bin - wektor zerojedynkowy/macierz - liczby w wierszach 
%   num - liczba calkowita
%   roz - rozmiar wektora wyjsciowego
function [bin] = num2bin(num,roz) 

mnoz = 2.^[0:roz-1];
aa = [];
for ii=1:length(num)   
   aa = [aa;bitand(num(ii),mnoz)>0];
end
bin = fliplr(aa);