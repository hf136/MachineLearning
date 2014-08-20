
data = load('data.txt');
X = data(:, [1,2]);
y = data(:, 3);

%图形化数据
pos = find(y == 1);
neg = find(y == 0);
figure; hold on;
plot(X(pos,1), X(pos,2), 'kx', 'MarkerEdgeColor', 'b');
plot(X(neg,1), X(neg,2), 'ko', 'MarkerEdgeColor', 'r');

% initial parameters
X = [ones(size(X,1),1) X];
MaxIters = 400;
lambda = 0;
init_theta = zeros(size(X,2), 1);
alpha = 0.000900;

% [lastcost, grad] = costFunction(X, init_theta, y, lambda);
% lastcost
% grad
% theta = init_theta - alpha * grad;

% for i = 2:MaxIters
% 	[cost grad] = costFunction(X, theta, y, lambda);
% 	if cost < lastcost
% 		theta = theta - alpha * grad;
% 		lastcost = cost;
			
% 	else
% 		i
% 		break;
% 	end
% end

% Cost at theta found by fminunc: 0.203498
% theta: 
%  -25.161272 
%  0.206233 
%  0.201470 

options = optimset('GradObj', 'on', 'MaxIter', 400);

%  Run fminunc to obtain the optimal theta
%  This function will return theta and the cost 
[theta, cost] = ...
	fminunc(@(t)(costFunction(X, t, y, lambda)), init_theta, options);

cost
theta

x1 = -1.0:-0.5;
x2 = -(theta(1) + theta(2)*x1)./theta(3);
plot(x1, x2);
hold off;