%% 一个三层的神经网络

load('data.txt');
pos = 1:5:500;				%速度太慢！！只挑选一部分数据进行训练
pos = [pos 502:5:1002];
X = data(pos, 1:2);
y = data(pos, 3);

% 图形化原始数据
pos = y == 1;
neg = y == 0;
subplot(1,3,1);
plot(X(pos, 1), X(pos, 2), 'kx', 'MarkerEdgeColor', 'b');
hold on;
plot(X(neg, 1), X(neg, 2), 'ko', 'MarkerEdgeColor', 'r');
hold off;

% 归一化数据
X(:, 1) = ( X(:,1) - mean(X(:,1)) ) / (max(X(:,1)) - min(X(:,1)));
X(:, 2) = ( X(:,2) - mean(X(:,2)) ) / (max(X(:,2)) - min(X(:,2)));

% initial params
inputs = size(X, 2);
hiddenNums = 4;
outputs = 1;
lambda = 0;
alpha = 3;
MaxIters = 11000;

epsilon = 1;
init_theta1 = rand(hiddenNums, inputs+1)*epsilon*2 - epsilon;		% 随机初始化theta
init_theta2 = rand(outputs, hiddenNums+1)*epsilon*2 - epsilon;

% 训练
[cost grad1 grad2] = costFunction(X, y, init_theta1, init_theta2, ...
										lambda, outputs, hiddenNums);
fprintf('迭代次数：1, cost:%f', cost);
theta1 = init_theta1 - alpha*grad1;
theta2 = init_theta2 - alpha*grad2;
for i = 1:MaxIters
	[cost grad1 grad2] = costFunction(X, y, theta1, theta2, ...
										lambda, outputs, hiddenNums);
	fprintf('迭代次数：%d, cost:%f', i, cost);
	theta1 = theta1 - alpha*grad1;
	theta2 = theta2 - alpha*grad2;
end
save('theta.txt', 'theta1', 'theta2');

%load theta.txt

predictions = zeros(size(y));
for i = 1:size(X, 1)
	a1 = [1 X(i,:)];
	z2 = theta1 * a1';
	a2 = sigmoid(z2);
	a2 = [1; a2];
	z3 = theta2 * a2;
	if z3 >= 0
		predictions(i) = 1;
	else 
		predictions(i) = 0;
	end
end

Accuracy = sum(predictions == y)/size(X, 1)

% 显示结果
pos = predictions == 1;
neg = predictions == 0;
subplot(1,3,2);
plot(X(pos, 1), X(pos, 2), 'kx', 'MarkerEdgeColor', 'b');
hold on;
plot(X(neg, 1), X(neg, 2), 'ko', 'MarkerEdgeColor', 'r');
hold off;

pos = predictions ~= y;
subplot(1,3, 3);
plot(X(pos, 1), X(pos, 2), 'kx', 'MarkerEdgeColor', 'r');
