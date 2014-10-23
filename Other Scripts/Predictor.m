function prediction = Predictor(data,PCAselection,scaling,model,modelname,varargin)

global MT StdT MaxT

if isempty(varargin)
    M=length(model);
else
    M=varargin{1};
end

[X,~]=ExtractData(data,PCAselection,scaling,'ForPrediction');

if strcmp('Raw',scaling)
    prediction=DesignMatrix(X,modelname,M)*model;
elseif strcmp('DivideByStd',scaling)
    prediction=(DesignMatrix(X,modelname,M)*model).*StdT + MT;
elseif strcmp('DivideByMax',scaling)
    prediction=(DesignMatrix(X,modelname,M)*model).*MaxT + MT;
end

save Prediction.csv prediction -ASCII

end