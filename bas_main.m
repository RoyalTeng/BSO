function bas_main(N,yp)%天牛迭代次数，预跑次数


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%参数介绍  
%S=10^6交易总金额
%X=[x1,x2,x3...xn]{sum(X)=1}整个投资组合持有的n 种股票的投资比例向量
%x0表示投资于无风险资产
%σ(theta)表示所要投资的n 种股票的方差-协方差矩阵
%p(i)第i 种股票的每股买入价格
%r(i)表示第i种股票的收益率
%n(i)第i种股票的交易手数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%-----------------------------参数初始化--------------------------------
global p r theta S
[theta,p,r] = suan_xiefangcha()%都是行向量
S=10^6; %总金额设为100w
k=9; %论文中取了8支股票和一只无风险股
N=N%天牛的迭代次数
yp = yp%预跑的次数



%----------------------初始股票比例向量-----------------------------------
i=rand(1,k+1);    % k+1个0-1的随机数
j=i/(sum(i));   %化成k+1个投资比例
global x0 X
x0 = j(k+1);%无风险投资的比例
%前8项为风险投资
mon = S*(1-x0).*j(1:k)/sum(j(1:k));%风投每只股票的钱数
shou = mon./(100.*p);%每只股票交易手数
nev=round(shou); % 手数取整
nev(k) = round((S*(1-x0)-sum(nev(1:k-1).*100.*p(1:k-1)))/(100*p(k)));%先前7个取整，第8个用钱数取整
%nev(8) = round(S*(1-x0)-sum(mon(1:7)));
n = nev;%k只股票的手数向量

X = 100.*n.*p/S; %初始比例向量与交易手数的关系




%------------------------开始迭代------------------------------------------
fx = [];wz = [];zong =[];%中间值存储器
cas = 2%预跑的步长变化方式
tic

for i=1:yp %yp = 1:200
%n:初始位置(初始设定的交易手数向量)，N：迭代次数,cas:步长的变化情况,k:变量的维度
[y1,location]=bas(n,N,cas,k);
display(['手数值=[',num2str(location'),'],风险值=',num2str(y1)]);
wz = cat(2,wz,location);
fx = cat(2,fx,y1);
zong = cat(1,fx,wz);

end
toc


%------------------------选最优的再跑一次------------------------------------
[minv,minl] = min(zong(1,:))%minv:最小值的位置，minl:最小值得位置(列)
minshou = zong(2:end,minl)'
cas =1;
figure
[value , location] = bas(minshou,N,cas,k);%


%------------------------数据可视化----------------------------------
display(['手数值=[',num2str(location'),'],风险值=',num2str(value)]);
bili = 100*location'.*p./S;
x0 = (S-sum(100*location'.*p))/S;
bili_zong = cat(2,x0,bili);
display(['投资比例=[',num2str(bili_zong),']']);
zong = sum(100*location'.*p);
display(['风投总钱数=[',num2str(zong),']']);
jisuan_fx = bili*theta*bili';
display(['计算风险值=[',num2str(jisuan_fx),']'])


