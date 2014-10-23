function TestPoly(selection,order,transform)

global TrainingData
DimTrain=size(TrainingData);

figure
tit='selection=%d order=%d ratio=%1.2f ev=%4.1f L=%6.1f';

i=selection(1,1);while i<=selection(1,2)
        j=order(1,1);while j<=order(1,2)
        
                        [prediction,evidence,alpha,beta,gamma,NumberOfParameters]=MakePolyPrediction(i,j,transform);
                        
                        subplot(selection(1,2)-selection(1,1)+1,order(1,2)-order(1,1)+1,(i-selection(1,1))*order(1,2)+j-order(1,1)+1)
                        
                        hist(pred,50:100:10000);                   
                        title(sprintf(tit,i,j,ratio,ev,a/b))
                        
                        hold on
                        hist(comp,50:100:10000);
                        hist(TrainingData(1:DimTrain(1),DimTrain(2)),50:100:10000);
                        h=findobj(gca,'Type','patch');
                        set(h(1),'FaceColor','b','EdgeColor','w','facealpha',0.5)
                        set(h(2),'FaceColor','g','EdgeColor','w','facealpha',0.5)
                        set(h(3),'FaceColor','r','EdgeColor','w','facealpha',0.5)
                        hold off
                        
                        j=j+1;
                     end
                i=i+1;
                end
end