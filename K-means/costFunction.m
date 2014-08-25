function J = costFunction(X, u, c)

m = size(X, 1);
J = 0;

for i = 1:m
	J = J + (X(i,:) - u(c(i), :))*(X(i,:) - u(c(i), :))';
end

J = 1/m * J;

end