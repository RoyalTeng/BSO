
%����Э�������
function [thetal,p,r] = suan_xiefangcha()
 format short
kdxf = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\�ƴ�Ѷ��','J26:J34');%�ƴ�Ѷ����������
p_kdxf = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\�ƴ�Ѷ��','D26:D34');%ȡ���ҵ���12�ܵĹɼ�
pa_kdxf = mean(p_kdxf(:))%�ɼ�ƽ��ֵ
a_kdxf = mean(kdxf(:))%������ƽ��ֵ

zksg = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\�п����','J33:J41');%�п����
p_zksg = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\�п����','D33:D41');%�п����
pa_zksg = mean(p_zksg(:))
a_zksg = mean(zksg)

lcrj = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\�˳����','J33:J41');%�˳����
p_lcrj = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\�˳����','D33:D41');%�˳����
pa_lcrj = mean(p_lcrj(:))
a_lcrj = mean(lcrj(:))

jqr = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\������','J26:J34');%������
p_jqr = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\������','D26:D34');%������
pa_jqr = mean(p_jqr(:))
a_jqr = mean(jqr(:))

zdwx = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\�������','J28:J36');%�������
p_zdwx = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\�������','D28:D36');%�������
pa_zdwx = mean(p_zdwx(:))
a_zdwx = mean(zdwx(:))

hkws = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\��������','J16:J24');%��������
p_hkws = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\��������','D16:D24');%��������
pa_hkws = mean(p_hkws(:))
a_hkws = mean(hkws(:))

klww = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\������ά','J31:J39');%������ά
p_klww = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\������ά','D31:D39');%������ά
pa_klww = mean(p_klww(:))
a_klww = mean(klww(:))

lcxx = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\�˳���Ϣ','J31:J39');%�˳���Ϣ
p_lcxx = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\�˳���Ϣ','D31:D39');%�˳���Ϣ
pa_lcxx = mean(p_lcxx)
a_lcxx = mean(lcxx(:))

kdzn = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\�ƴ�����','J24:J32');%�ƴ�����
p_kdzn = xlsread('C:\Users\royal\Desktop\�زپ�ҵ\����\�ƴ�����','D24:D32');%�ƴ�����
pa_kdzn = mean(p_kdzn)
a_kdzn = mean(kdzn(:))




zhou_shou = [kdxf,zksg,lcrj,jqr,zdwx,hkws,klww,lcrj,kdzn]%��������
xiefangcha = cov(zhou_shou)
% p = [pa_kdxf-40,pa_zksg-20,pa_lcrj-20,pa_jqr,pa_zdwx,pa_hkws,pa_klww,pa_lcxx,pa_kdzn];%�۸����
% r = [a_kdxf+3,a_zksg+3,a_lcrj+3,a_jqr,a_zdwx,a_hkws,a_klww,a_lcxx,a_kdzn];%�����ʾ���                                                             
p = [26.66  24.02  23.47  pa_jqr  pa_zdwx  pa_hkws  pa_klww  pa_lcxx  pa_kdzn];
r = [0.2288  0.190  0.0679  a_jqr  a_zdwx  a_hkws  a_klww  a_lcxx  a_kdzn];


display(['��Ʊ�۸�=[',num2str(p),']'])
display(['��Ʊ������=[',num2str(r),']'])

thetal = xiefangcha;%�����Э�������
xlswrite('C:\Users\royal\Desktop\�زپ�ҵ\����\�����',thetal,'Э����','H12')
xlswrite('C:\Users\royal\Desktop\�زپ�ҵ\����\�����',p,'Э����','H5')
xlswrite('C:\Users\royal\Desktop\�زپ�ҵ\����\�����',r,'Э����','H2')

end


