function [ratio,ev,a,b] = MakePolyPrediction(selection,Order)

global TrainingData
global ValidationData
global MX MT StdX StdT

[X,T]=ExtractData(TrainingData,0,'Raw');

MX=repmat(mean(X),length(X),1);
StdX=repmat(std(X),length(X),1);

MT=repmat(mean(T),length(T),1);
StdT=repmat(std(T),length(T),1);    

[X,T]=ExtractData(TrainingData,selection,'DivideByStd');
[model,ev,a,b,g]=LinearRegressor(X,T,'poly',Order);  %offset!

ratio=g/length(model);

pred=Predictor(ValidationData,selection,'DivideByStd',model,'poly',Order);

hist(pred,50:100:11950)

end