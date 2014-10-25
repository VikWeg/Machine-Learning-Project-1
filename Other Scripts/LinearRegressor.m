function [m,ev,a,b,g,UnreducedParameters]=LinearRegressor(X,T,basis,M)

N=length(X);

a=1e-6;
b=1e-6;
g=1e-6;

unreducedPhi=DesignMatrix(X,basis,M);

[Phi,reducedV]=ReducePhi(unreducedPhi);

PhiT=Phi';
PhiTPhi=(Phi')*Phi;
L=eig(PhiTPhi);

Mreduced=size(Phi);

eps=1;while eps>10^-5

    Si=a*eye(Mreduced(2))+b*PhiTPhi;

    m=Si\(b*PhiT*T);

    gold=g;
    g=sum(b*L./(b*L+a));
 
    a=g/(m'*m);
    b=(N-g)/sum((T-Phi*m).^2);
    
    eps=abs(g-gold)/gold;
    end
       
ev=Evidence(a,b,m,Si,Phi,T);
UnreducedParameters=Mreduced(2);

m=reducedV*m;
end

function ev = Evidence(a,b,m,Si,Phi,T)

M=length(m);
N=length(T);
ev=(M/2)*log(a)+(N/2)*log(b)-E(a,b,m,Phi,T)-(1/2)*log(det(Si))-(N/2)*log(2*pi);

end

function e = E(a,b,m,Phi,T)

e=(b/2)*norm(T-Phi*m)^2+(a/2)*(m')*m;

end