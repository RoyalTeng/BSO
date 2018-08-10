%POS.m
function [location,fbest]=pso(choose,value,M,D)%choose：求上层还是下层，value：初始值，M：最大迭代次数，D:问题的维度
N=40;
c1=0.5;c2=2;
w=0.9;
% fitness:待优化的目标函数  
% N:粒子数目  
% c1,c2:学习因子1，学习因子2  
% w:惯性权重  
% M:最大迭代次数  
% D:问题的维数  
% xm:目标函数取最小值时的自变量值  
% fv:目标函数最小值  
% choose:为0时表示已知y=value求上层x,为1时表示已知x=value求下层y,  
% s: 罚函数法的系数  
format long;  
fitness = @(x) fmin(x); 
 
%---------初始化种群的个体-------------  
for i=1:N  %粒子数目
    for j=1:D  %问题维数
        x(i,j)=randn;  
        v(i,j)=randn;  
    end  
end
x(N,:)=value';%把自己的初始值放进去
%---------先计算各个粒子的适应度，并初始化Pi和Pg----------  
for i=1:N  
    
    p(i)=fitness(x(i,:)); %行向量 
    y(i,:)=x(i,:);  %每个粒子的初始最优解
end  

pg=x(N,:);          %pg为全局最优（取第N组作为初始全局最优）  
for i=1:(N-1);  
    if fitness(x(i,:))<fitness(pg)  
        pg=x(i,:);  
    end  
end

fbest_store = fitness(pg);
xbest_store =[0,pg,fitness(pg)];
display(['0:','xbest=[',num2str(pg),'],fbest=',num2str(fbest_store),']'])
  
%---------进入主循环，按照公式依次迭代----------  
for t=1:M  %最大迭代次数
    for i=1:N  %粒子数目
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));  
        x(i,:)=x(i,:)+v(i,:);  
        if fitness(x(i,:))<p(i)  
            p(i)=fitness(x(i,:));  
            y(i,:)=x(i,:);                                                                               
        end  
        if p(i)<fitness(pg)  
            pg=y(i,:);  
        end  
    end  
    pbest(t)=fitness(pg); 
    %论文中用了时变的惯性权重和异变学习因子
    w = 0.9 - 0.5*t/M;%惯性因子的迭代方式
    c1 = 0.5+2*t/M;
    c2 = 2 - 2*t/M;


    %xbest_store = cat(1,xbest_store,[t,y(i,:),fitness(y(i,:))]);
    xbest_store = cat(1,xbest_store,[t,pg,fitness(pg)]);
    fbest_store = cat(1,fbest_store,pbest(t));
    display([num2str(t),':xbest=[',num2str(round(pg)),'],fbest=',num2str(pbest(t))])
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%数据可视化
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure,
%clf(1),
plot(xbest_store(:,1),xbest_store(:,end),'k-o')
hold on
grid on
plot(xbest_store(:,1),fbest_store,'k-.')
xlabel('iteration')
ylabel('minimum value')
%title(['initstep0=',num2str(step0)]);
hold on

location=round(pg); 
fbest = pbest(t);