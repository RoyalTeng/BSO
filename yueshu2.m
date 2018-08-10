function f = yueshu2(x,x0)%都是行向量,手数和无风险比例
global S  p 
f = 100*sum(x.*p)+x0*S-S;