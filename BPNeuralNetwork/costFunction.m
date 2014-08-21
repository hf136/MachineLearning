%% outputs: 输出层单元个数, hiddenNums: 隐藏层单元个数

function [J grad1 grad2] = costFunction(X, y, theta1, theta2, lambda, outputs, hiddenNums)

[m, inputs] = size(X);
n = inputs + 1;

J = 0;
theta1_grad = zeros(size(theta1));		% hiddenNums * n
theta2_grad = zeros(size(theta2));		% outputs * hiddenNums+1

for i = 1:m
	a1 = [1; X(i,:)'];			% add bias units, n * 1
	z2 = theta1 * a1;
	a2 = sigmoid(z2);
	a2 = [1; a2];				% add bias units, hiddenNums+1 * 1

	z3 = theta2 * a2;
	Hx = sigmoid(z3);

	% 计算cost
	J = J + sum(y(i).*log(Hx) + (1-y(i))*log(1-Hx));

	delta3 = Hx - y(i);
	delta2 = theta2'*delta3 .* sigmoidGrand([0; z2]);
	delta2 = delta2(2:end);

	theta1_grad = theta1_grad + delta2 * a1';		%	hiddenNums * 1 X 1 * n
	theta2_grad = theta2_grad + delta3 * a2';		%	outputs * 1 X 1 * hiddenNums+1
end

J = -1/m * J;

theta1_grad = 1/m * theta1_grad;
theta2_grad = 1/m * theta2_grad;

% regularized
J = J + lambda/(2*m) * sum(sum(theta1(:,2:end).^2));		% 除了第一列的theta
J = J + lambda/(2*m) * sum(sum(theta2(:,2:end).^2));

theta1_grad(:,2:end) = theta1_grad(:,2:end) + lambda/m * theta1(:,2:end);
theta2_grad(:,2:end) = theta2_grad(:,2:end) + lambda/m * theta2(:,2:end);

grad1 = theta1_grad;
grad2 = theta2_grad;