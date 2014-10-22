function PlotEvidence(selection,basis,M,varargin)

global TrainingData
[X,T]=ExtractData(TrainingData,selection,'DivideByStd');

if isempty(varargin)

Ev=1:(M+1);    
    
i=0;while i<=M
    [~,ev,~,~,~]=LinearRegressor(X,T,basis,i);
    Ev(1,i+1)=ev;
    i=i+1;
    end   

plot(1:(M+1),Ev)

elseif strcmp(varargin{1},'NoOffset')
    
Ev=1:M;    
    
i=1;while i<=M
    [~,ev,~,~,~]=LinearRegressor(X,T,basis,i,'NoOffset');
    Ev(1,i)=ev;
    i=i+1;
    end
    
plot(1:M,Ev)

end

end