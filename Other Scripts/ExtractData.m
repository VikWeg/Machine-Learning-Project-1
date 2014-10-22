function [X,T] = ExtractData(data,PCAselection,scaling,varargin)

if isempty(varargin)
    p=0;
elseif strcmp(varargin{1},'ForPrediction')
    p=1;
end


dim=size(data)+[0,p];

if strcmp('Raw',scaling)

%Extract X
    X=data(1:dim(1),1:(dim(2)-1));
%returns Nx(# of features)

%Extract T
    dim=size(data);
    T=data(1:dim(1),dim(2));
 %returns Nx1
    
elseif strcmp('DivideByStd',scaling)
    
%max=[8 160 80 80 160 16 8 32000 1024 32 1024 1024 8000 36];
%Max=repmat(max,dim(1),1);
    
    X=data(1:dim(1),1:(dim(2)-1));
    
    
    if p
        
    global MX StdX
    X=(1e-1)*(X-MX)./StdX;
    
    else
        
    Std=repmat(std(X),length(X),1);
    Mx=repmat(mean(X),length(X),1);
    
    X=(1e-1)*(X-Mx)./Std;          
    end
    
    covX=cov(X);
    [eigvec,~]=eig(covX);
    project=eigvec(1:(dim(2)-1),(dim(2)-PCAselection):(dim(2)-1))';
    X=(project*(X'))';
    
%Extract T

    T=data(1:dim(1),dim(2)-p);
    MT=repmat(mean(T),length(T),1);
    StdT=repmat(std(T),length(T),1);
    
    T=(T-MT)./StdT;
%returns Nx1

    

end