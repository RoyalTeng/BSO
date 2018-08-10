function [fbest1,loc]=bas(n,N,cas,k)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ʼ������
c=10;%ratio between step and d0
%n=N;%iterations
%k=20;%space dimension
%x=1*rand(k,1)%intial value��ʼ��λ��
%global x
x = n';%����������8֧��Ʊ�ı�������ת��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�������ʼ������
eta=0.95;%case1�Ĳ���
if(cas==1)
    step=6;%case 1?choose step=step*eta; initial step set as the largest input range
else
    step=12;%case 2: choose temp=temp*eta; step=temp+step0; for step size with a minimal resolution
    step0=0.05;%case 2 %for step size with a minimal resolution
    temp=step-step0;%case 2 %for step size with a minimal resolution
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�ҳ��ĵ�һ�����Ž�
xbest=x;
fbest=f(xbest);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%������ʱ�洢����
fbest_store=fbest;
x_store=[0;x;fbest];%%%%%%%%%%%%%%%%%%%%%%%
display(['0:','xbest=[',num2str(xbest'),'],fbest=',num2str(fbest)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%iteration��ʼ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d0=step/c;%����֮��ľ���
for i=1:N
    dir=rands(k,1);%ͷ��kά�ռ�ĳ����������
    dir=dir/(eps+norm(dir));%����������һ��,����
    xleft=x+dir*d0/2;%�ռ�������λ�����
    fleft=f(xleft);%����λ�õĺ���ֵ
    xright=x-dir*d0/2;%����λ��
    fright=f(xright);%����λ�ú���ֵ
    x=round(x-step*dir*sign(fleft-fright));%ͷ�ڿռ��еı仯(��С��һ����)//sign:fleft>fright->1,fleft=fright->0;else->-1
    f=f(x);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if f<fbest%��Ϊ����Сֵ
        xbest=x;
        fbest=f;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x_store=cat(2,x_store,[i;x;f]);
    fbest_store=[fbest_store;fbest];
    display([num2str(i),':xbest=[',num2str(xbest'),'],fbest=',num2str(fbest)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %�����󲽳��ı仯
    if(cas==1)
        step=step*eta;%case 1:choose step=step*eta;
    else
        temp=temp*eta;%case 2: choose temp=temp*eta; step=temp+step0;
        step=temp+step0;%case 2
    %lambda=2; step=1/(i^lambda)+step0;%case 3 Levy flight
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
fbest1=fbest;%���Ž�
loc=xbest;%����ֵ��λ��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���ݿ��ӻ�
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

function fbest=f(x)%x������������
global  theta %Э�������
global  S p
X = x';%(������)������������
%display(['������������ֵ=[',num2str(X),']'])
X1 = (100*X.*p)/S; %��Ͷ��������
x0  = (S - 100*sum(X.*p))/S; %�޷���Ͷ�ʱ���
%X = [];%��ʾ����Ͷ����ϳ��е�n �ֹ�Ʊ��Ͷ�ʱ�������
M = 10^8;%�ͷ�������һ���ܴ����


fbest = X1*theta*X1' + M*((max(0,yueshu1(X,x0)))^2 + (max(0,yueshu2(X,x0)))^2 + (max(0,-min(x))).^2+ (max(0,-min(x0))).^2);

end