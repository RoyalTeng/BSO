function fbest=fmin(x)%x������������
global  theta %Э�������
global  S p
X = x;%(������)������������
X1 = (100*X.*p)/S; %��Ͷ��������
x0  = (S - 100*sum(X.*p))/S; %�޷���Ͷ�ʱ���

%X = [];%��ʾ����Ͷ����ϳ��е�n �ֹ�Ʊ��Ͷ�ʱ�������
M = 10^10;%�ͷ�������һ���ܴ����

fbest = X1*theta*X1' + M*((max(0,yueshu1(X,x0)))^2 + (max(0,yueshu2(X,x0)))^2 + (max(0,-min(x))).^2+ (max(0,-min(x0))).^2);
end