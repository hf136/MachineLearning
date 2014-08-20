%% sigmoid: sigmoid function,单位跃阶函数
function g = sigmoid(z)

g = 1 ./ (1 + exp(-z));

end