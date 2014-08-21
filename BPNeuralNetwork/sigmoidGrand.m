%%  计算sigmoid的导数
function grand = sigmoidGrand(z)

grand = sigmoid(z) .* (1-sigmoid(z));

end