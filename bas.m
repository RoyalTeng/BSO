function [fbest1,loc]=bas(n,N,cas,k)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%初始化参数
c=10;%ratio between step and d0
%n=N;%iterations
%k=20;%space dimension
%x=1*rand(k,1)%intial value初始化位置
%global x
x = n';%（列向量）8支股票的比例向量转置

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%分情况初始化步长
eta=0.95;%case1的参数
if(cas==1)
    step=6;%case 1?choose step=step*eta; initial step set as the largest input range
else
    step=12;%case 2: choose temp=temp*eta; step=temp+step0; for step size with a minimal resolution
    step0=0.05;%case 2 %for step size with a minimal resolution
    temp=step-step0;%case 2 %for step size with a minimal resolution
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%找出的第一个最优解
xbest=x;
fbest=f(xbest);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%数组临时存储数据
fbest_store=fbest;
x_store=[0;x;fbest];%%%%%%%%%%%%%%%%%%%%%%%
display(['0:','xbest=[',num2str(xbest'),'],fbest=',num2str(fbest)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%iteration开始迭代
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d0=step/c;%两须之间的距离
for i=1:N
    dir=rands(k,1);%头在k维空间的朝向是随机的
    dir=dir/(eps+norm(dir));%方向向量归一化,方向
    xleft=x+dir*d0/2;%空间中左须位置随机
    fleft=f(xleft);%左须位置的函数值
    xright=x-dir*d0/2;%右须位置
    fright=f(xright);%右须位置函数值
    x=round(x-step*dir*sign(fleft-fright));%头在空间中的变化(往小的一边走)//sign:fleft>fright->1,fleft=fright->0;else->-1
    f=f(x);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if f<fbest%改为找最小值
        xbest=x;
        fbest=f;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x_store=cat(2,x_store,[i;x;f]);
    fbest_store=[fbest_store;fbest];
    display([num2str(i),':xbest=[',num2str(xbest'),'],fbest=',num2str(fbest)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %迭代后步长的变化
    if(cas==1)
        step=step*eta;%case 1:choose step=step*eta;
    else
        temp=temp*eta;%case 2: choose temp=temp*eta; step=temp+step0;
        step=temp+step0;%case 2
    %lambda=2; step=1/(i^lambda)+step0;%case 3 Levy flight
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
fbest1=fbest;%最优解
loc=xbest;%最优值的位置

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%数据可视化
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure,
%clf(1),
%plot(x_store(1,:),x_store(end,:),'r-o')
plot(x_store(1,:),fbest_store,'r-o')
hold on

grid on
plot(x_store(1,:),fbest_store,'b-.')
xlabel('iteration')
ylabel('minimum value')
%title(['initstep0=',num2str(step0)]);
hold on

end

function fbest=f(x)%x：列向量手数
global  theta %协方差矩阵
global  S p
X = x';%(行向量)交易手数向量
%display(['传出来的手数值=[',num2str(X),']'])
X1 = (100*X.*p)/S; %风投比例向量
x0  = (S - 100*sum(X.*p))/S; %无风险投资比例
%X = [];%表示整个投资组合持有的n 种股票的投资比例向量
M = 10^8;%惩罚因子是一个很大的数


fbest = X1*theta*X1' + M*((max(0,yueshu1(X,x0)))^2 + (max(0,yueshu2(X,x0)))^2 + (max(0,-min(x))).^2+ (max(0,-min(x0))).^2);

end