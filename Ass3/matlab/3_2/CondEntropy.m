function [H]=CondEntropy(x,M)
% function [H]=CondEntropy(x,M)
%
% This function returns the upper bounds on the entropy rate of the process
% x by computing the entropy of x, the conditional entropy of x given one
% previous value of x, and so on. It is assumed that x is a discrete-valued
% process with values in M.
%
% Inputs:  x.....random vector
%          M.....position of mass points
% Outputs: H.....entropy rate vector [H(X) H(X1|X0) H(X2|X1,X0)]
%
% Bernhard Geiger, SPSC, 2010

x=x(:);

% Entropy H(X)
p=histc(x,M)/length(x);
H=-sum(p(p~=0).*log2(p(p~=0)));

% Conditional Entropy H(X_1|X_0)
E{1}=M;
E{2}=E{1};

y=[0; x(1:end-1)];
p=hist3([x y],'edges',E)/length(x);
py=sum(p);

H=[H -sum(p(p~=0).*log2(p(p~=0)))+sum(py(py~=0).*log2(py(py~=0)))];

% Conditional Entropy H(X_2|X_1,X_0)
z=[0; y(1:end-1)];
Matrix=[x y z];

P3=zeros(length(M),length(M),length(M));
for ind=1:length(x)
    a=find(M==Matrix(ind,1),1,'first');
    b=find(M==Matrix(ind,2),1,'first');
    c=find(M==Matrix(ind,3),1,'first');
    P3(a,b,c)=P3(a,b,c)+1;
end
P3=P3./length(x);

E{1}=M; E{2}=M;
p=hist3([y z],'edges',E)/length(x);

HYZ=-sum(p(p~=0).*log2(p(p~=0)));
HXYZ=-sum(P3(P3~=0).*log2(P3(P3~=0)));
H=[H HXYZ-HYZ];