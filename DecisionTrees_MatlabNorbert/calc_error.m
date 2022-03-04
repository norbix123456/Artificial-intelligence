function err = calc_error(D, przykl, klasy)
  liczbaprzykl = length(przykl(:,1));
  odpowiedzi = what_class(D, przykl);
  err = sum(odpowiedzi ~= klasy) / liczbaprzykl;