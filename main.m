clc
clear all
close all

global yuqi_shou  %����Ԥ�ڵ�������
yuqi_shou = 0.06;
choose = 3;%ѡ�����ĸ����룬1����ţ�룬2������Ⱥ��3����ţ��+����Ⱥ

 tic
if (choose ==1)
   
    bas_main(80,200)   %bas_main(N,yp)��ţ����������Ԥ�ܴ��� 0.00043916
    
else if(choose ==2)
        pso_main(8000)   %pso_main(N)%��������2000  0.00093747
    else
        psob_main(4000)  %psob_main(N)%��������2000  0.00027624
    end
end
toc

