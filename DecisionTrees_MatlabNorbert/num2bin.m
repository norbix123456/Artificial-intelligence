% Zamiena liczbe na postac binarna
%   [bin] = num2bin(num,roz)
%   bin - wektor zerojedynkowy
%   num - liczba calkowita
%   dlugosc - liczba elementow wektora
function [bin] = num2bin(num,dlugosc) 

if nargin==1
   if num==0
      dlugosc = 1;
   else 
      dlugosc = 1+floor(log2(num+.1));
   end   
end
potegi2 = 2.^[0:dlugosc-1];   
aa = bitand(num,potegi2)>0;
bin = fliplr(aa);