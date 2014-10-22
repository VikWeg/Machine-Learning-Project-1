function PolyPhi = PolyProd(x,m)
%returns all multinomials of order m
%x must be nx1
%PolyProd returns 1xMeff vector PolyPhi = {phi_1(x),phi_2(x),...,phi_Meff(x)}
%where Meff = nchoosek(n-1+m,m) with n the number of features
%e.g. n=2,m=2 {x1x1, x1x2, x2x2}

global N
N=length(x);

if m==0
PolyPhi=1;
elseif m==1
    PolyPhi=x;
else
    
global index
index=1:m;
global n
n=1;

M=nchoosek(N-1+m,m);

global Phi
Phi=zeros(1,M);

while index(1,1)<=N
PolyProd2(x,m-1,index(1,1),2)
index(1,1)= index(1,1)+1;
end

PolyPhi=Phi;
end
end



    function PolyProd2(x,m,k,i)
    global N
    global index
    if m>1
    index(1,i)=k;
    while index(1,i)<=N
        PolyProd2(x,m-1,index(1,i),i+1)
    index(1,i)= index(1,i)+1;
    end
    else
      index(1,i)=k;
      PolyProd3(x,k,i)  
    end
    end

    function PolyProd3(x,k,i)
    global N
    global index
    global Phi
    global n
    index(1,i)=k;
    while index(1,i)<=N
        Phi(1,n)=prod(x(index));
        n=n+1;
        index(1,i)=index(1,i)+1;
    end
    end

    
        