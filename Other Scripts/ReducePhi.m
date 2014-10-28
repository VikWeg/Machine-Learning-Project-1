function [reducedPhi,reducedV] = ReducePhi(Phi)

%%% ReducePhi only necessary if number of parameters is large, else it will just cut
%%% down the model and make it too simple.

[~,S,V]=svd(Phi);
Svalues=diag(S)';

%%% "A" controls how many singular values you take into account.
%%% Basically,the larger A, the more singular values are kept.

A=100;

Mreduced=min(length(Svalues),round(A/(-(1/(length(Svalues)-1)*log(Svalues(1,end)/Svalues(1,1))))));

reducedV=V(:,1:Mreduced);

reducedPhi=Phi*reducedV;

end