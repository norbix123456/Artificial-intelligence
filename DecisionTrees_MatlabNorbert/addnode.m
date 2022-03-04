% [W,col] = addnode(Ws,maxwart,p,klasy,pnum)
%
% A function that adds a decision tree node and launches it
% recursively for all node value values.
% Applies ID3 algorithm - selection of the attribute with the highest information gain
% of measured entropy
%
% Ws - tree in the form of a table [] at the beginning
% maxwart - maximum number of attribute values (can be
% less for fast attributes)
% p - array of examples to learn (in rows), attributes
% in columns, discrete attribute values in the fields
% from 1 up e.g. numbers of successive ranges of atr values.
% class - vector of numbers numbered from 1 up
% pnum - attribute numbers, first 1: length (p (1, :))
% W - output tree
% col - the column where the last node was saved

function [W,col] = addnode(Ws,maxwart,p,klasy,pnum) 
W = Ws; 
[liczba_przykl liczba_atr] = size(p);
if liczba_przykl==0     		% no examples for the value given
   col = 0;
   return;
end   
liczba_klas = max(klasy);
klasy1 = ind2vec2(round(klasy));
E = 1:length(p(1,:));
minE = inf;
atr_wybr=1; % attribute selected for the node
liczba_atr=length(p(1,:));

% Entropy calculation for individual attributes (variables):
if liczba_atr>1
for atr=1:liczba_atr		% subsequent attributes
   p1 = ind2vec2(round(p(:,atr))');	% zero one table: the rows correspond to the following values
                		    % of attribute atr
   n = sum(p1,2);       	% number of examples for individual attribute values 
   nw = p1*klasy1'; 		   % table of examples for attribute values (rows) and classes (columns)
   I = -sum( (nw.*repmat(1./(n+0.001),1,liczba_klas)).*...
      log2(0.000001+nw.*repmat(1./(n+0.001),1,liczba_klas)),2);
   E(atr) = I'*n/(sum(n)+0.001);   	% attribute atr entropy
   if minE > E(atr) 
      minE = E(atr);
      atr_wybr = atr;
   end   
end
else
   % less than 2 attributes remain
end

W = [W zeros(maxwart+1,1)];      % adding a new node-column
col = length(W(1,:));            % added column number

% end condition - all submitted examples belong to one class
if max(sum(klasy1,2))==length(klasy) 
   W(maxwart+1,col)=klasy(1);     % class number instead of attribute
   %' leaf - end of addnode'
   return
end

% Contradiction - at least 2 of the same examples belong to different classes
% therefore, after all the attributes have been exhausted, the examples are no longer
% separated

if liczba_atr==0
   [V klasa_max] = max(sum(klasy1,2));
   W(maxwart+1,col) = klasa_max;
   return
end    

W(maxwart+1,col) = pnum(atr_wybr);  % attribute number
ilowart = max(p(:,atr_wybr));       % once again the best attribute data
p1 = ind2vec2(p(:,atr_wybr)');
pnumnw = pnum([1:(atr_wybr-1) (atr_wybr+1):end]); % real attribute numbers

% Recursive branching for subsequent attribute values
for i=1:ilowart
   przyk = find(p1(i,:));      % a vector of non-zero indexes
   % Cut the array p by the column of the attribute used and leave the rows
   % that is, examples that are classified by the ith attribute value
   pnw = p(przyk,[1:(atr_wybr-1) (atr_wybr+1):end]) ;
   klasynw = klasy(przyk);         %obciecie wektora klas
   
   % ################     recursion      ####################
   [W colwar] = addnode(W,maxwart,pnw,klasynw,pnumnw);
     
   W(i,col)=colwar;    % newly created node address
end   
