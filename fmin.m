function fbest=fmin(x)%x：行向量手数
global  theta %协方差矩阵
global  S p
X = x;%(行向量)交易手数向量
X1 = (100*X.*p)/S; %风投比例向量
x0  = (S - 100*sum(X.*p))/S; %无风险投资比例

%X = [];%表示整个投资组合持有的n 种股票的投资比例向量
M = 10^10;%惩罚因子是一个很大的数

fbest = X1*theta*X1' + M*((max(0,yueshu1(X,x0)))^2 + (max(0,yueshu2(X,x0)))^2 + (max(0,-min(x))).^2+ (max(0,-min(x0))).^2);
end