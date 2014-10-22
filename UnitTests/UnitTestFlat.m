function [X,T]=UnitTestFlat()

X=zeros(11*11,2);

i=0;while i<=10
    j=0;while j<=10
    X(j+11*i+1,1:2)=[0.1*i 0.1*j];
    j=j+1;
        end
        i=i+1;
    end

T=ones(11*11,1)+normrnd(0,0.1,[11*11,1]);

end