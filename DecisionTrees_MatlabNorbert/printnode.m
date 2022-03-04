% nic=printnode(f,W,col,h)
% Drukowanie drzewa o dowolnym stopniu wezla w pliku f = fopen('nazwa','w')
%   W - drzewo w formie tabeli (patrz addnode.m)
%   col - numer kolumny tabeli czyli wezla
%   h - glebokosc wezla
% przyklad:
% printnode(f,W,1,0)

function nic=printnode(f,W,col,h)
stopien = length(W(:,1))-1;
for j=1:h
   fprintf(f,'---');
end   

if col==0
   fprintf(f,'null \r\n');
elseif sum(W(1:end-1,col))==0   
   fprintf(f,'class %d\r\n',W(end,col));
else
   fprintf(f,'node %d\r\n',W(end,col));
   for i=1:stopien
      printnode(f,W,W(i,col),h+1);
   end   
end   
nic=0;