load data.txt;

MaxIters = 100;
randnum = 5;		% 多做几次聚类，取cost最小的一次分类
K = 3;

[m n] = size(data);
X = data;

tc = zeros(m, randnum);
cost = zeros(randnum, 1);
for cnt = 1:randnum

	data = data(randperm(m), :);
	u = data(1:K, :);
	c = zeros(m, 1);

	for i = 1:MaxIters

		% 寻找X（j）距离最近的聚类中心 k
		for j = 1:m
			mi = -1;
			for k = 1:K
				if (X(j, :) - u(k, :))*(X(j, :) - u(k, :))' > mi
					mi = (X(j, :) - u(k, :))*(X(j, :) - u(k, :))';
					c(j) = k;			% 第 j 个数据属于第 k 个聚类中心
				end
			end
		end

		% 计算每一类数据的聚类中心
		temp_u = u;
		u = zeros(K, n);
		num = zeros(K, 1);
		for j = 1:m
			u(c(j), :) = u(c(j), :) + X(j, :);
			num(c(j)) = num(c(j)) + 1;
		end
		for k = 1:K
			if num(k) ~= 0
				u(k, :) = 1/num(k) .* u(k, :);
			end
		end
		% 聚类中心不变则退出
		if sum(temp_u == u) == K
			break;
		end
	end

	cost(cnt) = costFunction(X, u, c);
	tc(:, cnt) = c;
end

[mi idx] = min(cost);
c = tc(:, idx);

% show result
pos = c == 1;
plot(X(pos, 1), X(pos, 2), 'kx', 'MarkerEdgeColor', 'b');
hold on;
pos = c == 2;
plot(X(pos, 1), X(pos, 2), 'ko', 'MarkerEdgeColor', 'r');
pos = c == 3;
plot(X(pos, 1), X(pos, 2), 'k*', 'MarkerEdgeColor', 'g');
hold off;
