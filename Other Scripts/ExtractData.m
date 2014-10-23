function [X,T] = ExtractData(data,PCAselection,scaling,varargin)

global MX StdX inliers

if isempty(varargin)
    p=0;
elseif strcmp(varargin{1},'ForPrediction')
    p=1;
end


dim=size(data)+[0,p];

if strcmp('Raw',scaling)


    X=data(1:dim(1),1:(dim(2)-1));
    if p==0
    T=data(1:dim(1),dim(2));
    else
    T=zeros(1,dim(2)-1);
    end

    
elseif strcmp('DivideByStd',scaling)
        
    if p 
    X=data(1:dim(1),1:(dim(2)-1));
    X=0.1*(X-MX)./StdX;    
    else
    X=data(inliers,1:(dim(2)-1));    
    Std=repmat(std(X),length(X),1);
    Mx=repmat(mean(X),length(X),1);    
    X=0.1*(X-Mx)./Std;
    end
  
    covX=cov(X);
    [eigvec,~]=eig(covX);
    project=eigvec(1:(dim(2)-1),(dim(2)-PCAselection):(dim(2)-1))';
    X=(project*(X'))';
    
%Extract T
    if p==0
        
    T=data(1:dim(1),dim(2)-p);
    MT=repmat(mean(T),length(T),1);
    StdT=repmat(std(T),length(T),1);   
    T=(T-MT)./StdT;%returns Nx1
    
    %trim data from outliers in T    
    i=1;delete=[];while i<=dim(1)
                    if abs(T(i,1))>2.0
                        delete(end+1)=i;
                    end
                    i=i+1;
                 end
    T(delete,:)=[];
    
    else
    T=zeros(dim(1),dim(2));
    end

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
    T=(T-MT)./repmat(max(abs(T-MT)),length(T),1);  %returns Nx1
    
end 

end


