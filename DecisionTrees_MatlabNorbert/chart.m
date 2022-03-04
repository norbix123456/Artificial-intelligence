% Tworzenie wykresu przedstawiajacego blad klasyfikacji obrazow klasyfikowanych
% przez drzewo decyzyjne w trakcie budowy drzewa

Dtemp = D;
roz = distribution(D,TrainingVectors,TrainingClasses);		%rozklad przykladow w poszczegolnych wezlach
ojciec = parents(D);
gleboko = depth(D,ojciec);
[lp lw] = size(D);
lp = lp - 1;

y1=zeros(1,lw);
y2=zeros(1,lw);
wezel = 0;
krok=1;
y1(krok) = calc_error(D,TrainingVectors,TrainingClasses);		%dla zbioru uczacego
y2(krok) = calc_error(D,TestVectors,TestClasses); 		%dla zbioru testowego

while wezel ~= 1			%az drzewo zostanie zmniejszone do samego korzenia

    krok = krok + 1;
    max_gl = max(gleboko);
    wezel = 1;
    while gleboko(wezel) < max_gl
        wezel = wezel + 1;			%najglebiej polozony wezel (lisc)
    end
    wezel = ojciec(wezel);		%wezel, ktorego galezie beda usuniete
    for i = 1:lp
        if D(i,wezel) > 0
            dziecko = D(i,wezel);
            D(:,dziecko) = zeros(lp+1,1);	%usuniecie wezla potomnego (zerowa kolumna)
            gleboko(dziecko) = -1;
        end
    end
    D(:,wezel) = zeros(lp+1,1);		%wezel staje sie lisciem
    D(end,wezel) = max_kl(roz,wezel);	%przypisanie do liscia etykiety klasy

    %testowanie
    y1(krok) = calc_error(D,TrainingVectors,TrainingClasses);		%dla zbioru uczacego
    y2(krok) = calc_error(D,TestVectors,TestClasses); 		%dla zbioru testowego
end

D = Dtemp;
y1(krok+1 : lw) = [];
y2(krok+1 : lw) = [];
y1 = y1([krok:-1:1]);
y2 = y2([krok:-1:1]);
x = 0:krok-1;
plot(x,y1,'r',x,y2,'b');
legend('training error','test error');
xlabel('number of nodes');