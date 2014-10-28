function [prediction,evidence,alpha,beta,gamma,UnReducedParameters] = PolyPredict(PolyOrder)

global TrainingData
global ValidationData
global TestData

DimTraining=size(TrainingData);
DimValidation=size(ValidationData);
DimTest=size(TestData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% X values
Xtrain=TrainingData(:,1:(DimTraining(2)-1));

MeanX=mean([Xtrain;ValidationData;TestData]);
StdX=std([Xtrain;ValidationData;TestData]);

logMeanX=mean(log2([Xtrain;ValidationData;TestData]));
logStdX=std(log2([Xtrain;ValidationData;TestData]));

%sqrtMeanX=mean(sqrt([Xtrain;ValidationData;TestData]));
%sqrtStdX=std(sqrt([Xtrain;ValidationData;TestData]));

%gauXtrain=exp(-(1/2)*((Xtrain-repmat(MeanX,DimTraining(1),1))./repmat(StdX,DimTraining(1),1)).^2);
%gauXvalid=exp(-(1/2)*((ValidationData-repmat(MeanX,DimValidation(1),1))./repmat(StdX,DimValidation(1),1)).^2);

%sigXtrain=sigmf((Xtrain-repmat(MeanX,DimTraining(1),1))./repmat(StdX,DimTraining(1),1),[1 0]);
%sigXvalid=sigmf((ValidationData-repmat(MeanX,DimValidation(1),1))./repmat(StdX,DimValidation(1),1),[1 0]);

logXtrain=(log2(Xtrain)-repmat(logMeanX,DimTraining(1),1))./repmat(logStdX,DimTraining(1),1);
logXvalid=(log2(ValidationData)-repmat(logMeanX,DimValidation(1),1))./repmat(logStdX,DimValidation(1),1);

%sqrtXtrain=(sqrt(Xtrain)-repmat(sqrtMeanX,DimTraining(1),1))./repmat(sqrtStdX,DimTraining(1),1);
%sqrtXvalid=(sqrt(ValidationData)-repmat(sqrtMeanX,DimValidation(1),1))./repmat(sqrtStdX,DimValidation(1),1);

tanhXtrain=tanh((Xtrain-repmat(MeanX,DimTraining(1),1))./repmat(StdX,DimTraining(1),1));
tanhXvalid=tanh((ValidationData-repmat(MeanX,DimValidation(1),1))./repmat(StdX,DimValidation(1),1));

%Xtrain=(Xtrain-repmat(MeanX,DimTraining(1),1))./repmat(StdX,DimTraining(1),1);
%Xvalid=(ValidationData-repmat(MeanX,DimValidation(1),1))./repmat(StdX,DimValidation(1),1);

Xtrain=[logXtrain tanhXtrain];
Xvalid=[logXvalid tanhXvalid];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% T values
T=TrainingData(:,DimTraining(2));
MT=repmat(mean(T),DimTraining(1),1);
StdT=repmat(std(T),DimTraining(1),1);

Ttrain=(T-MT)./StdT;

MTvalid=repmat(mean(T),DimValidation(1),1);
StdTvalid=repmat(std(T),DimValidation(1),1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Model & Prediction
[Model,evidence,alpha,beta,gamma,UnReducedParameters]=LinearRegressor(Xtrain,Ttrain,'poly',PolyOrder);

PhiValid=DesignMatrix(Xvalid,'poly',PolyOrder);

prediction=(PhiValid*Model).*StdTvalid + MTvalid;

save PolyPrediction.csv prediction -ASCII

end