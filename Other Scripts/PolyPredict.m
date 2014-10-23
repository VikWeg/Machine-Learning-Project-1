function prediction = PolyPredict(PCAselection,PolyOrder)

%[prediction,evidence,alpha,beta,gamma,NumberOfParameters]

global TrainingData
global ValidationData
global TestData

DimTraining=size(TrainingData);
DimValidation=size(ValidationData);
DimTest=size(TestData);

Xtrain=TrainingData(:,1:(DimTraining(2)-1));
MXtrain=repmat(mean(Xtrain),DimTraining(1),1);
StdXtrain=repmat(std(Xtrain),DimTraining(1),1); 
Xtrain=0.1*(Xtrain-MXtrain)./StdXtrain;

T=TrainingData(:,DimTraining(2));
MT=repmat(mean(T),DimTraining(1),1);
StdT=repmat(std(T),DimTraining(1),1);
Ttrain=(T-MT)./StdT;

%[V,~]=eig(Xtrain'*Xtrain);

%Vreduced=V(:,(DimValidation(2)-PCAselection+1):DimValidation(2));
%Xreduced=Xtrain*Vreduced;

[Model,~,~,~,~]=LinearRegressor(Xtrain,Ttrain,'poly',PolyOrder);

%model=Vreduced*reducedModel;

MXvalid=repmat(mean(ValidationData),DimValidation(1),1);
StdXvalid=repmat(std(ValidationData),DimValidation(1),1); 
Xvalid=0.1*(ValidationData-MXvalid)./StdXvalid;

%[V2,val2]=eig(Xvalid'*Xvalid);

MTvalid=repmat(mean(T),DimValidation(1),1);
StdTvalid=repmat(std(T),DimValidation(1),1);

prediction=(DesignMatrix(Xvalid,'poly',PolyOrder)*Model).*StdTvalid + MTvalid;

save PolyPrediction.csv prediction -ASCII

end