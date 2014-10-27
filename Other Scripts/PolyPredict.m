function [prediction,evidence,alpha,beta,gamma,UnReducedParameters] = PolyPredict(PolyOrder)

global TrainingData
global ValidationData
global TestData
global I
I=importdata('C:\Users\honi\Documents\MATLAB\IndexList.csv')';

DimTraining=size(TrainingData);
DimValidation=size(ValidationData);
DimTest=size(TestData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% X values
Xtrain=TrainingData(:,1:(DimTraining(2)-1));

MeanX=mean([Xtrain;ValidationData;TestData]);
StdX=std([Xtrain;ValidationData;TestData]);

MedianX=median([Xtrain;ValidationData;TestData]);
MaxX=max(abs([Xtrain;ValidationData;TestData]));

Xtrain=(Xtrain-repmat(MeanX,DimTraining(1),1))./repmat(StdX,DimTraining(1),1).^2;
%Xtrain=[Xtrain sqrt(sum(Xtrain'.^2))'.^-1];
Xvalid=(ValidationData-repmat(MeanX,DimValidation(1),1))./repmat(StdX,DimValidation(1),1).^2;
%Xvalid=[Xvalid sqrt(sum(Xvalid'.^2))'.^-1];

%Xtrain=(Xtrain-repmat(MedianX,DimTraining(1),1))./repmat(MaxX,DimTraining(1),1);
%Xvalid=(ValidationData-repmat(MedianX,DimValidation(1),1))./repmat(MaxX,DimValidation(1),1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% T values
T=TrainingData(:,DimTraining(2));
MT=repmat(mean(T),DimTraining(1),1);
StdT=repmat(std(T),DimTraining(1),1);
Ttrain=(T-MT)./StdT;

MTvalid=repmat(mean(T),DimValidation(1),1);
StdTvalid=repmat(std(T),DimValidation(1),1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Model & Prediction
[Model,evidence,alpha,beta,gamma,UnReducedParameters]=LinearRegressor(Xtrain,Ttrain,'poly',PolyOrder);

%[~,I]=sort(abs(Model));
%save IndexList.csv I -ASCII

PhiValid=DesignMatrix(Xvalid,'poly',PolyOrder);

prediction=(PhiValid(:,I(1,11129:11628))*Model).*StdTvalid + MTvalid;

save PolyPrediction.csv prediction -ASCII

end