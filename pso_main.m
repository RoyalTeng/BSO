function pso_main(N)%迭代次数2000



%---------------------------------参数介绍---------------------------------  
%S=10^6交易总金额
%X=[x1,x2,x3...xn]{sum(X)=1}整个投资组合持有的n 种股票的投资比例向量
%x0表示投资于无风险资产
%σ(theta)表示所要投资的n 种股票的方差-协方差矩阵
%p(i)第i 种股票的每股买入价格
%r(i)表示第i种股票的收益率
%n(i)第i种股票的交易手数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%-------------------------------参数初始化----------------------------------
global p r theta S
[theta,p,r] = suan_xiefangcha()
k=9; %论文中取了8支股票和一只无风险股--问题的维度
S=10^6; %总金额设为100w
N=N;choose=0;%最大迭代次数，PSO里的情况选择



%------------------------初始股票比例向量-----------------------------------
i=rand(1,k+1);    % k+1个0-1的随机数
j=i/(sum(i));   %化成k+1个投资比例
global x0
x0 = j(k+1);%无风险投资的比例
%前8项为风险投资
mon = S*(1-x0).*j(1:k)/sum(j(1:k));%风投每只股票的钱数
shou = mon./(100.*p);%每只股票交易手数
nev=round(shou); % 手数取整
%先前k-1个取整，第k个用钱数取整
nev(k) = round((S*(1-x0)-sum(nev(1:k-1).*100.*p(1:k-1)))/(100*p(k)));
n = nev;%k只股票的手数向量行向量

global X 
X = 100.*n.*p/S; %初始比例向量与交易手数的关系



%------------------------------开始迭代------------------------------------
fvalue=[];%最优风险值存储器
tic
for i = 1:1
 %[location,fbest]=pso(choose,n,N,k); choose：求上层还是下层，n：初始值，N：最大迭代次数，k:问题的维度
[location,fbest] = pso(choose,n,N,k);
fvalue = cat(2,fvalue,fbest);
end



%----------------------------数据可视化-------------------------------------
display(['最优风险值=[',num2str(min(fvalue)),']'])
bili = 100*location.*p/S;
n_fengxian = 1-sum(bili);
t_bili = cat(2,n_fengxian,bili);
display(['最优投资比例=[',num2str(t_bili),']'])
toc













%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%以下为天牛须的操作%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
for i=1:1
    [y1,location]=mybas1(n,N,cas,k);%n:初始位置(初始设定的交易手数向量)，N：迭代次数,cas:步长的变化情况,k:变量的维度
    %min1(i,1)=y1;
    %min1(i,2)=location;
    display(['手数值=[',num2str(location'),'],风险值=',num2str(y1)]);
end
wz = cat(2,wz,location);
fx = cat(2,fx,y1);
zong = cat(1,fx,wz);
toc


[minv,minl] = min(zong(1,:))%minv:最小值的位置，minl:最小值得位置(列)
minshou = zong(2:end,minl)'
cas =1;
figure
[value , location] = mybas1(minshou,N,cas,k)%
display(['手数值=[',num2str(location'),'],风险值=',num2str(value)]);
%}


