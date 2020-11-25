% 编码初始化编码
% initpop.m函数的功能是实现群体的初始化，popsize表示群体的大小，chromlength表示染色体的长度(二值数的长度)，
% 长度大小取决于变量的二进制编码的长度。
function pop=initpop(popsize,chromlength) 
pop=round(rand(popsize,chromlength)); 
% rand随机产生每个单元为 {0,1} 行数为popsize，列数为chromlength的矩阵，
% roud对矩阵的每个单元进行圆整。这样产生随机的初始种群。
end