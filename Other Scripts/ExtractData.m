function [X,T] = ExtractData(data,PCAselection,scaling,varargin)

global MX StdX

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
    
    X=data(1:dim(1),1:(dim(2)-1));
        
    if p        
    X=(X-MX)./StdX;    
    else        
    Std=repmat(std(X),length(X),1);
    Mx=repmat(mean(X),length(X),1);    
    X=(X-Mx)./Std;          
    end
    
    covX=cov(X);
    [eigvec,~]=eig(covX);
    project=eigvec(1:(dim(2)-1),(dim(2)-PCAselection):(dim(2)-1))';
    X=(project*(X'))';
    
%Extract T
    T=data(1:dim(1),dim(2)-p);
    MT=repmat(mean(T),length(T),1);
    StdT=repmat(std(T),length(T),1);   
    T=(T-MT)./StdT;%returns Nx1

elseif strcmp('DivideByMax',scaling)
    
    X=data(1:dim(1),1:(dim(2)-1));
    
    if p    
    X=(X-MX)./repmat(max(abs(X-MX)),length(X),1);    
    else        
    Mx=repmat(mean(X),length(X),1);    
    X=(X-Mx)./repmat(max(abs(X-Mx)),length(X),1);          
    end
    
    covX=cov(X);
    [eigvec,~]=eig(covX);
    project=eigvec(1:(dim(2)-1),(dim(2)-PCAselection):(dim(2)-1))';
    X=(project*(X'))';
    
%Extract T
    T=data(1:dim(1),dim(2)-p);
    MT=repmat(mean(T),length(T),1); 
    T=(T-MT)./repmat(max(abs(T-MT)),length(T),1);  ;%returns Nx1
    
end 

end