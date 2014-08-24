load data.txt
X = data(:, 1:2);
y = data(:, 3);

% 图形化原始数据
pos = y == 1;
neg = y == 0;
subplot(1,3,1);
plot(X(pos, 1), X(pos, 2), 'kx', 'MarkerEdgeColor', 'b');
hold on;
plot(X(neg, 1), X(neg, 2), 'ko', 'MarkerEdgeColor', 'r');
hold off;
title('raw data');

load result.txt
X = result(:, 1:2);
predict = result(:, 3);
pos = predict == 1;
neg = predict == 0;
subplot(1,3,2);
plot(X(pos, 1), X(pos, 2), 'kx', 'MarkerEdgeColor', 'b');
hold on;
plot(X(neg, 1), X(neg, 2), 'ko', 'MarkerEdgeColor', 'r');
hold off;
title('predictions');

pos = y ~= predict;
subplot(1,3,3);
plot(X(pos, 1), X(pos, 2), 'kx', 'MarkerEdgeColor', 'r');
title('error');
