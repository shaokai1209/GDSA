%����Դ��ı�ǩ��Ϣ�����������Ծ���D
%d(i,j)= 1; if xi,xj�� Xl and xi,xj�� different classes
%d(i,j) = 0 ;others
%L is Ŀ��ֵ��ͨ����length of X_lable,X_L[X_S_L,X_T_L]
function [A1,D] = constructD(Xs_lable,para)
L = para.num;
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
A1 = diagS (D);
end

function A1 = diagS (D)
%������������Ϣ�ĶԽǾ���
    [mFea,nSmp]=size(D);
    DCol = full(sum(D,2));
   A1 = spdiags(DCol,0,nSmp,nSmp);
end


