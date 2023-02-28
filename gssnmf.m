function [U,V,obj]=gssnmf(X,D,para,A,S)
% X in d \times N
%JIA_YUHENG Semi-Supervised Non-Negative Matrix Factorization With Dissimilarity and Similarity Regularization
%%%-------------------------------------------------------------------------------
%%%input:
%   X = [Xl,Xu]��
%   Xl is labled,and Xu is unlabled X(d,n)
%   D is a Matrix based on lable information
%   para is parameter,which includ :
%       maxiter:
%       K: number of hidden factors
%       mu: Similarity coefficient
%       lambda: Coefficient of dissimilarity
%   A(n*n) is a diagonal matrix with its diagonal element   
%    A��i��i��= sum(S(i,j)) ��J�к�
%�²⣺ S�ǶԽǾ��� ���Ͻ�Ϊs1Ϊ��ǩ����������Ծ������½�Ϊs2��Ϊ������׺;���

%   W��
%       2.w����S
%%%output:
%       U ������
%       V �������
%       objĿ�꺯��
%ͼ�İ�ල�Ǹ�����ֽ�



lambda=para.lambda;  % the hyper papramter lambda
%��������ϵ��
k=para.k;
maxiter=para.maxiter;
mu=para.mu;%������ϵ��

d=size(X,1);
n=size(X,2);


L=A-S;

% init ��ʼ��
U=rand(d,k);
V=rand(k,n);
V1 = EuDist2(V');
%  obj(1)=sum(sum((X-U*V).^2))+lambda*sum(sum((D.*(V'*V)).^2))+mu*trace(V*L*V');
obj(1)=sum(sum((X-U*V).^2))+lambda*sum(sum((D.*(V'*V)).^2))+mu*norm((S.*V1),1);
for iter=1:maxiter
    U=U.*((X*V')./(U*V*V'+eps));
    V=V.*((U'*X+mu*V*S)./(U'*U*V+lambda*V*D+mu*V*A+eps));
    Z=X-U*V;

    % normization
    V=V.*(repmat(sum(U,1)',1,n));
    U=U./(repmat(sum(U,1),d,1));
    obj(iter+1)=sum(sum(Z).^2)+lambda*sum(sum((D.*(V'*V)).^2))+mu*norm((S.*V1),1);
%    obj(iter+1)=sum(sum(Z).^2)+lambda*sum(sum((D.*(V'*V)).^2))+mu*trace(V*L*V');
%     disp(['the ', num2str(iter), ' obj is ', num2str(obj(iter))]);
    if (abs(obj(iter+1)-obj(iter))<10^-3)
        break;
    end
end