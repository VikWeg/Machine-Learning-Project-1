function prediction = Predictor(data,PCAselection,scaling,model,modelname,varargin)

global MT StdT

if isempty(varargin)
    M=length(model);
else
    M=varargin{1};
end

[X,~]=ExtractData(data,PCAselection,scaling,'ForPrediction');

if strcmp('Raw',scaling)
    prediction=DesignMatrix(X,modelname,M)*model;
elseif strcmp('DivideByStd',scaling)
    prediction=(DesignMatrix(X,modelname,M)*model).*StdT + MT;  %Offset!
end

save Prediction.csv prediction -ASCII

end