%����Դ��ı�ǩ��Ϣ���������Ծ���s
%S�����Ծ�������������֣�
%s1 ����Դ��ı�ǩ�������
%s(i,j)= 1; if xi,xj�� Xs and xi,xj�� same classes
%s(i,j) = 0 ;others
%s2 ���ú˺��������׺;���
%LΪ�ܵı�ǩ��
%alfa ��ϵ����������s1�����Ծ���S2�������Ծ���Ĺ�ϵ
function [A,S] = constructS(Xt,Xs_lable,para)
%��ʼ��L = para.L;

L = para.num;
Xs_length = length(Xs_lable);
s1 = zeros(Xs_length,Xs_length);%���ݱ�ǩ���ȴ���һ��0����ķ���
%constructW �Ǳ����Ϣ����W
options = [];
options.NeighborMode = 'KNN';
options.k =5;
options.WeightMode = 'Binary';
W = constructW(Xt,options);
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
S = blkdiag(s1,W);
% s= blkdiag(s1,zeros(L - Xs_length,L - Xs_length));

% S2 = blkdiag(s2,zeros(L - length(s2),L - length(s2)));         
% s = S1-alfa*S2;%��s1,s2�ʶԽ�����
% % s= blkdiag(s1,s2);
A = diagS (S);
end

function A = diagS (S)
%������������Ϣ�ĶԽǾ���
    [mFea,nSmp]=size(S);
    DCol = full(sum(S,2));
   A = spdiags(DCol,0,nSmp,nSmp);
end
