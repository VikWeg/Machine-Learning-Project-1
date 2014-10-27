function [reducedPhi,reducedV] = ReducePhi(Phi)

[~,S,V]=svd(Phi);
Svalues=diag(S)';

Mreduced=min(length(Svalues),round(1/(-(1/(length(Svalues)-1)*log(Svalues(1,end)/Svalues(1,1))))));

reducedV=V(:,1:Mreduced);

reducedPhi=Phi*reducedV;

end