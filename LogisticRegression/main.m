
data = load('data.txt');
X = data(:, [1,2]);
y = data(:, 3);

% 归一化数据
for i = 1:size(X,2)
	X(:,i) = (X(:,i) - sum(X(:,i))/size(X, 1))/(max(X(:,i)) - min(X(:,i)));
end

% 图形化数据
pos = find(y == 1);
neg = find(y == 0);
figure; hold on;
plot(X(pos,1), X(pos,2), 'kx', 'MarkerEdgeColor', 'b');
plot(X(neg,1), X(neg,2), 'ko', 'MarkerEdgeColor', 'r');

% initial parameters
X = [ones(size(X,1),1) X];
MaxIters = 1000;
lambda = 0;
init_theta = zeros(size(X,2), 1);
alpha = 2;

[lastcost, grad] = costFunction(X, init_theta, y, lambda);
theta = init_theta - alpha * grad;
for i = 2:MaxIters
	[cost grad] = costFunction(X, theta, y, lambda);
	if cost < lastcost
		theta = theta - alpha * grad;
		lastcost = cost;
	else
		break;
	end
end
cost

x1 = min(X(:,2)):max(X(:,2));
x2 = -(theta(1) + theta(2)*x1)./theta(3);
plot(x1, x2);
hold off;