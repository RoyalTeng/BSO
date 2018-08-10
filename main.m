clc
clear all
close all

global yuqi_shou  %设置预期的收益率
yuqi_shou = 0.06;
choose = 3;%选择跑哪个代码，1：天牛须，2：粒子群，3：天牛须+粒子群

 tic
if (choose ==1)
   
    bas_main(80,200)   %bas_main(N,yp)天牛迭代次数，预跑次数 0.00043916
    
else if(choose ==2)
        pso_main(8000)   %pso_main(N)%迭代次数2000  0.00093747
    else
        psob_main(4000)  %psob_main(N)%迭代次数2000  0.00027624
    end
end
toc

