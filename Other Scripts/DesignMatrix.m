function PhiMatrix = DesignMatrix(X,basis,M)


dim=size(X);
N=dim(1);
n=dim(2);

if strcmp('poly',basis)
% M is degree of multinomial
%'poly': returns NxMeff matrix
 

m=zeros(1,M+2);
m(1,1)=0;

i=0;while i<=M
    m(1,i+2)=nchoosek(n-1+i,i);
    i=i+1;
    end

mcum=cumsum(m);
    
PhiMatrix=zeros(N,sum(m));
    
    i=1;while i<=N
        j=0;while j<=M
            PhiMatrix(i,(mcum(1,j+1)+1):mcum(1,j+2)) = PolyProd(X(i,1:n),j);
            j=j+1;
            end
        i=i+1;
        end
  
else PhiMatrix=0;
end



end