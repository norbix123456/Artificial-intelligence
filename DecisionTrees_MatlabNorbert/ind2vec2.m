function x = ind2vec2(ind)
x = zeros(max(ind),length(ind));
for i=1:length(ind)
    x(ind(i),i) = 1;
end