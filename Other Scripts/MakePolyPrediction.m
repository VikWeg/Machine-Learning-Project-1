function [pred,ratio,ev,a,b,comp] = MakePolyPrediction(selection,Order,transform)

global TrainingData
global ValidationData
global TestData
global MX MT StdX StdT MaxT
global inliers

DimTraining=size(TrainingData);
DimValidation=size(ValidationData);
DimTest=size(TestData);

X=ValidationData;
MX=repmat(mean(X),DimValidation(1),1);%assumes that length(train) = length(validation) !!!

T=TrainingData(1:DimTraining(1),DimTraining(2));
MT=repmat(mean(T),length(T),1);
StdT=repmat(std(T),length(T),1);
T=(T-MT)./StdT;

i=1;inliers=[];while i<=DimTraining(1)
                    if abs(T(i,1))<=2
                        inliers(end+1)=i;
                    end
                    i=i+1;
                end
           
T=TrainingData(inliers,DimTraining(2));
MT=repmat(mean(T),length(ValidationData),1);
StdT=repmat(std(T),length(ValidationData),1);

if strcmp(transform,'DivideByStd')
mt=repmat(mean(T),length(T),1);
st=repmat(std(T),length(T),1);
T=(T-mt)./st;
StdX=repmat(std(X),DimValidation(1),1);  %assumes that outlier in T is not a X outlier
elseif strcmp(transform,'DivideByMax')
MaxT=repmat(max(abs(T-MT)),length(T),1);
end

[X,~]=ExtractData(TrainingData,selection,transform);
[model,ev,a,b,g]=LinearRegressor(X,T,'poly',Order);  %offset!

ratio=g/length(model);

pred=Predictor(ValidationData,selection,transform,model,'poly',Order);
comp=(DesignMatrix(X,'poly',Order)*model).*StdT(1:length(inliers),:) + MT(1:length(inliers),:);
%hist(pred,50:100:11950)

end