%����da��������������Ծ���
%����Դ��ı�ǩ��Ϣ�����������Ծ���D
%--------------------------------------------------
%24-29�У�ʵ����������Ϣʱ������ӷ�
%-------------------------------------------------
%d(i,j)= 1; if xi,xj�� Xl and xi,xj�� different classes
%d(i,j) = 0 ;others
%L is Ŀ��ֵ��ͨ����length of X_lable,X_L[X_S_L,X_T_L]
function DS = constructS_D(Xs_lable,X,para)

L = para.num;
alfa = para.alfa;
lambda=para.lambda;
%���������Ծ���S�������Ծ���D
%
S = constructS(Xs_lable,L);
D = constructD(Xs_lable,L);
options = [];
options.NeighborMode = 'KNN';
options.k = para.K;
options.WeightMode = 'Binary';
W = constructW(X,options);
W = full(W)+S;%�޼ල��KNN���ɵ�0-1 + ��ǩ���ƶȾ���s
[r,c]= size (W);
for i= 1:r
    for j = 1:c
        if W(i,j)== 2
            W(i,j) = 1;
        end
    end
    
end


DS =lambda*W +alfa*D;%ds������������ϢҲ�з�����
end





function [D] = constructD(Xs_lable,L)

Xs_length = length(Xs_lable);
D_S = zeros(Xs_length,Xs_length);%���ݱ�ǩ���ȴ���һ��1����ķ���
for i = 1:Xs_length
    for j = 1: Xs_length
        if Xs_lable(i) ~=Xs_lable(j)
            D_S(i,j)=1;
        end
            
    end    
    
end 
% d = [D_S, zeros(Xs_length,L - Xs_length)];%���㽫�����겹ȫ��Ŀ��ֵ
% D = [d; zeros(L - Xs_length,L)];%�������겹ȫ��Ŀ��ֵ

D = blkdiag(D_S,zeros(L - Xs_length,L - Xs_length));%��D_s������һ������󰴶Խ��߷ź�

end
%����Դ��ı�ǩ��Ϣ���������Ծ���s
%S�����Ծ�������������֣�
%s1 ����Դ��ı�ǩ�������
%s(i,j)= 1; if xi,xj�� Xs and xi,xj�� same classes
%s(i,j) = 0 ;others
%s2 ���ú˺��������׺;���
%LΪ�ܵı�ǩ��
%alfa ��ϵ����������s1�����Ծ���S2�������Ծ���Ĺ�ϵ
function [s] = constructS(Xs_lable,L)
%��ʼ��L = para.L;
Xs_length = length(Xs_lable);
s1 = zeros(Xs_length,Xs_length);%���ݱ�ǩ���ȴ���һ��1����ķ���
%������ʱ�������ڵ���constructW

%����S1
for i = 1:Xs_length
    for j = 1: Xs_length
        if Xs_lable(i) == Xs_lable(j)
            s1(i,j)=1;
        end
            
    end    
    
end
%����S,s1= [s1,0;0,0],S2 = [SU,0;0,0]
%�������S2Ϊ�գ�����0���󼴿�
s= blkdiag(s1,zeros(L - Xs_length,L - Xs_length));
% S2 = blkdiag(s2,zeros(L - length(s2),L - length(s2)));         
% s = S1-alfa*S2;%��s1,s2�ʶԽ�����
% % s= blkdiag(s1,s2);

end





