function Dp = delete_node(D,wezel)
  [liczba_wierszy liczba_wezlow] = size(D);
  liczba_par = liczba_wierszy - 1;
  Dp = D;
  for i = 1:liczba_par
    if Dp(i,wezel) > 0
      Dp = delete_node(Dp,Dp(i,wezel));
    end
  end
  Dp(1:liczba_wierszy,wezel) = zeros(liczba_wierszy,1);