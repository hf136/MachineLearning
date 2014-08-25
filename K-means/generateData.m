d1 = rand(20, 2) .* 2;

d2 = rand(20, 1) .* 2 + 3;
d2 = [d2 rand(20, 1).*2 + 1];

d3 = rand(20, 1) .* 2 + 1;
d3 = [d3 rand(20, 1) .*2 + 3];

data = [d1; d2; d3];
save('data.txt', 'data');