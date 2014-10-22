function [m,ev,a,b,g]=LinearRegressor(X,T,basis,M,varargin)
%X is Nx(# of features)
%T is Nx1

N=length(X);

a=1e-6;
b=1e-6;
g=1e-6;

if isempty(varargin)
   Phi=DesignMatrix(X,basis,M);%NxMeff matrix
elseif strcmp(varargin{1},'NoOffset')
    Phi=DesignMatrix(X,basis,M,'NoOffset');%NxMeff matrix
end

Meff=size(Phi);

PhiT=Phi';%MeffxN matrix
PhiTPhi=(Phi')*Phi; %MeffxM matrix

L=eig(PhiTPhi);%Meffx1 vector

eps=1;while eps>10^-5

    Si=a*eye(Meff(2))+b*PhiTPhi;

    m=Si\(b*PhiT*T);%Mx1 vector

    gold=g;
    g=sum(b*L./(b*L+a));
 
    a=g/(m'*m);
    b=(N-g)/sum((T-Phi*m).^2);
    
    eps=abs(g-gold)/gold;
       end
       
ev=Evidence(a,b,m,Si,Phi,T);

end

function ev = Evidence(a,b,m,Si,Phi,T)

M=length(m);
N=length(T);
d=det(Si);en=E(a,b,m,Phi,T);
ev=(M/2)*log(a)+(N/2)*log(b)-E(a,b,m,Phi,T)-(1/2)*log(det(Si))-(N/2)*log(2*pi);

end

function e = E(a,b,m,Phi,T)

e=(b/2)*norm(T-Phi*m)^2+(a/2)*(m')*m;

end