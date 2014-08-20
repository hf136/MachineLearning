%% compute cost function and gradient
function [J grad] = costFunction(X, theta, y, lambda)

[m, n] = size(X);
J = 0;
grad = zeros(size(theta));
Hx = sigmoid(X * theta);

J = -1/(2*m) * sum(y .* log(Hx) + (1-y) .* log(1-Hx));
J = J + lambda/(2*m) * sum(theta(2:end).^2);	%regularized

grad = 1/m * X'*(Hx - y);

tmepTheta = [0; theta(2:end)];
grad = grad + lambda/m*tmepTheta;

end