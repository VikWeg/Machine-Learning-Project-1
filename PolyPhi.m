function Phi = PolyPhi(x,X,basis,M)

if strcmp('poly',basis)

mx=mean(X);
sx=std(X);
absx=sqrt(sum(((x-mx)./sx).^2));

Phi=zeros(1,M); %returns 1xM vector

i=0;while i<M
    Phi(i+1)=absx^i;
    i=i+1;
    end
    
else Phi=0;

end
