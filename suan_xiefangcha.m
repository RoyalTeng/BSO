
%计算协方差矩阵
function [thetal,p,r] = suan_xiefangcha()
 format short
kdxf = xlsread('C:\Users\royal\Desktop\重操旧业\数据\科大讯飞','J26:J34');%科大讯飞周收益率
p_kdxf = xlsread('C:\Users\royal\Desktop\重操旧业\数据\科大讯飞','D26:D34');%取出找到的12周的股价
pa_kdxf = mean(p_kdxf(:))%股价平均值
a_kdxf = mean(kdxf(:))%收益率平均值

zksg = xlsread('C:\Users\royal\Desktop\重操旧业\数据\中科曙光','J33:J41');%中科曙光
p_zksg = xlsread('C:\Users\royal\Desktop\重操旧业\数据\中科曙光','D33:D41');%中科曙光
pa_zksg = mean(p_zksg(:))
a_zksg = mean(zksg)

lcrj = xlsread('C:\Users\royal\Desktop\重操旧业\数据\浪潮软件','J33:J41');%浪潮软件
p_lcrj = xlsread('C:\Users\royal\Desktop\重操旧业\数据\浪潮软件','D33:D41');%浪潮软件
pa_lcrj = mean(p_lcrj(:))
a_lcrj = mean(lcrj(:))

jqr = xlsread('C:\Users\royal\Desktop\重操旧业\数据\机器人','J26:J34');%机器人
p_jqr = xlsread('C:\Users\royal\Desktop\重操旧业\数据\机器人','D26:D34');%机器人
pa_jqr = mean(p_jqr(:))
a_jqr = mean(jqr(:))

zdwx = xlsread('C:\Users\royal\Desktop\重操旧业\数据\浙大网新','J28:J36');%浙大网新
p_zdwx = xlsread('C:\Users\royal\Desktop\重操旧业\数据\浙大网新','D28:D36');%浙大网新
pa_zdwx = mean(p_zdwx(:))
a_zdwx = mean(zdwx(:))

hkws = xlsread('C:\Users\royal\Desktop\重操旧业\数据\海康威视','J16:J24');%海康威视
p_hkws = xlsread('C:\Users\royal\Desktop\重操旧业\数据\海康威视','D16:D24');%海康威视
pa_hkws = mean(p_hkws(:))
a_hkws = mean(hkws(:))

klww = xlsread('C:\Users\royal\Desktop\重操旧业\数据\昆仑万维','J31:J39');%昆仑万维
p_klww = xlsread('C:\Users\royal\Desktop\重操旧业\数据\昆仑万维','D31:D39');%昆仑万维
pa_klww = mean(p_klww(:))
a_klww = mean(klww(:))

lcxx = xlsread('C:\Users\royal\Desktop\重操旧业\数据\浪潮信息','J31:J39');%浪潮信息
p_lcxx = xlsread('C:\Users\royal\Desktop\重操旧业\数据\浪潮信息','D31:D39');%浪潮信息
pa_lcxx = mean(p_lcxx)
a_lcxx = mean(lcxx(:))

kdzn = xlsread('C:\Users\royal\Desktop\重操旧业\数据\科大智能','J24:J32');%科大智能
p_kdzn = xlsread('C:\Users\royal\Desktop\重操旧业\数据\科大智能','D24:D32');%科大智能
pa_kdzn = mean(p_kdzn)
a_kdzn = mean(kdzn(:))




zhou_shou = [kdxf,zksg,lcrj,jqr,zdwx,hkws,klww,lcrj,kdzn]%周收益率
xiefangcha = cov(zhou_shou)
% p = [pa_kdxf-40,pa_zksg-20,pa_lcrj-20,pa_jqr,pa_zdwx,pa_hkws,pa_klww,pa_lcxx,pa_kdzn];%价格矩阵
% r = [a_kdxf+3,a_zksg+3,a_lcrj+3,a_jqr,a_zdwx,a_hkws,a_klww,a_lcxx,a_kdzn];%收益率矩阵                                                             
p = [26.66  24.02  23.47  pa_jqr  pa_zdwx  pa_hkws  pa_klww  pa_lcxx  pa_kdzn];
r = [0.2288  0.190  0.0679  a_jqr  a_zdwx  a_hkws  a_klww  a_lcxx  a_kdzn];


display(['股票价格=[',num2str(p),']'])
display(['股票收益率=[',num2str(r),']'])

thetal = xiefangcha;%算出了协方差矩阵
xlswrite('C:\Users\royal\Desktop\重操旧业\数据\最后结果',thetal,'协方差','H12')
xlswrite('C:\Users\royal\Desktop\重操旧业\数据\最后结果',p,'协方差','H5')
xlswrite('C:\Users\royal\Desktop\重操旧业\数据\最后结果',r,'协方差','H2')

end


