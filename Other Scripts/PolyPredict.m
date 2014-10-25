function [prediction,evidence,alpha,beta,gamma,UnReducedParameters] = PolyPredict(PolyOrder)

global TrainingData
global ValidationData
global TestData

DimTraining=size(TrainingData);
DimValidation=size(ValidationData);
DimTest=size(TestData);

Xtrain=TrainingData(:,1:(DimTraining(2)-1));

T=TrainingData(:,DimTraining(2));
MT=repmat(mean(T),DimTraining(1),1);
StdT=repmat(std(T),DimTraining(1),1);
Ttrain=(T-MT)./StdT;

MX=mean([Xtrain;ValidationData;TestData]);
StdX=std([Xtrain;ValidationData;TestData]);

Xtrain=(Xtrain-repmat(MX,DimTraining(1),1))./repmat(StdX,DimTraining(1),1).^2;
Xvalid=(ValidationData-repmat(MX,DimValidation(1),1))./repmat(StdX,DimValidation(1),1).^2;

MTvalid=repmat(mean(T),DimValidation(1),1);
StdTvalid=repmat(std(T),DimValidation(1),1);

[Model,evidence,alpha,beta,gamma,UnReducedParameters]=LinearRegressor(Xtrain,Ttrain,'poly',PolyOrder);

PhiValid=DesignMatrix(Xvalid,'poly',PolyOrder);

prediction=(PhiValid*Model).*StdTvalid + MTvalid;

save PolyPrediction.csv prediction -ASCII

end